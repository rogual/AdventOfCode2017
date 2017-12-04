map-lines() {
    while read line; do
        echo $line | $*
        echo ' '
    done
}

map-words () {
    tr ' ' '\n' | map-lines $* | tr '\n' ' '
}

sort-string () {
    grep -o . | sort | tr -d '\n'
    echo ' '
}

sort-each-word () {
    map-words sort-string
}

sort-each-word-on-each-line() {
    map-lines sort-each-word
}

cat aoc4.in | sort-each-word-on-each-line | \
    egrep -v '^.*\b(\w+)\b.*\b\1\b' | wc -l
