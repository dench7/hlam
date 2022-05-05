#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
WITHOU_COLOR='\033[0m'
DELEGATOR_ADDRESS='uptick1p39ja82y0ghkta8aqud7zegm7q3gkaspswp8we'
VALIDATOR_ADDRESS='uptickvaloper1p39ja82y0ghkta8aqud7zegm7q3gkasprk5nz4'
PWD='Zenit1703'
CHAINID=uptick_7776-1
DELAY=3200 #in secs - how often restart the script 
ACC_NAME=dench7 #example: = ACC_NAME=wallet_qwwq_54
NODE=http://localhost:26657 #change it only if you use another rpc port of your node

for (( ;; )); do
        echo -e "Get reward from Delegation"
        echo -e "${PWD}\ny\n" | uptickd tx distribution withdraw-all-rewards --from ${ACC_NAME} --fees 1555auptick --chain-id ${CHAINID} --yes
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOUT_COLOR} sec\r" $timer
                sleep 1
        done

        BAL=$(uptickd query bank balances ${DELEGATOR_ADDRESS} --node ${NODE});
        # BAL=$(($BAL -100000))
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} uatolo\n"
        echo -e "Claim rewards\n"
        echo -e "${PWD}\n${PWD}\n" | uptickd tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --chain-id ${CHAINID} --from ${ACC_NAME} --node ${NODE} --commission -y --fees 1555auptick
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done
        BAL=$(uptickd query bank balances ${DELEGATOR_ADDRESS} --node ${NODE} -o json | jq -r '.balances | .[].amount');
        BAL=$(($BAL -100000))
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} auptick\n"
        echo -e "Stake ALL 11111\n"
        echo -e "${PWD}\n${PWD}\n" | uptickd tx staking delegate ${VALIDATOR_ADDRESS} ${BAL}auptick --chain-id ${CHAINID} --from ${ACC_NAME} --node ${NODE} -y --fees 1555auptick
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done       

done
