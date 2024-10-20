#!/bin/bash

# Определяем функцию для мониторинга дискового пространства и количества свободных inode
function monitor_disk_space {
    while true; do
        
        # Получаем текущую дату и время
        time=$(date +"%Y-%m-%d_%H:%M:%S")
        date=$(date +"%Y-%m-%d")

        # Создаем файл для хранения данных мониторинга
        file="/tmp/disk_space_${date}.csv"

        # Получаем информацию о дисковом пространстве и количестве свободных inode
        df -h | grep -v Filesystem | awk '{print $5}'
        free -m | grep "Inode" | awk '{print $4}'

        # Добавляем данные в файл мониторинга
        echo "$(time),$(df -h | grep -v Filesystem | awk '{print $5}'),$(free -m | grep "Inode" | awk '{print $4}')" >> "$file"

        sleep 10 # Задержка между проверками
    done
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
    # if [ pgrep -f "disk_space_monitor" > /dev/null ]; then
    #     echo "Мониторинг запущен."
    # else
    #     echo "Мониторинг не запущен."
    echo "t"
else
    echo "Неизвестная команда."
fi

exit 0
