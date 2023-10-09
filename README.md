# SatSeminar 23

## Results

The full results are in [collected_results](./collected_results):

| Name | correctly_answered | incorrectly_answered | timeouts | exception | 
|-|-|-|-|-|
| natalia | 52 | 0 | 9| 0| 54| 
| benjamin | 19| 27| 15| 0| -112|
| thies | 7| 5| 11| 38| -16 |

* results per file are in [results.csv](./results.csv)
* satisfiability references are in [references.csv](./references.csv)

## Benchmark Set

* [inductive inference](./bench/inductive-inference.tar.gz) (41 instances): From [SATLIB](https://www.cs.ubc.ca/~hoos/SATLIB/benchm.html), one of the few non-randomly generated
* [pidgeon hole](./bench/php.tar.gz) (20 instances): Generated from [CNFgen](https://massimolauria.net/cnfgen/), based on the pidgeon hole principle: Can you assign X pidgeons into Y holes, when each hole can only be used by one pidgeon?

## Running the Benchmark yourself

### Requirements 
* [Docker](https://www.docker.com) installed and deamon running.
* python3 for merging the results

### Running

```bash
$ rm ./results.csv
$ ./run.sh
$ python3 collect_results.py
```
