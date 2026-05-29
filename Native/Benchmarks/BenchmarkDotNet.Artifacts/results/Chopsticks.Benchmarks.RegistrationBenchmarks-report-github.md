```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-HQBIJM : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

IterationCount=5  WarmupCount=2  

```
| Method                         | Mean        | Error     | StdDev    | Gen0   | Gen1   | Allocated |
|------------------------------- |------------:|----------:|----------:|-------:|-------:|----------:|
| Register_FirstHandler          |    62.90 ns |  44.24 ns | 11.490 ns | 0.0276 |      - |     520 B |
| Register_5Handlers_Sequential  |   214.51 ns |  34.33 ns |  8.916 ns | 0.0708 | 0.0002 |    1336 B |
| Register_10Handlers_Sequential |   451.60 ns |  39.46 ns | 10.248 ns | 0.1426 | 0.0010 |    2688 B |
| Register_WithVaryingOrder      |   255.26 ns |  75.33 ns | 19.564 ns | 0.0706 |      - |    1336 B |
| AccessHandlerArray_1Handler    | 4,624.10 ns | 174.38 ns | 26.985 ns | 1.6403 |      - |   30920 B |
