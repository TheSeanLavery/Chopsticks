```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-HQBIJM : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

IterationCount=5  WarmupCount=2  

```
| Method                   | Mean         | Error      | StdDev      | Gen0   | Allocated |
|------------------------- |-------------:|-----------:|------------:|-------:|----------:|
| Resolve_Singleton_Cached |     9.077 ns |   1.798 ns |   0.4668 ns |      - |         - |
| Resolve_1000x_Throughput | 9,349.746 ns | 896.051 ns | 232.7015 ns |      - |         - |
| Deregister_SingleLookup  |    64.326 ns |   5.332 ns |   0.8251 ns | 0.0088 |     168 B |
| CanProvide_Check         |     5.285 ns |   2.345 ns |   0.3628 ns |      - |         - |
