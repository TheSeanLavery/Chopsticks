```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-BDZQWE : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

IterationCount=5  WarmupCount=2  

```
| Method                        | Mean      | Error    | StdDev    | Gen0   | Allocated |
|------------------------------ |----------:|---------:|----------:|-------:|----------:|
| Exceptions_SingleException    |  5.470 ns | 5.346 ns | 0.8272 ns | 0.0030 |      56 B |
| Exceptions_MultipleExceptions | 10.891 ns | 9.734 ns | 2.5280 ns | 0.0017 |      32 B |
