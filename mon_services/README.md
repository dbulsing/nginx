# Script de monitoramento de serviços

Este script tem como objetivo monitorar um servidor web que responde pelo status de serviços.

Foi escrito em shell script.

Será agendado para ser executado a cada 2 minutos via CRON.

```sh
0/2  0  *  *  *  root  /bin/bash '/caminho/mon_services.sh'
```

O script consulta o JSON na URL disponibilizada e faz um chack se existe algum serviço down.
Caso haja algun serviço down, ele monta uma mensagem e envia para o e-mail especificadao que estes serviços estão down.
