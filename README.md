Small demo-setup for a container based Navajo instance.
This setup will start three containers:

 - An empty mongodb instance
 - A Postgres database with some fake movie data
 - A navajo container pointing to the database
 - The navajo container has a few scripts that access that data

Using this demo:

Clone this repository:

```
git clone https://github.com/Dexels/navajo.example.git
```
This will clone a simple navajo project along with some docker configuration files.
We use docker-compose here, a simple piece of configuration that allows us to start multiple containers at once:

Take a look at the docker compose file:

```
Ãversion: '2'
services:
  postgres:
    image: dexels/dvdrental:1.0.7
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: mysecretpassword
  navajo:
    image: dexels/navajo-demo:1
    ports:
      - "8181:8181"
    environment:
     - CLUSTER=demo
     - HAZELCAST_SIMPLE=true
     - FILE_REPOSITORY_DEPLOYMENT=develop
```
It defines two containers, one called postgres and one called navajo. The postgres container exposes the standard postgres port at 5432, and navajo
exposes port 8181.

```
%> docker-compose up
```
Will start both containers and after a while both should be up.

then open a browse to:
http://localhost:8181/tester.html
username: admin password: admin

In the tester login with any username / password 
