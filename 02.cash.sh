action=$1
case $action in 
    start)
    echo " rabbit MQ started"
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