#!/usr/bin/awk -f

# Match lines where the first non-space characters are ';;'
/^[[:space:]]*;;/ {
    # Copy the original line and strip its leading whitespace
    line = $0
    sub(/^[[:space:]]*/, "", line)
    print line

    # Extract the trailing [N]
    pos = match(line, /\[[0-9]+\][[:space:]]*$/)
    if (pos == 0)
        next

    # Extract digits inside [N]
    tmp = substr(line, RSTART + 1, RLENGTH - 2)
    count = tmp + 0

    # Print the next N lines, each with leading whitespace removed
    for (i = 1; i <= count; i++) {
        if (getline > 0) {
            out = $0
            sub(/^[[:space:]]*/, "", out)
            print out
        }
    }
}

