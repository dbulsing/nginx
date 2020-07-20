#!/bin/sh
#####   NOME:		mon_services.sh
#####   VERSÃO:		1.0
#####   DESCRIÇÃO:	Monitora se tem algum servico down e gera aviso por e-mail.
#####   DT CRIAÇÃO:	19/07/2020
#####   ESCRITO POR:	Diego Bulsing
#####   E-MAIL:		diegobulsing@gmail.com
#####   DISTRO:		Ubuntu 18.04.4 LTS
#####	DEPENDENCIAS:	jq, mailutils


##########################
#       VARIAVEIS        #
##########################
URI='http://ec2-100-25-152-214.compute-1.amazonaws.com/index.html'
TMP_FILE='/tmp/services_down'
MESSAGE='/tmp/message'
EMAILS='fulano@gmail.com'

#########################
#        FUNCOES        #
#########################

send_email(){

	mail -s "SERVIÇOS COM PROBLEMAS!!!" $EMAILS < $MESSAGE
	rm $MESSAGE

}

make_message(){

	while read SERVICE
	do
		echo "Serviço $SERVICE está parado!" >> $MESSAGE
	done < $TMP_FILE

	rm $TMP_FILE
}

check_services() {

	JSON=`curl $URI`
	echo $JSON | jq .[] | jq -r 'to_entries[] | select (.value == "down") | .key' > $TMP_FILE
	if [ -z $TMP_FILE ]
        then
                exit 0
        fi
	
}

#########################
#         MAIN          #
#########################

main(){

	check_services

	make_message

	send_email

}

main
