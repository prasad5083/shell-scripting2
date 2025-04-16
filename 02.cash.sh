action=$1
case $action in 
    start)
    echo -e "\e[32m rabbit MQ started \e[0m"
    exit 0
    ;;
    stop)
    echo "rabbit MQ stopped"
    exit 1
    ;;
    restart)
    echo "rabbit MQ restarted"
    exit 2
    ;;
    *)
    echo " onlt aviable options are start, stop and restart"
    exit 4
    ;;
esac    