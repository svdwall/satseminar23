#!/bin/bash

timeout () {
    timeout=$1
    interval=1
    delay=0.1
    shift 1
    cmd=$@

    set +m # silence job info
    (  
        exec $@
    ) &
    pid=$!
    (
        ((t = timeout))

        while ((t > 0))
        do
            sleep $interval
            kill -0 $pid 2> /dev/null || exit 0
            ((t -= interval))
        done

        # Be nice, post SIGTERM first.
        kill -s SIGTERM $pid && kill -0 $pid 2> /dev/null|| exit 0
        sleep $delay
        kill -s SIGKILL $pid 2> /dev/null
        exit 1
    ) & 
    topid=$!
    wait $pid
    exitcode=$?
    sleep 0.3 #let the termination be completed
    wait $topid
    timeout=$?
    echo "Exit: $exitcode Timedout: $timeout"
}

testrun () {
    file_sat="./benchmarks/php_3_5.dimacs"
    file_unsat="./benchmarks/php_6_5.dimacs"

    bash ./test_natalia.sh $file_sat
    if [[ $? != 0 ]]
    then
        echo fail
    fi
    
    bash ./test_benjamin.sh $file_sat
    if [[ $? != 0 ]]
    then
        echo fail
    fi

    bash ./test_thies.sh $file_sat
    if [[ $? != 0 ]]
    then
        echo fail
    fi
    

    bash ./test_natalia.sh $file_unsat
    if [[ $? != 1 ]]
    then
        echo fail
    fi
    
    bash ./test_benjamin.sh $file_unsat
    if [[ $? != 1 ]]
    then
        echo fail
    fi

    bash ./test_thies.sh $file_unsat
    if [[ $? != 1 ]]
    then
        echo fail
    fi
}

bench () {
    to=$1
    out=$2
    shift 2

    rm $out
    touch $out
    for file in $@
    do
        for name in natalia benjamin thies
        do
            echo "=> bash ./test_${name}.sh $file | TIMEOUT $to"
            SECONDS=0
            timeout $to bash ./test_${name}.sh $file
            elapsed=$SECONDS

            if [[ $timeout != 0 ]]
            then
                echo "$file, $name, TIMEOUT, $elapsed" >> $out
            else
                case "$exitcode" in 
                    "0")
                        echo SAT
                        echo "$file, $name, SAT, $elapsed" >> $out
                        ;;
                    "1") 
                        echo UNSAT
                        echo "$file, $name, UNSAT, $elapsed" >> $out
                        ;;
                    *)
                        echo "EXCEPTION"
                        echo "$file, $name, EXCEPTION, $elapsed" >> $out
                        ;;
                esac
            fi
        done
    done

}

bench 600 results.csv $@
