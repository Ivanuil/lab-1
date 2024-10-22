#!/bin/bash

function status {
    process_count=$(ps -ef | grep "bash monitor.sh" | grep -v "grep" | wc -l)
    if [ $process_count -eq 1 ]; then
        echo "Мониторинг запущен."
    else
        echo "Мониторинг не запущен."
    fi
}

if [ "$1" == "START" ]; then
    echo "Запуск мониторинга..."
    (bash monitor.sh) &
    pid=$!
    echo "$pid"
elif [ "$1" == "STOP" ]; then
    kill $2
    echo "Мониторинг остановлен."
elif [ "$1" == "STATUS" ]; then
    status
else
    echo "Неизвестная команда."
fi

exit 0
