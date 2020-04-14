## Small demo-setup for a container-based Navajo instance ##

This setup will start three containers:
- An empty mongodb instance
- A postgres database with some fake movie data
- A navajo container pointing to the two databases

The Navajo container has a few scripts that access the data in the databases.

### Using this demo ###

Clone this repository:

```
%> git clone https://github.com/Dexels/navajo.example.git
```

This will clone a simple navajo project along with some docker configuration files.
We use docker-compose here, a simple piece of configuration that allows us to start multiple containers at once:

Take a look at the docker compose file:

```
version: '3'
services:
  mongodemo:
    image: mongo:latest
    ports:
      - "27017:27017"

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

It defines three containers, called "mongodemo", "postgres", and "navajo". The mongodemo container exposes the standard
mongodb port at 27017, the postgres container the standard postgres port at 5432, and navajo container exposes an HTTP
port at 8181.

```
%> docker-compose up
```

Will start all three containers, and after a while they should all be up.

then open a browse to:
http://localhost:8181/tester.html
username: admin password: admin

In the tester login with any username / password (disregard the login system, keep it on 'Oracle' for now, it does not matter for now)

- Select Tenant1.
- Click Login

Now we can call Navajo scripts by clicking on the script tree on the left.
For example, open movie / ActorList
That will open a script that queries a list of fake films.

Additionally, you can inspect the OSGi web console. This web endpoint gives deep insight in the state of the system, it can be an invaluable tool to troubleshoot the system.
For example, the 'bundles' tab shows all active OSGi bundles (An OSGi bundle is essentially a jar file with some extra metadata). An OSGi bundle specifies precisely what java packages it publishes to other bundles and which packages it needs from other bundles. This adds some complexity to building those bundles, as the dependencies between bundles have to be specific and precise.
This can be very helpful though, as the OSGi framework will try to resolve all those dependencies when starting up (or when the system changes at runtime), and can precisely tell you when there is a problem, before you can a runtime error.
Effectively that means that you can check the bundles tab to see if there are bundles that could not be resolved, typically those show up as bundles that do not have the state 'Active' or 'Fragment'. 
If a bundle is unresolved, it also won't publish it's own package, so generally when there is one unresolved bundle, all bundles depending on that bundle will also be unresolved.
You can use this interface to figure out what the root-cause is of this class path issue.

For more in-depth information on how to use the OSGi web console I refer to the Felix project:

https://felix.apache.org/documentation/subprojects/apache-felix-web-console.html


### Shutting down

```
%> docker-compose down
```

(You can check with cluster are running using 'docker-compose ps', or check 'docker ps' for individual containers)


### Connecting to the MongoDB database

Open a connection to localhost:27017 using your favorite mongodb access tool (*e.g.*, MongoDB Compass or Robo 3T).


### Connecting to the Postgres database

Open a connection to localhost:5432 using your favorite database access tool (*e.g.*, DbVisualizer)

Username: postgres 

Password: mysecretpassword

### Editing / rebuilding

Try editing / adding scripts in navajo/scripts.
Then rebuild:

```
%> docker-compose build
```

And bring it back up:

```
%> docker-compose up
```

For more about docker / docker-compose, there is very nice documentation available at
https://docs.docker.com/get-started/
