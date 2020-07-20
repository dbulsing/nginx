#!/bin/sh
#!/bin/sh
#####   NOME:           get_jar_file.sh
#####   VERSÃO:         1.0
#####   DESCRIÇÃO:      Busca arquivos de atualizacao Java e realiza o deploy no servidor.
#####   DT CRIAÇÃO:     18/07/2020
#####   ESCRITO POR:    Diego Bulsing
#####   E-MAIL:         diegobulsing@gmail.com
#####   DISTRO:         Ubuntu 18.04.4 LTS


##########################
#       VARIAVEIS        #
##########################

HOST='ec2-100-25-152-214.compute-1.amazonaws.com'
USER='system_java'
PASS='PASSWORD'
JAR_PATH='/opt/aplicacao/'
JAR_FILE_NAME='Aplicacao.jar'
JAR_FILE=$JAR_PATH$JAR_FILE

#########################
#        FUNCOES        #
#########################

get_file_name() {

        ftp -n $HOST << EOF

        quote user $USER
        quote PASS $PASS

        nlist input
        bye
EOF
}

get_file() {

	ftp -n $HOST << EOF

	quote user $USER
	quote PASS $PASS

	get $FILE_NAME 
	bye
EOF
}

change_jar() {

	kill -9 `ps aux | grep "java -jar" | awk '{print $2}' | head -n 1`

	rm -f $JAR_FILE_NAME
	
	cp $FILE_NAME $JAR_FILE_NAME
	
	java -jar $JAR_FILE_NAME

}

rename_file_ftp(){

	ftp -n $HOST << EOF

        quote user $USER
        quote PASS $PASS

        rename $FILE_NAME $SUCCESS_DEPLOY 
        bye
EOF
}

#########################
#         MAIN          #
#########################

main(){

	get_file_name > /tmp/file_name
	FILE_NAME=`cat /tmp/file_name`

	if [ $FILE_NAME -z ]
	then
		exit 0
	fi
	rm /tmp/file_name

	get_file

	change_jar

	SUCCESS_DEPLOY=`echo "$FILE_NAME" | sed 's/input/success_deploy/g'`

	rename_file_ftp
}


main
