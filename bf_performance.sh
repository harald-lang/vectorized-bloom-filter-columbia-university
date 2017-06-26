#!/bin/bash
echo "k,h,m,performance [cycles/query]";

sel=0.99

for k in `seq 1 7`; do
    result=`REPEAT_CNT=1000 numactl -i 0 --physcpubind=0 ./vectorized_bloom_filter 16384 16384 32K $k $sel 1 2>&1`
    perf=`echo "$result" | grep "SIMD double" | grep "cycles/outer tuple" | awk '{print $3}'`
    echo "$k,-1,262144,$perf"
done

for k in `seq 1 7`; do
    result=`REPEAT_CNT=10000 numactl -i 0 --physcpubind=0 ./vectorized_bloom_filter 16384 16384 256K $k $sel 1 2>&1`
    perf=`echo "$result" | grep "SIMD double" | grep "cycles/outer tuple" | awk '{print $3}'`
    echo "$k,-1,2097152,$perf"
done

for k in `seq 1 7`; do
    result=`REPEAT_CNT=10000 numactl -i 0 --physcpubind=0 ./vectorized_bloom_filter 16384 16384 32M $k $sel 1 2>&1`
    perf=`echo "$result" | grep "SIMD double" | grep "cycles/outer tuple" | awk '{print $3}'`
    echo "$k,-1,268435456,$perf"
done

for k in `seq 1 7`; do
    result=`REPEAT_CNT=10000 numactl -i 0 --physcpubind=0 ./vectorized_bloom_filter 16384 16384 64M $k $sel 1 2>&1`
    perf=`echo "$result" | grep "SIMD double" | grep "cycles/outer tuple" | awk '{print $3}'`
    echo "$k,-1,536870912,$perf"
done

for k in `seq 1 7`; do
    result=`REPEAT_CNT=10000 numactl -i 0 --physcpubind=0 ./vectorized_bloom_filter 16384 16384 128M $k $sel 1 2>&1`
    perf=`echo "$result" | grep "SIMD double" | grep "cycles/outer tuple" | awk '{print $3}'`
    echo "$k,-1,1073741824,$perf"
done
