
quote() {
    #Riccardo Galli - stackoverflow.com
    sed 's/[]\.|$(){}?+*^]/\\&/g' <<< "$*"
}

exists() {
    if [ $(docker images | awk '{print $1":"$2}' | grep -x "$(quote $1)") ]; then
        echo "y"
    else
        echo "n"
    fi
}

remove_image() {
    if [ $(docker ps -a | grep Exit) ]; then
        docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm
    fi
    docker rmi -f $1
}


