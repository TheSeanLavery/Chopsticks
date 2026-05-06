using Chopsticks.Dependencies.Containers;
using Chopsticks.Dependencies.Resolutions;
using NSubstitute;

namespace SingletonResolutionTests;

public class ThreadSafety
{
    [Test]
    public void Get_ConcurrentAccess_FactoryInvokedExactlyOnce()
    {
        // Set up
        var factoryCallCount = 0;
        var container = Substitute.For<IDependencyContainer>();
        var implementation = new object();

        Func<IDependencyContainer, object> factory = _ =>
        {
            Interlocked.Increment(ref factoryCallCount);
            Thread.Sleep(10); // Simulate slow factory to increase race window
            return implementation;
        };

        var resolution = new SingletonResolution(typeof(object), factory);

        using var barrier = new Barrier(50);
        var results = new object?[50];

        // Act — 50 threads all call Get() concurrently
        var threads = Enumerable.Range(0, 50).Select(i => new Thread(() =>
        {
            barrier.SignalAndWait();
            results[i] = resolution.Get(container);
        })).ToArray();

        foreach (var t in threads) t.Start();
        foreach (var t in threads) t.Join();

        // Assert
        Assert.That(factoryCallCount, Is.EqualTo(1),
            "Factory should be invoked exactly once under concurrent access");
        Assert.That(results, Is.All.SameAs(implementation),
            "All threads should receive the same instance");
    }

    [Test]
    public void Get_ConcurrentAccess_AllThreadsGetSameInstance()
    {
        // Set up
        var container = Substitute.For<IDependencyContainer>();
        var implementation = new object();
        Func<IDependencyContainer, object> factory = _ => implementation;

        var resolution = new SingletonResolution(typeof(object), factory);

        using var barrier = new Barrier(20);
        var results = new object?[20];

        // Act
        var threads = Enumerable.Range(0, 20).Select(i => new Thread(() =>
        {
            barrier.SignalAndWait();
            results[i] = resolution.Get(container);
        })).ToArray();

        foreach (var t in threads) t.Start();
        foreach (var t in threads) t.Join();

        // Assert — all results are the same reference
        for (int i = 1; i < results.Length; i++)
        {
            Assert.That(results[i], Is.SameAs(results[0]),
                $"Thread {i} returned a different instance than thread 0");
        }
    }

    [Test]
    public void Get_AfterCreation_FastPathNoLockContention()
    {
        // Set up — pre-create the singleton
        var container = Substitute.For<IDependencyContainer>();
        var implementation = new object();
        Func<IDependencyContainer, object> factory = _ => implementation;

        var resolution = new SingletonResolution(typeof(object), factory);
        resolution.Get(container); // Pre-create

        // Act — 1,000,000 fast-path calls should complete quickly (no lock)
        var sw = System.Diagnostics.Stopwatch.StartNew();
        for (int i = 0; i < 1_000_000; i++)
        {
            resolution.Get(container);
        }
        sw.Stop();

        // Assert — should be well under 1 second for field reads
        Assert.That(sw.ElapsedMilliseconds, Is.LessThan(1000),
            "Fast path should be extremely fast (no lock acquisition)");
    }

    [Test]
    public void Dispose_ConcurrentWithGet_NoException()
    {
        // Set up
        var container = Substitute.For<IDependencyContainer>();
        var implementation = Substitute.For<IDisposable>();
        Func<IDependencyContainer, object> factory = _ => implementation;

        var resolution = new SingletonResolution(typeof(IDisposable), factory);
        resolution.Get(container); // Pre-create

        Exception? caughtException = null;

        // Act — Get and Dispose concurrently
        var getThread = new Thread(() =>
        {
            try
            {
                for (int i = 0; i < 1000; i++)
                    resolution.Get(container);
            }
            catch (Exception ex)
            {
                caughtException = ex;
            }
        });

        var disposeThread = new Thread(() =>
        {
            try
            {
                resolution.Dispose();
            }
            catch (Exception ex)
            {
                caughtException = ex;
            }
        });

        getThread.Start();
        disposeThread.Start();
        getThread.Join();
        disposeThread.Join();

        // Assert
        Assert.That(caughtException, Is.Null,
            "No exception should be thrown during concurrent Get/Dispose");
    }

    [Test]
    public void Get_ConcurrentAccess_NoLeakedInstances()
    {
        // Set up
        var createdCount = 0;
        var container = Substitute.For<IDependencyContainer>();

        Func<IDependencyContainer, object> factory = _ =>
        {
            Interlocked.Increment(ref createdCount);
            return new object();
        };

        var resolution = new SingletonResolution(typeof(object), factory);

        using var barrier = new Barrier(20);
        // Act
        var threads = Enumerable.Range(0, 20).Select(_ => new Thread(() =>
        {
            barrier.SignalAndWait();
            resolution.Get(container);
        })).ToArray();

        foreach (var t in threads) t.Start();
        foreach (var t in threads) t.Join();

        // Assert — exactly 1 instance created (no leaked duplicates)
        Assert.That(createdCount, Is.EqualTo(1),
            "Exactly 1 instance should be created, no leaked duplicates");
    }

    [Test]
    public void Get_AfterDispose_ReturnsNull_ThreadSafe()
    {
        // Set up
        var container = Substitute.For<IDependencyContainer>();
        Func<IDependencyContainer, object> factory = _ => new object();
        var resolution = new SingletonResolution(typeof(object), factory);
        resolution.Get(container); // Pre-create

        // Act
        resolution.Dispose();

        // Assert — Get after Dispose returns null
        var result = resolution.Get(container);
        Assert.That(result, Is.Null);
    }
}
