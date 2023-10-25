set -e

echo "=========== Build docker image ==========="
docker build -t sat_tests .

echo "=========== Run tests (needs deamon running) ==========="
docker run --rm --name test_bench sat_tests bash run_benchmarks.sh benchmarks/\*

echo "=========== Extract Results ==========="
rm ./results.csv
docker cp test_bench:/tmp/build/results.csv ./results.csv
