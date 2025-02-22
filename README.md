# Lumpy Performance Profiling

## Setup
```sh
/path/to/lumpy-perf$ python3 -m venv .venv-lumpy-perf
/path/to/lumpy-perf$ . .venv-lumpy-perf/bin/activate
(.venv-lumpy-perf) /path/to/lumpy-perf$ python3 -m pip install -r requirements.txt
```

## Run
### Generate Report From `bench.sh`
```sh
(.venv-lumpy-perf) /path/to/lumpy-perf$ sh bench.sh >"$(date -u +%Y-%m-%d)-bench.output.txt" 2>&1 && cat "$(date -u +%Y-%m-%d)-bench.output.txt"
```

### Generate [FlameGraph](https://www.brendangregg.com/flamegraphs.html) Report For A Script
#### Using [Flameprof](https://pypi.org/project/flameprof/) Directly
```sh
(.venv-lumpy-perf) /path/to/lumpy-perf$ python -m cProfile -o output.prof "${LUMPY_HOME}/lumpy.py" SCRIPT.lumpy
(.venv-lumpy-perf) /path/to/lumpy-perf$ flameprof output.prof >output.svg
```

#### Using [Flameprof](https://pypi.org/project/flameprof/) As Input To `flamegraph.pl`
```sh
(.venv-lumpy-perf) /path/to/lumpy-perf$ python -m cProfile -o output.prof "${LUMPY_HOME}/lumpy.py" SCRIPT.lumpy
(.venv-lumpy-perf) /path/to/lumpy-perf$ flameprof --format=log output.prof | /path/to/FlameGraph/flamegraph.pl >output.svg
```

### Generate [SnakeVis](https://jiffyclub.github.io/snakeviz/) Report For A Script
```sh
(.venv-lumpy-perf) /path/to/lumpy-perf$ python -m cProfile -o output.prof "${LUMPY_HOME}/lumpy.py" SCRIPT.lumpy
(.venv-lumpy-perf) /path/to/lumpy-perf$ snakeviz output.prof
```
