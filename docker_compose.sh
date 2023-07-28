#!/bin/bash

docker_file(){
        mkdir web_server_lab/
	touch web_server_lab/Dockerfile
        echo "FROM ubuntu" >> web_server_lab/Dockerfile
        echo "RUN apt update" >> web_server_lab/Dockerfile
        echo "RUN apt install -y apache2" >> web_server_lab/Dockerfile
        echo "RUN apt install -y apache2-utils" >> web_server_lab/Dockerfile
        echo "RUN apt clean" >> web_server_lab/Dockerfile
        echo "ADD hostit-html/ /var/www/html/" >> web_server_lab/Dockerfile
        echo "EXPOSE 80" >> web_server_lab/Dockerfile
        echo "CMD ["\"apache2ctl\"", "\"-D\"", "\"FOREGROUND\""]" >> web_server_lab/Dockerfile
}

#Create a new docker network
docker network create --driver bridge --subnet 172.27.0.1/16 --gateway 172.27.0.1 docker-lab-network

#Download CSS template
wget -P web_server_lab/ https://www.free-css.com/assets/files/free-css-templates/download/page293/hostit.zip &> /dev/null

#Unzip file
unzip web_server_lab/hostit.zip -d web_server_lab/ &> /dev/null

#Create docker file
docker_file

#Run docker-compose
docker-compose up
