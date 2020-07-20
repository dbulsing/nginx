# Scrit para coletar arquivos no FTP


Este script tem como objetivo buscar atualizações de uma aplicação e realizar o deploy no servidor.

Foi utilizado shell scrit por não precisar de nenhuma dependência e praticamente rodar em qualquer distribuição.

Utilizado um processo enxuto agendado através do CRON para rodar toda noite, levando em consideração a periodicidade diária.
```sh
0  1  *  *  *  root  /bin/bash '/caminho/get_jar_file.sh'
```

O script lista o arquivo que foi disponibilizado para atualização no diretório FTP e armazena em uma variável, verificando se tem arquivo disponível.
Caso não tenha arquivo de atualização e script finaliza.
Contendo arquivo de atualização, o script faz o download do arquivo, para a aplicação que está em execução e altera o JAR.

Logo após, é alterado o arquivo do FTP para um diretório de deploy com sucesso.
