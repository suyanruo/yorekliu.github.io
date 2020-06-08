#!/bin/bash
        
doCommit() {
    git checkout mkdocs

    rm -rf site

    mkdocs build

    echo ">>>>>>> copying CNAME & README.md"
    
    cp README.md site/
    cp CNAME site/

    echo ">>>>>>> build in mkdocs branch success"

    git checkout master

    rm -rf docs/ mkdocs.yml serve.sh

    echo ">>>>>>> copy site to root .."
    cp -a site/* .
    echo ">>>>>>> copy site to root success"

    git add .

    echo ">>>>>>> ready commit in master"
    echo ">>>>>>> exec git status ."

    git status .

    echo ">>>>>>> exec commit"
    git commit -m 'deploy from mkdocs'

    git push 

    git checkout mkdocs

    rm -rf site/
}

read -r -p "Are you sure to deploy? [Y/N] " input

case $input in
    [Yy][Ee][Ss]|[Yy])
        doCommit
        ;;
    
    [Nn][Oo]|[Nn])
        ;;
        
    *)
        ;;
esac
