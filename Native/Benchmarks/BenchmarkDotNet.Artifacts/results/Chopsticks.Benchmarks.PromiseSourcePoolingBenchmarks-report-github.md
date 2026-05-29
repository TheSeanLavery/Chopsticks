```

BenchmarkDotNet v0.14.0, Windows 11 (10.0.26200.8457)
Unknown processor
.NET SDK 9.0.314
  [Host]     : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  Job-BDLTLX : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2
  ShortRun   : .NET 9.0.16 (9.0.1626.22923), X64 RyuJIT AVX2

WarmupCount=3  

```
| Method                                            | Job        | IterationCount | LaunchCount | VectorCount | Mean         | Error         | StdDev        | Gen0     | Allocated  |
|-------------------------------------------------- |----------- |--------------- |------------ |------------ |-------------:|--------------:|--------------:|---------:|-----------:|
| **&#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;**    | **Job-BDLTLX** | **10**             | **Default**     | **100**         | **6,735.875 μs** |    **10.4574 μs** |     **6.2230 μs** |        **-** |        **3 B** |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | Job-BDLTLX | 10             | Default     | 100         |   895.431 μs |    37.1019 μs |    24.5406 μs | 807.6172 | 15200000 B |
| &#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;    | ShortRun   | 3              | 1           | 100         | 6,567.446 μs |   338.6200 μs |    18.5609 μs |        - |        1 B |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | ShortRun   | 3              | 1           | 100         |   977.987 μs | 1,626.5209 μs |    89.1551 μs | 807.6172 | 15200000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;**    | **Job-BDLTLX** | **10**             | **Default**     | **1000**        | **6,767.300 μs** |   **208.0835 μs** |   **123.8271 μs** |        **-** |        **3 B** |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | Job-BDLTLX | 10             | Default     | 1000        | 1,008.526 μs |   219.1536 μs |   144.9566 μs | 806.6406 | 15200001 B |
| &#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;    | ShortRun   | 3              | 1           | 1000        | 6,819.348 μs |   266.3086 μs |    14.5973 μs |        - |        3 B |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | ShortRun   | 3              | 1           | 1000        | 1,134.213 μs |   502.8519 μs |    27.5630 μs | 806.6406 | 15200001 B |
| **&#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;**    | **Job-BDLTLX** | **10**             | **Default**     | **10000**       | **6,777.622 μs** |   **261.7598 μs** |   **155.7691 μs** |        **-** |        **3 B** |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | Job-BDLTLX | 10             | Default     | 10000       | 1,123.447 μs |    57.7267 μs |    38.1826 μs | 807.6172 | 15200000 B |
| &#39;HandleAsyncPromiseSource - Pooled (100K ops)&#39;    | ShortRun   | 3              | 1           | 10000       | 7,087.407 μs | 2,906.4239 μs |   159.3109 μs |        - |        3 B |
| &#39;HandleAsyncPromiseSource - New (100K ops)&#39;       | ShortRun   | 3              | 1           | 10000       | 1,106.468 μs |   315.0647 μs |    17.2698 μs | 806.6406 | 15200001 B |
| **&#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **100**         |   **728.984 μs** |    **85.5884 μs** |    **56.6114 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | Job-BDLTLX | 10             | Default     | 100         |   115.989 μs |     6.1875 μs |     4.0926 μs |  80.5664 |  1520000 B |
| &#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;     | ShortRun   | 3              | 1           | 100         |   679.680 μs |    14.6111 μs |     0.8009 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | ShortRun   | 3              | 1           | 100         |   112.098 μs |    11.7600 μs |     0.6446 μs |  80.6885 |  1520000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **688.638 μs** |     **7.1431 μs** |     **4.7247 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | Job-BDLTLX | 10             | Default     | 1000        |   131.058 μs |    22.5184 μs |    14.8946 μs |  80.6885 |  1520000 B |
| &#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;     | ShortRun   | 3              | 1           | 1000        |   805.335 μs |   369.1188 μs |    20.2326 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | ShortRun   | 3              | 1           | 1000        |   126.191 μs |    42.9418 μs |     2.3538 μs |  80.5664 |  1520000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **829.195 μs** |    **53.9830 μs** |    **32.1244 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | Job-BDLTLX | 10             | Default     | 10000       |   122.092 μs |     5.5522 μs |     3.3040 μs |  80.6885 |  1520000 B |
| &#39;HandleAsyncPromiseSource - Pooled (10K ops)&#39;     | ShortRun   | 3              | 1           | 10000       |   829.869 μs |   569.2342 μs |    31.2016 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (10K ops)&#39;        | ShortRun   | 3              | 1           | 10000       |   125.265 μs |   104.1694 μs |     5.7099 μs |  80.6885 |  1520000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **100**         |    **78.633 μs** |     **2.9772 μs** |     **1.7717 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | Job-BDLTLX | 10             | Default     | 100         |    14.461 μs |     3.1405 μs |     2.0772 μs |   8.0719 |   152000 B |
| &#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;      | ShortRun   | 3              | 1           | 100         |    78.787 μs |    88.3581 μs |     4.8432 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | ShortRun   | 3              | 1           | 100         |    12.712 μs |    19.1567 μs |     1.0500 μs |   8.0719 |   152000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **103.456 μs** |    **17.4900 μs** |    **11.5685 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | Job-BDLTLX | 10             | Default     | 1000        |    13.387 μs |     3.3059 μs |     2.1866 μs |   8.0566 |   152000 B |
| &#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;      | ShortRun   | 3              | 1           | 1000        |    82.144 μs |    16.6079 μs |     0.9103 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | ShortRun   | 3              | 1           | 1000        |    12.196 μs |     2.8157 μs |     0.1543 μs |   8.0719 |   152000 B |
| **&#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |    **76.197 μs** |     **1.9706 μs** |     **1.3034 μs** |        **-** |          **-** |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | Job-BDLTLX | 10             | Default     | 10000       |    11.858 μs |     1.0115 μs |     0.5291 μs |   8.0719 |   152000 B |
| &#39;HandleAsyncPromiseSource - Pooled (1K ops)&#39;      | ShortRun   | 3              | 1           | 10000       |    76.037 μs |    53.6157 μs |     2.9389 μs |        - |          - |
| &#39;HandleAsyncPromiseSource - New (1K ops)&#39;         | ShortRun   | 3              | 1           | 10000       |    13.719 μs |    42.4314 μs |     2.3258 μs |   8.0719 |   152000 B |
| **&#39;HandlePromiseSource - Pooled (100K ops)&#39;**         | **Job-BDLTLX** | **10**             | **Default**     | **100**         | **9,745.646 μs** | **1,938.5005 μs** | **1,282.1980 μs** |        **-** |        **6 B** |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | Job-BDLTLX | 10             | Default     | 100         | 1,263.032 μs |   252.2149 μs |   166.8246 μs | 806.6406 | 15200001 B |
| &#39;HandlePromiseSource - Pooled (100K ops)&#39;         | ShortRun   | 3              | 1           | 100         | 7,477.911 μs | 1,663.1704 μs |    91.1640 μs |        - |        6 B |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | ShortRun   | 3              | 1           | 100         | 1,234.553 μs |   678.6830 μs |    37.2009 μs | 806.6406 | 15200001 B |
| **&#39;HandlePromiseSource - Pooled (100K ops)&#39;**         | **Job-BDLTLX** | **10**             | **Default**     | **1000**        | **7,710.924 μs** |   **222.2690 μs** |   **147.0172 μs** |        **-** |        **3 B** |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | Job-BDLTLX | 10             | Default     | 1000        | 1,335.207 μs |   266.1096 μs |   176.0150 μs | 806.6406 | 15200001 B |
| &#39;HandlePromiseSource - Pooled (100K ops)&#39;         | ShortRun   | 3              | 1           | 1000        | 7,345.865 μs |   853.7126 μs |    46.7949 μs |        - |        6 B |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | ShortRun   | 3              | 1           | 1000        | 1,223.282 μs | 1,501.4496 μs |    82.2995 μs | 806.6406 | 15200001 B |
| **&#39;HandlePromiseSource - Pooled (100K ops)&#39;**         | **Job-BDLTLX** | **10**             | **Default**     | **10000**       | **8,024.535 μs** | **1,029.9533 μs** |   **612.9087 μs** |        **-** |        **3 B** |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | Job-BDLTLX | 10             | Default     | 10000       | 1,191.782 μs |    19.7383 μs |    13.0556 μs | 806.6406 | 15200001 B |
| &#39;HandlePromiseSource - Pooled (100K ops)&#39;         | ShortRun   | 3              | 1           | 10000       | 7,824.605 μs | 4,744.2101 μs |   260.0462 μs |        - |        3 B |
| &#39;HandlePromiseSource - New (100K ops)&#39;            | ShortRun   | 3              | 1           | 10000       | 1,513.065 μs |   596.5303 μs |    32.6978 μs | 806.6406 | 15200001 B |
| **&#39;HandlePromiseSource - Pooled (10K ops)&#39;**          | **Job-BDLTLX** | **10**             | **Default**     | **100**         |   **827.615 μs** |   **121.8514 μs** |    **80.5972 μs** |        **-** |          **-** |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | Job-BDLTLX | 10             | Default     | 100         |   135.627 μs |    17.6183 μs |    11.6534 μs |  80.5664 |  1520000 B |
| &#39;HandlePromiseSource - Pooled (10K ops)&#39;          | ShortRun   | 3              | 1           | 100         | 1,059.410 μs | 1,349.1225 μs |    73.9500 μs |        - |        1 B |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | ShortRun   | 3              | 1           | 100         |   113.019 μs |     7.2788 μs |     0.3990 μs |  80.5664 |  1520000 B |
| **&#39;HandlePromiseSource - Pooled (10K ops)&#39;**          | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **756.743 μs** |    **54.0337 μs** |    **35.7399 μs** |        **-** |        **1 B** |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | Job-BDLTLX | 10             | Default     | 1000        |   130.441 μs |    19.5555 μs |    12.9348 μs |  80.5664 |  1520000 B |
| &#39;HandlePromiseSource - Pooled (10K ops)&#39;          | ShortRun   | 3              | 1           | 1000        |   791.707 μs |   377.3951 μs |    20.6863 μs |        - |          - |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | ShortRun   | 3              | 1           | 1000        |   139.991 μs |   265.5908 μs |    14.5579 μs |  80.5664 |  1520000 B |
| **&#39;HandlePromiseSource - Pooled (10K ops)&#39;**          | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **837.686 μs** |    **48.5344 μs** |    **28.8820 μs** |        **-** |          **-** |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | Job-BDLTLX | 10             | Default     | 10000       |   133.369 μs |    11.6808 μs |     7.7261 μs |  80.5664 |  1520000 B |
| &#39;HandlePromiseSource - Pooled (10K ops)&#39;          | ShortRun   | 3              | 1           | 10000       |   938.276 μs |   691.9161 μs |    37.9263 μs |        - |          - |
| &#39;HandlePromiseSource - New (10K ops)&#39;             | ShortRun   | 3              | 1           | 10000       |   141.869 μs |   219.7549 μs |    12.0455 μs |  80.5664 |  1520000 B |
| **&#39;HandlePromiseSource - Pooled (1K ops)&#39;**           | **Job-BDLTLX** | **10**             | **Default**     | **100**         |    **87.162 μs** |    **15.4473 μs** |    **10.2175 μs** |        **-** |          **-** |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | Job-BDLTLX | 10             | Default     | 100         |    14.565 μs |     2.4446 μs |     1.6169 μs |   8.0719 |   152000 B |
| &#39;HandlePromiseSource - Pooled (1K ops)&#39;           | ShortRun   | 3              | 1           | 100         |    93.125 μs |   225.9043 μs |    12.3826 μs |        - |          - |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | ShortRun   | 3              | 1           | 100         |    16.663 μs |    33.8986 μs |     1.8581 μs |   8.0719 |   152000 B |
| **&#39;HandlePromiseSource - Pooled (1K ops)&#39;**           | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |    **94.872 μs** |    **17.5091 μs** |    **11.5812 μs** |        **-** |          **-** |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | Job-BDLTLX | 10             | Default     | 1000        |    13.388 μs |     1.7561 μs |     1.0450 μs |   8.0719 |   152000 B |
| &#39;HandlePromiseSource - Pooled (1K ops)&#39;           | ShortRun   | 3              | 1           | 1000        |    81.575 μs |    67.9806 μs |     3.7262 μs |        - |          - |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | ShortRun   | 3              | 1           | 1000        |    12.637 μs |     5.6358 μs |     0.3089 μs |   8.0719 |   152000 B |
| **&#39;HandlePromiseSource - Pooled (1K ops)&#39;**           | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |    **93.299 μs** |    **13.1915 μs** |     **8.7254 μs** |        **-** |          **-** |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | Job-BDLTLX | 10             | Default     | 10000       |    14.371 μs |     1.1640 μs |     0.6088 μs |   8.0719 |   152000 B |
| &#39;HandlePromiseSource - Pooled (1K ops)&#39;           | ShortRun   | 3              | 1           | 10000       |   100.768 μs |    53.6066 μs |     2.9384 μs |        - |          - |
| &#39;HandlePromiseSource - New (1K ops)&#39;              | ShortRun   | 3              | 1           | 10000       |    14.606 μs |    40.6386 μs |     2.2275 μs |   8.0719 |   152000 B |
| **&#39;Large Payload - Pooled&#39;**                          | **Job-BDLTLX** | **10**             | **Default**     | **100**         |    **16.550 μs** |     **1.4233 μs** |     **0.9414 μs** |        **-** |          **-** |
| &#39;Large Payload - New&#39;                             | Job-BDLTLX | 10             | Default     | 100         |     9.625 μs |     1.8819 μs |     1.2447 μs |   0.8392 |    16000 B |
| &#39;Large Payload - Pooled&#39;                          | ShortRun   | 3              | 1           | 100         |    18.381 μs |     5.7476 μs |     0.3150 μs |        - |          - |
| &#39;Large Payload - New&#39;                             | ShortRun   | 3              | 1           | 100         |     7.720 μs |     0.7407 μs |     0.0406 μs |   0.8392 |    16000 B |
| **&#39;Large Payload - Pooled&#39;**                          | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |    **77.729 μs** |     **4.5727 μs** |     **2.7212 μs** |        **-** |          **-** |
| &#39;Large Payload - New&#39;                             | Job-BDLTLX | 10             | Default     | 1000        |    73.904 μs |     5.3098 μs |     3.5121 μs |   0.7324 |    16000 B |
| &#39;Large Payload - Pooled&#39;                          | ShortRun   | 3              | 1           | 1000        |    73.197 μs |    10.7205 μs |     0.5876 μs |        - |          - |
| &#39;Large Payload - New&#39;                             | ShortRun   | 3              | 1           | 1000        |    70.968 μs |    24.7813 μs |     1.3583 μs |   0.7324 |    16000 B |
| **&#39;Large Payload - Pooled&#39;**                          | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **810.740 μs** |   **133.2239 μs** |    **88.1194 μs** |        **-** |          **-** |
| &#39;Large Payload - New&#39;                             | Job-BDLTLX | 10             | Default     | 10000       |   701.050 μs |    23.4584 μs |    12.2692 μs |        - |    16000 B |
| &#39;Large Payload - Pooled&#39;                          | ShortRun   | 3              | 1           | 10000       |   701.744 μs |   318.4408 μs |    17.4548 μs |        - |          - |
| &#39;Large Payload - New&#39;                             | ShortRun   | 3              | 1           | 10000       |   687.515 μs |    23.1084 μs |     1.2667 μs |        - |    16000 B |
| **&#39;Real-world: TryHandle + Handle Pooled Chain&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **100**         |   **152.265 μs** |     **6.0109 μs** |     **3.5770 μs** |        **-** |          **-** |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | Job-BDLTLX | 10             | Default     | 100         |    22.883 μs |     2.8917 μs |     1.9127 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | Job-BDLTLX | 10             | Default     | 100         |   164.390 μs |    11.4464 μs |     6.8116 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | Job-BDLTLX | 10             | Default     | 100         |    23.834 μs |     5.1657 μs |     3.0741 μs |  16.1133 |   304000 B |
| &#39;Real-world: TryHandle + Handle Pooled Chain&#39;     | ShortRun   | 3              | 1           | 100         |   148.726 μs |   239.8905 μs |    13.1492 μs |        - |          - |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | ShortRun   | 3              | 1           | 100         |    19.146 μs |    34.4875 μs |     1.8904 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | ShortRun   | 3              | 1           | 100         |   134.265 μs |    22.8890 μs |     1.2546 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | ShortRun   | 3              | 1           | 100         |    17.567 μs |     2.8703 μs |     0.1573 μs |  16.1438 |   304000 B |
| **&#39;Real-world: TryHandle + Handle Pooled Chain&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **139.447 μs** |     **1.2347 μs** |     **0.8167 μs** |        **-** |          **-** |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | Job-BDLTLX | 10             | Default     | 1000        |    16.024 μs |     0.1954 μs |     0.1292 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | Job-BDLTLX | 10             | Default     | 1000        |   137.954 μs |     0.2904 μs |     0.1728 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | Job-BDLTLX | 10             | Default     | 1000        |    19.367 μs |     4.3715 μs |     2.8915 μs |  16.1438 |   304000 B |
| &#39;Real-world: TryHandle + Handle Pooled Chain&#39;     | ShortRun   | 3              | 1           | 1000        |   132.574 μs |    40.4992 μs |     2.2199 μs |        - |          - |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | ShortRun   | 3              | 1           | 1000        |    16.630 μs |    21.3749 μs |     1.1716 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | ShortRun   | 3              | 1           | 1000        |   132.192 μs |     0.3266 μs |     0.0179 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | ShortRun   | 3              | 1           | 1000        |    17.597 μs |     1.6722 μs |     0.0917 μs |  16.1438 |   304000 B |
| **&#39;Real-world: TryHandle + Handle Pooled Chain&#39;**     | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **134.348 μs** |    **12.8020 μs** |     **6.6957 μs** |        **-** |          **-** |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | Job-BDLTLX | 10             | Default     | 10000       |    15.550 μs |     0.5844 μs |     0.3056 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | Job-BDLTLX | 10             | Default     | 10000       |   161.120 μs |    27.9374 μs |    18.4788 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | Job-BDLTLX | 10             | Default     | 10000       |    18.741 μs |     1.7748 μs |     0.9283 μs |  16.1438 |   304000 B |
| &#39;Real-world: TryHandle + Handle Pooled Chain&#39;     | ShortRun   | 3              | 1           | 10000       |   130.830 μs |    16.0635 μs |     0.8805 μs |        - |          - |
| &#39;Real-world: TryHandle + Handle New Chain&#39;        | ShortRun   | 3              | 1           | 10000       |    17.054 μs |    47.0289 μs |     2.5778 μs |  16.5710 |   312000 B |
| &#39;Real-world: Async Chain Pooled&#39;                  | ShortRun   | 3              | 1           | 10000       |   138.754 μs |     4.0157 μs |     0.2201 μs |        - |          - |
| &#39;Real-world: Async Chain New&#39;                     | ShortRun   | 3              | 1           | 10000       |    22.561 μs |    99.2763 μs |     5.4417 μs |  16.1438 |   304000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39;** | **Job-BDLTLX** | **10**             | **Default**     | **100**         | **7,016.195 μs** |   **269.7474 μs** |   **160.5224 μs** |        **-** |        **6 B** |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | Job-BDLTLX | 10             | Default     | 100         | 1,149.338 μs |   218.3956 μs |   129.9637 μs | 806.6406 | 15200001 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39; | ShortRun   | 3              | 1           | 100         | 6,851.096 μs | 6,952.8937 μs |   381.1116 μs |        - |        3 B |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | ShortRun   | 3              | 1           | 100         | 1,089.314 μs |   335.0548 μs |    18.3655 μs | 806.6406 | 15200001 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39;** | **Job-BDLTLX** | **10**             | **Default**     | **1000**        | **6,912.185 μs** |    **60.6028 μs** |    **40.0850 μs** |        **-** |        **3 B** |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | Job-BDLTLX | 10             | Default     | 1000        | 1,278.170 μs |    13.6785 μs |     7.1541 μs | 806.6406 | 15200001 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39; | ShortRun   | 3              | 1           | 1000        | 8,448.677 μs | 7,261.1087 μs |   398.0059 μs |        - |        3 B |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | ShortRun   | 3              | 1           | 1000        | 1,416.108 μs | 1,372.1125 μs |    75.2101 μs | 806.6406 | 15200001 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39;** | **Job-BDLTLX** | **10**             | **Default**     | **10000**       | **7,158.611 μs** |   **129.0762 μs** |    **76.8112 μs** |        **-** |        **3 B** |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | Job-BDLTLX | 10             | Default     | 10000       | 1,252.131 μs |    45.1026 μs |    26.8398 μs | 806.6406 | 15200001 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (100K ops)&#39; | ShortRun   | 3              | 1           | 10000       | 7,347.808 μs |   308.1256 μs |    16.8894 μs |        - |        3 B |
| &#39;TryHandleAsyncPromiseSource - New (100K ops)&#39;    | ShortRun   | 3              | 1           | 10000       | 1,288.513 μs | 1,062.7790 μs |    58.2545 μs | 806.6406 | 15200001 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;**  | **Job-BDLTLX** | **10**             | **Default**     | **100**         |   **803.919 μs** |    **48.8999 μs** |    **32.3442 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | Job-BDLTLX | 10             | Default     | 100         |   140.096 μs |    11.8010 μs |     7.8057 μs |  80.5664 |  1520000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;  | ShortRun   | 3              | 1           | 100         |   802.612 μs |   277.6147 μs |    15.2170 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | ShortRun   | 3              | 1           | 100         |   155.718 μs |   160.3382 μs |     8.7887 μs |  80.5664 |  1520000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;**  | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **799.160 μs** |     **8.0926 μs** |     **4.2326 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | Job-BDLTLX | 10             | Default     | 1000        |   139.092 μs |     9.5651 μs |     5.6920 μs |  80.5664 |  1520000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;  | ShortRun   | 3              | 1           | 1000        |   795.261 μs |   169.5189 μs |     9.2919 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | ShortRun   | 3              | 1           | 1000        |   173.678 μs |   400.9788 μs |    21.9790 μs |  80.5664 |  1520000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;**  | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **816.392 μs** |    **47.8394 μs** |    **31.6428 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | Job-BDLTLX | 10             | Default     | 10000       |   153.873 μs |    11.8180 μs |     6.1811 μs |  80.5664 |  1520000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (10K ops)&#39;  | ShortRun   | 3              | 1           | 10000       |   910.265 μs | 1,859.0866 μs |   101.9028 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (10K ops)&#39;     | ShortRun   | 3              | 1           | 10000       |   153.796 μs |    81.6514 μs |     4.4756 μs |  80.5664 |  1520000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;**   | **Job-BDLTLX** | **10**             | **Default**     | **100**         |    **84.741 μs** |     **5.4981 μs** |     **3.2718 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | Job-BDLTLX | 10             | Default     | 100         |    14.329 μs |     1.4076 μs |     0.7362 μs |   8.0566 |   152000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;   | ShortRun   | 3              | 1           | 100         |   105.757 μs |   136.2760 μs |     7.4698 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | ShortRun   | 3              | 1           | 100         |    18.610 μs |    18.2729 μs |     1.0016 μs |   8.0566 |   152000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;**   | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |    **82.246 μs** |     **3.2566 μs** |     **1.7033 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | Job-BDLTLX | 10             | Default     | 1000        |    17.735 μs |     3.3473 μs |     2.2140 μs |   8.0566 |   152000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;   | ShortRun   | 3              | 1           | 1000        |    84.341 μs |    72.6073 μs |     3.9799 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | ShortRun   | 3              | 1           | 1000        |    14.138 μs |     8.4662 μs |     0.4641 μs |   8.0566 |   152000 B |
| **&#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;**   | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |    **81.260 μs** |     **4.8063 μs** |     **2.8602 μs** |        **-** |          **-** |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | Job-BDLTLX | 10             | Default     | 10000       |    14.057 μs |     1.5366 μs |     0.9144 μs |   8.0719 |   152000 B |
| &#39;TryHandleAsyncPromiseSource - Pooled (1K ops)&#39;   | ShortRun   | 3              | 1           | 10000       |    79.888 μs |     9.9711 μs |     0.5466 μs |        - |          - |
| &#39;TryHandleAsyncPromiseSource - New (1K ops)&#39;      | ShortRun   | 3              | 1           | 10000       |    13.860 μs |     1.5987 μs |     0.0876 μs |   8.0719 |   152000 B |
| **&#39;TryHandlePromiseSource - Pooled (100K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **100**         | **7,358.994 μs** | **1,239.5887 μs** |   **819.9112 μs** |        **-** |        **3 B** |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | Job-BDLTLX | 10             | Default     | 100         |   992.173 μs |   199.8148 μs |   132.1651 μs | 849.6094 | 16000000 B |
| &#39;TryHandlePromiseSource - Pooled (100K ops)&#39;      | ShortRun   | 3              | 1           | 100         | 6,514.085 μs |   942.8074 μs |    51.6785 μs |        - |        3 B |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | ShortRun   | 3              | 1           | 100         | 1,007.715 μs | 2,987.1564 μs |   163.7361 μs | 849.6094 | 16000000 B |
| **&#39;TryHandlePromiseSource - Pooled (100K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **1000**        | **6,564.469 μs** |   **344.7413 μs** |   **180.3064 μs** |        **-** |        **3 B** |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | Job-BDLTLX | 10             | Default     | 1000        |   876.670 μs |    55.2331 μs |    32.8683 μs | 849.6094 | 16000000 B |
| &#39;TryHandlePromiseSource - Pooled (100K ops)&#39;      | ShortRun   | 3              | 1           | 1000        | 6,859.342 μs | 1,894.0088 μs |   103.8170 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | ShortRun   | 3              | 1           | 1000        |   873.348 μs | 1,046.5928 μs |    57.3673 μs | 849.6094 | 16000000 B |
| **&#39;TryHandlePromiseSource - Pooled (100K ops)&#39;**      | **Job-BDLTLX** | **10**             | **Default**     | **10000**       | **6,442.889 μs** |   **235.4291 μs** |   **140.1001 μs** |        **-** |        **3 B** |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | Job-BDLTLX | 10             | Default     | 10000       |   929.626 μs |   142.4520 μs |    94.2231 μs | 849.6094 | 16000000 B |
| &#39;TryHandlePromiseSource - Pooled (100K ops)&#39;      | ShortRun   | 3              | 1           | 10000       | 6,504.453 μs | 1,777.8250 μs |    97.4486 μs |        - |        3 B |
| &#39;TryHandlePromiseSource - New (100K ops)&#39;         | ShortRun   | 3              | 1           | 10000       |   980.011 μs |   423.6632 μs |    23.2224 μs | 849.6094 | 16000000 B |
| **&#39;TryHandlePromiseSource - Pooled (10K ops)&#39;**       | **Job-BDLTLX** | **10**             | **Default**     | **100**         |   **663.589 μs** |    **16.1772 μs** |    **10.7002 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | Job-BDLTLX | 10             | Default     | 100         |    84.307 μs |     3.7505 μs |     2.4807 μs |  84.9609 |  1600000 B |
| &#39;TryHandlePromiseSource - Pooled (10K ops)&#39;       | ShortRun   | 3              | 1           | 100         |   667.371 μs |    42.9255 μs |     2.3529 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | ShortRun   | 3              | 1           | 100         |   113.932 μs |    70.9039 μs |     3.8865 μs |  84.9609 |  1600000 B |
| **&#39;TryHandlePromiseSource - Pooled (10K ops)&#39;**       | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |   **671.757 μs** |     **4.3045 μs** |     **2.8471 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | Job-BDLTLX | 10             | Default     | 1000        |    99.870 μs |     1.6745 μs |     1.1076 μs |  84.9609 |  1600000 B |
| &#39;TryHandlePromiseSource - Pooled (10K ops)&#39;       | ShortRun   | 3              | 1           | 1000        |   671.717 μs |   393.1843 μs |    21.5518 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | ShortRun   | 3              | 1           | 1000        |   101.263 μs |    27.2194 μs |     1.4920 μs |  84.9609 |  1600000 B |
| **&#39;TryHandlePromiseSource - Pooled (10K ops)&#39;**       | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |   **670.329 μs** |     **6.7646 μs** |     **4.4743 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | Job-BDLTLX | 10             | Default     | 10000       |    97.410 μs |     2.2109 μs |     1.1563 μs |  84.9609 |  1600000 B |
| &#39;TryHandlePromiseSource - Pooled (10K ops)&#39;       | ShortRun   | 3              | 1           | 10000       |   697.236 μs |    41.8472 μs |     2.2938 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (10K ops)&#39;          | ShortRun   | 3              | 1           | 10000       |   108.296 μs |    99.0897 μs |     5.4314 μs |  84.9609 |  1600000 B |
| **&#39;TryHandlePromiseSource - Pooled (1K ops)&#39;**        | **Job-BDLTLX** | **10**             | **Default**     | **100**         |    **79.550 μs** |     **2.8637 μs** |     **1.8942 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | Job-BDLTLX | 10             | Default     | 100         |    11.733 μs |     0.5129 μs |     0.3052 μs |   8.4991 |   160000 B |
| &#39;TryHandlePromiseSource - Pooled (1K ops)&#39;        | ShortRun   | 3              | 1           | 100         |    76.224 μs |    52.5443 μs |     2.8801 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | ShortRun   | 3              | 1           | 100         |    10.790 μs |     7.4196 μs |     0.4067 μs |   8.4991 |   160000 B |
| **&#39;TryHandlePromiseSource - Pooled (1K ops)&#39;**        | **Job-BDLTLX** | **10**             | **Default**     | **1000**        |    **75.411 μs** |     **1.5030 μs** |     **0.8944 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | Job-BDLTLX | 10             | Default     | 1000        |    11.792 μs |     0.7157 μs |     0.4734 μs |   8.4991 |   160000 B |
| &#39;TryHandlePromiseSource - Pooled (1K ops)&#39;        | ShortRun   | 3              | 1           | 1000        |    75.591 μs |    51.3900 μs |     2.8169 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | ShortRun   | 3              | 1           | 1000        |     8.540 μs |     1.2382 μs |     0.0679 μs |   8.4991 |   160000 B |
| **&#39;TryHandlePromiseSource - Pooled (1K ops)&#39;**        | **Job-BDLTLX** | **10**             | **Default**     | **10000**       |    **64.910 μs** |     **0.9503 μs** |     **0.5655 μs** |        **-** |          **-** |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | Job-BDLTLX | 10             | Default     | 10000       |    10.253 μs |     2.6674 μs |     1.7643 μs |   8.4991 |   160000 B |
| &#39;TryHandlePromiseSource - Pooled (1K ops)&#39;        | ShortRun   | 3              | 1           | 10000       |    68.296 μs |     4.5150 μs |     0.2475 μs |        - |          - |
| &#39;TryHandlePromiseSource - New (1K ops)&#39;           | ShortRun   | 3              | 1           | 10000       |     8.442 μs |     8.9843 μs |     0.4925 μs |   8.4991 |   160000 B |
