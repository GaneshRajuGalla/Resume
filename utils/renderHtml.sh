#!/bin/bash -ex

program_exists ()
{
    type "$1" &> /dev/null ;
}

main()
{
    set -e
    pushd $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) >/dev/null

    if ! program_exists pandoc; then
        echo "Please install pandoc (https://pandoc.org/installing.html): brew install pandoc"
        exit 1
    fi

    echo "<style>" >> tmp.css
    cat github-markdown.css >> tmp.css
    echo "</style>" >> tmp.css

    FILENAME='Ganesh Raju Galla.md'
    cp ../readme.md "$FILENAME"
    
    pandoc -s -f gfm -t html5 -H tmp.css "$FILENAME" > ../index.html

    rm "$FILENAME"
    rm tmp.css

    popd >/dev/null
}

main "$@"
