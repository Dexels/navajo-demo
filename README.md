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
�version: '2'
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

In the tester login with any username / password (disregard the login system, keep it on 'Oracle' for now, it does not matter for now)

- Select Tenant1.
- Click Login

Now we can call Navajo scripts by clicking on the script tree on the left.
For example, open movie / ActorList
That will open a script that queries a list of fake films.

### Shutting down

```
%> docker-compose down
```

(You can check with cluster are running using 'docker-compose ps', or check 'docker ps' for individual containers)

### Connecting to the Postgres database

Open a connection to localhost:5432
Username: postgres Password: mysecretpassword

### Editing / rebuilding.

Try editing / adding scripts in navajo/scripts.
Then rebuild:

```
docker-compose build
```

And bring it back up:

```
docker-compose up
```
