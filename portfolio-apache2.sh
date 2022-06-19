#!/bin/bash

sudo cp -R /mnt/Giga/uberserver/portfolio /var/www/html/ && echo -e '\033[32m - Проект скопирован в директорию: /var/www/html/' && sleep 1
sudo apt install apache2 -y 1> /dev/null 2>&1 && echo -e '\033[32m - Apache2 установлен, ждём конфиг.' && sleep 1

echo -e '\033[33m - Используем прежнюю ссылку на конфиг?  [Y or N]' && read answer
if [ "$answer" == "Y" ]
then
wget -O gauner.conf --no-check-certificate -q  https://drive.google.com/uc?id=1PUzRJj6QLRQ4-MqWjAdDn7RFO67QJyxv&export=download && sleep .5
else
echo -e '\033[33m - Дай ссылку на конфиг:' && read URL
ID=`echo $URL | grep -Eo '[A-Za-z0-9-]{33}'`
wget -O gauner.conf --no-check-certificate -q  https://drive.google.com/uc?id=$ID&export=download && sleep .5
fi

echo -e '\033[33m - Начинаем загрузку конфиги в директорию: /etc/apache2/sites-available/' && sleep 1
if
sudo mv $PWD/gauner.conf /etc/apache2/sites-available/ 2>/dev/null
then
echo -e "\033[32m - Конфиг загружен." && sleep 1
else
echo -e "\033[31m - Ещё не загрузился, подождём." && sleep 5 && sudo mv $PWD/gauner.conf /etc/apache2/sites-available/ && echo -e "\033[32m - Конфиг загружен." && sleep 1
fi

if
sudo systemctl start apache2 2>/dev/null && sudo systemctl enable apache2 2>/dev/null
sudo a2dissite 000-default.conf 2>/dev/null 1>&2 ; sudo a2ensite gauner.conf 2>/dev/null 1>&2
sudo systemctl reload apache2
then
echo -e "\033[32m - Проект на Apache2 успешно запущен. Проверяй локал хост или домен."
else
echo -e "\033[31m - Возникла ошибка при запуске Apache2. Посмотри логи."
fi
