docmd() {
    echo "\$ ${1}"
    eval "${1}"
}

bench() {
    RUNS=5
    for i in $(seq "${RUNS}"); do
        docmd "time ${1}"
        if [ "${i}" -ne "${RUNS}" ]; then echo '----------------'; fi
    done
}

echo 'System Info'
echo '==========='
sysctl -n machdep.cpu.brand_string
uname -v
printf '\n\n'

trap '{ rm -f fibonacci-25; }' EXIT

echo 'C AOT compiled with optimization -O0'
echo '===================================='
docmd 'clang -O0 -o fibonacci-25 fibonacci-25.c'
bench './fibonacci-25'
printf '\n\n'

echo 'C AOT compiled with optimization -O2'
echo '===================================='
docmd 'clang -O2 -o fibonacci-25 fibonacci-25.c'
bench './fibonacci-25'
printf '\n\n'

echo 'Sunder AOT compiled with optimization -O0'
echo '========================================='
SUNDER_CC=clang SUNDER_CFLAGS='-O0' \
docmd 'sunder-compile -o fibonacci-25 fibonacci-25.sunder'
bench './fibonacci-25'
printf '\n\n'

echo 'Sunder AOT compiled with optimization -O2'
echo '========================================='
SUNDER_CC=clang SUNDER_CFLAGS='-O2' \
docmd 'sunder-compile -o fibonacci-25 fibonacci-25.sunder'
bench './fibonacci-25'
printf '\n\n'

echo 'Sunder compiled-and-run using sunder-run with optimization -O0'
echo '=============================================================='
SUNDER_CC=clang SUNDER_CFLAGS='-O0' \
bench "sunder-run fibonacci-25.sunder"
printf '\n\n'

echo 'Sunder compiled-and-run using sunder-run with optimization -O2'
echo '=============================================================='
SUNDER_CC=clang SUNDER_CFLAGS='-O2' \
bench "sunder-run fibonacci-25.sunder"
printf '\n\n'

echo 'Lua (Standalone lua.c)'
echo '======================'
bench 'lua fibonacci-25.lua'
printf '\n\n'

echo 'Python interpreted using CPython'
echo '================================'
bench 'python3 fibonacci-25.py'
printf '\n\n'

echo 'Monkey interpreted using monkey-python.py (CPython)'
echo '==================================================='
bench 'python3 ~/sources/monkey-python/monkey.py fibonacci-25.monkey'
printf '\n\n'

echo 'Lumpy interpreted using lumpy.py (CPython)'
echo '=========================================='
bench 'python3 $LUMPY_HOME/lumpy.py fibonacci-25.lumpy'
printf '\n\n'

echo 'Lumpy interpreted using lumpy (Nuitka-compiled lumpy.py)'
echo '========================================================'
bench 'lumpy fibonacci-25.lumpy'
printf '\n\n'
