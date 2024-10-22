#!/bin/bash

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
