#!/bin/bash

# Определяем функцию для мониторинга дискового пространства и количества свободных inode
function monitor_disk_space {
    while true; do
        
        # Получаем текущую дату и время
        time=$(date +"%Y-%m-%d_%H:%M:%S")
        date=$(date +"%Y-%m-%d")

        # Паратметры утилизации диского пространства
        disk_have=$(df -h | tail -n 1 | awk '{print $2}')
        disk_avaiable=$(df -h | tail -n 1 | awk '{print $3}')

        # Паратметры утилизации inode
        inode_have=$(df -h -i | tail -n 1 | awk '{print $2}')
        inode_avaliable=$(df -h -i | tail -n 1 | awk '{print $3}')

        # Создаем файл для хранения данных мониторинга
        file="/tmp/disk_space_${date}.csv"

        # Добавляем данные в файл мониторинга
        echo "$time,$disk_have,$disk_avaiable,$inode_have,$inode_avaliable" >> "$file"

        sleep 10 # Задержка между проверками
    done
}

function status {
    pgrep -f "monitor_disk_space"
    if [ $# -eq 0 ]; then
        echo "Мониторинг запущен."
    else
        echo "Мониторинг не запущен."
    fi
}

if [ "$1" == "START" ]; then
    echo "Запуск мониторинга..."
    monitor_disk_space &
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
