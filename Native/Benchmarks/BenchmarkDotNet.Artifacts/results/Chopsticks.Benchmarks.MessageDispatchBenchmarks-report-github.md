```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-DOYGLE : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

IterationCount=5  WarmupCount=2  

```
| Method                    | Mean         | Error      | StdDev     | Gen0    | Allocated |
|-------------------------- |-------------:|-----------:|-----------:|--------:|----------:|
| Dispatch_1Handler_Sync    |     43.88 ns |   2.101 ns |   0.546 ns |  0.0144 |     272 B |
| Dispatch_5Handlers_Sync   |     72.55 ns |   3.475 ns |   0.902 ns |  0.0144 |     272 B |
| Dispatch_1000x_Throughput | 37,414.65 ns | 404.463 ns | 105.038 ns | 14.4043 |  272000 B |
