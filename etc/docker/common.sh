
quote() {
    #Riccardo Galli - stackoverflow.com
    sed 's/[]\.|$(){}?+*^]/\\&/g' <<< "$*"
}

image_exists() {
    if [ $(docker images | awk '{print $1":"$2}' | grep -x "$(quote $1)") ]; then
        echo 1
    else
        echo 0
    fi
}

fail_if_image_exists() {
    if [ $(image_exists $1) -eq 1 ]; then
        echo "Image '$1' exists. $2"
        exit 1
    fi
    exit 0
}

remove_image() {
    docker ps -a | grep Exited > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm
    fi
    image_exists "$1" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        docker rmi -f "$1"
    fi
}


