for file in $@
do
    echo "=> z3 -dimacs $file"
    res=$(z3 -dimacs $file)

    echo $res | grep -w SATISFIABLE &> /dev/null
    if [[ $? == 0 ]]
    then
        echo SAT
        echo "$file, SAT" >> references.csv
    else
        echo UNSAT
        echo "$file, UNSAT" >> references.csv
    fi
done
