action=$1
case $action in 
    start)
    echo -e "\e[32m rabbit MQ started \e[0m"
    ;;
    stop)
    echo "rabbit MQ stopped"
    ;;
    restart)
    echo "rabbit MQ restarted"
    ;;
    *)
    echo " onlt aviable options are start, stop and restart"
    ;;
esac    