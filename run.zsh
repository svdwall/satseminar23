docker build -t sat_tests .
docker run --name test_bench sat_tests bash run_benchmarks.sh benchmarks/\*
docker cp test_bench:/tmp/build/results.csv .
