#!/bin/bash

while true
do

# Logo
echo "==========================================================="
echo -e "\033[0;35m"
echo "                                                               ";
echo "  11      11    111111     111111   11111111      1111111      ";
echo "  111     11  11      11 11      11 11      11  11       11    ";
echo "  1111    11  11      11 11      11 11      11  11       11    ";
echo "  11 11   11  11      11 11      11 11      11  11             ";
echo "  11  11  11  11      11 11      11 11111111      1111111      ";
echo "  11   11 11  11      11 11      11 11      11           11    ";
echo "  11    1111  11      11 11      11 11      11  11       11    ";
echo "  11     111  11      11 11      11 11      11  11       11    ";
echo "  11      11    111111     111111   11111111      1111111      ";
echo "                                                               ";
echo -e "\e[0m"
echo "============================================================"


sleep 2
# Menu

PS3='Select an action: '
options=(
"Запустить Aptos"
"Поменять seed"
"Статус синхронизации"
"Логи"
"Посмотреть данные"
"Exit")
select opt in "${options[@]}"
do
case $opt in

# install

"Запустить Aptos")
echo "============================================================"
echo "Installing"
echo "============================================================"
wget -q -O install.sh https://raw.githubusercontent.com/dench7/hlam/main/install.sh && chmod +x install.sh && sudo /bin/bash install.sh

break
;;

"Поменять seed")

wget -q -O seeds.sh https://raw.githubusercontent.com/dench7/hlam/main/seeds.sh && chmod +x seeds.sh && sudo /bin/bash seeds.sh
break
;;

"Статус синхронизации")

curl 127.0.0.1:9101/metrics 2> /dev/null | grep aptos_state_sync_version | grep type
break
;;

"Логи")
docker logs -f aptos-fullnode-1 --tail 500
break
;;

"Посмотреть данные")
wget -q -O idenity.sh https://raw.githubusercontent.com/dench7/hlam/main/idenity.sh && chmod +x idenity.sh && sudo /bin/bash idenity.sh
break
;;

"Exit")
exit
;;
*) echo "invalid option $REPLY";;
esac
done
done
