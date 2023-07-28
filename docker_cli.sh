#!/bin/bash

docker_file(){
	touch Dockerfile
	echo "FROM ubuntu" >> Dockerfile
	echo "RUN apt update" >> Dockerfile
	echo "RUN apt install -y apache2" >> Dockerfile
	echo "RUN apt install -y apache2-utils" >> Dockerfile
	echo "RUN apt clean" >> Dockerfile
	echo "ADD hostit-html/ /var/www/html/" >> Dockerfile
	echo "EXPOSE 80" >> Dockerfile
	echo "CMD ["\"apache2ctl\"", "\"-D\"", "\"FOREGROUND\""]" >> Dockerfile
}

#Download CSS template
wget https://www.free-css.com/assets/files/free-css-templates/download/page293/hostit.zip &> /dev/null

#Unzip file
unzip hostit.zip &> /dev/null

#Create dockerfile for web server
docker_file

#Build web server image
docker build -t web_server_lab .

#Run mysql container
docker run -d --name=db mysql/mysql-server:latest

#Run web server container from newly built docker image
docker run -d -p 8080:80 --link db:db web_server_lab

#After this, container can be accessed through localhost:8080
