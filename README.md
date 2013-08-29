ioping.sh
=========

Shell wrapper script for `ioping` disk I/O latency benchmarking.
Based on [this script](http://vbtechsupport.com/1239/): runs default and custom tests and pretty-prints results.

**Usage**

```bash
sudo su
./ioping.sh
```

**Example output**

```

Sequential disk speed test (dd)
===============================
16384+0 records in
16384+0 records out
1073741824 bytes (1.1 GB) copied, 32.6761 s, 32.9 MB/s

Disk latency tests (ioping)
===========================
Test                                        req       ms   iops   mb/s    min    avg    max   mdev 
Disk I/O rate (1024KB)                        5   4056.9     92   91.5    4.5   10.9   34.6   11.9 
Disk I/O rate (4KB)                           5   4033.7    152    0.6    0.3    6.6   19.8    8.0 
Disk I/O rate (32KB)                          5   4032.4    158    4.9    0.4    6.3   19.3    7.7 
Disk I/O rate (64KB)                          5   4029.8    172   10.8    0.6    5.8   17.0    6.7 
Disk I/O rate (256KB)                         5   4053.5     95   23.8    1.4   10.5   30.5   11.8 
Seek rate (1024KB)                          109   3017.0     37   36.5    4.5   27.4  124.7   14.1 
Seek rate (4KB)                             178   3002.0     60    0.2    0.2   16.8  192.4   20.5 
Seek rate (32KB)                            108   3014.0     36    1.1    0.3   27.8  182.5   31.7 
Seek rate (64KB)                            201   3006.6     67    4.2    0.5   14.9  138.3   12.6 
Seek rate (256KB)                            84   3002.3     28    7.0    1.3   35.6  226.8   39.5 
Sequential seek rate                         56   3015.9     19    4.7    4.3   53.7  395.2   59.5 
Sequential cached seek rate               16145   3000.1   8185 2046.2    0.0    0.1    0.7    0.0

```
