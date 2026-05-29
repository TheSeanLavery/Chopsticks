```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-XHKEKX : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

IterationCount=10  WarmupCount=3  

```
| Method                         | Categories | Mean          | Error         | StdDev        | Ratio | RatioSD | Gen0    | Allocated | Alloc Ratio |
|------------------------------- |----------- |--------------:|--------------:|--------------:|------:|--------:|--------:|----------:|------------:|
| TryHandleFireAndForget         | 1 Handler  |      22.10 ns |      3.177 ns |      1.662 ns |  0.25 |    0.03 |       - |         - |        0.00 |
| HandleSync                     | 1 Handler  |      30.20 ns |      6.916 ns |      4.575 ns |  0.34 |    0.06 |       - |         - |        0.00 |
| &#39;TryHandle (unconsumed)&#39;       | 1 Handler  |      89.13 ns |     14.887 ns |      9.847 ns |  1.01 |    0.15 |  0.0161 |     304 B |        1.00 |
| &#39;TryHandle (consumed)&#39;         | 1 Handler  |     148.74 ns |      7.438 ns |      4.920 ns |  1.69 |    0.19 |       - |         - |        0.00 |
|                                |            |               |               |               |       |         |         |           |             |
| HandleSync                     | 5 Handlers |      95.18 ns |     25.530 ns |     16.887 ns |  0.39 |    0.08 |       - |         - |        0.00 |
| TryHandleFireAndForget         | 5 Handlers |      97.03 ns |      0.447 ns |      0.234 ns |  0.39 |    0.05 |       - |         - |        0.00 |
| &#39;TryHandle (consumed)&#39;         | 5 Handlers |     225.11 ns |     24.223 ns |     12.669 ns |  0.91 |    0.12 |       - |         - |        0.00 |
| &#39;TryHandle (unconsumed)&#39;       | 5 Handlers |     249.78 ns |     36.599 ns |     24.208 ns |  1.01 |    0.15 |  0.0157 |     304 B |        1.00 |
|                                |            |               |               |               |       |         |         |           |             |
| &#39;HandleSync x1000&#39;             | Throughput |  86,267.40 ns | 12,059.333 ns |  7,176.315 ns |  0.46 |    0.08 |       - |         - |        0.00 |
| &#39;TryHandleFireAndForget x1000&#39; | Throughput |  91,449.22 ns |    354.211 ns |    185.259 ns |  0.49 |    0.08 |       - |         - |        0.00 |
| &#39;TryHandle (unconsumed) x1000&#39; | Throughput | 193,944.93 ns | 55,635.413 ns | 36,799.381 ns |  1.03 |    0.25 | 16.1133 |  304000 B |        1.00 |
| &#39;TryHandle (consumed) x1000&#39;   | Throughput | 219,725.98 ns |    934.602 ns |    488.815 ns |  1.17 |    0.18 |       - |         - |        0.00 |
