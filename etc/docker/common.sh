
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
    docker ps -a | grep Exited > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm
    fi
    if [ "$(exists $1)" = "y" ]; then
        docker rmi -f $1
    fi
}


