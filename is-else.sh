action=$1

if [ "action" == "start" ] ; then
    echo "rabbit MQ is started"
elif [ "action" == "stop"] ; then
    echo " rabbit MQ is stoped"
elif [ "action" == "restart" ] ; then
    echo " rabbit MQ is restarted"        
else
    echo "only aviable action is start--stop--restart"    
 
fi