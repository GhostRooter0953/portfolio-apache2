#!/bin/bash

if sudo apt install curl -y 1>/dev/null 2>&1 ; curl gauner.ghostrooter.keenetic.pro 1>/dev/null 2>&1
then
echo -e '\033[31m Инициируем удаление Apache2.' && sudo systemctl stop apache2 2>/dev/null ; sudo systemctl disable apache2 2>/dev/null ; sudo apt remove apache2 -y 1> /dev/null 2>>
echo -e '\033[31m Инициируем удаление конфиги и тело проекта.' && sudo rm  /etc/apache2/sites-available/gauner.conf sudo rm  -R /var/www/html/portfolio 2>/dev/null
echo -e '\033[32m Удалено.'
else
echo -e '\033[32m Нечего удалять.'
fi
