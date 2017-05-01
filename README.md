# fuber
A simple car booking application using ruby and sinatra.

### Instructions

Please do make sure that you have ruby installed and the bundler gem.

Checkout the code and run these commands to start the server.

```sh
$ bundle
```

```sh
$ ruby server.rb
```

server.rb is the entry point to the application and has all the routes to the application

### Note

All the modelling related classes and their relationships are within the models directory

Sinatra is used here to come up with a basic simple server to accomodate the requirements in terms of providing restful APIs 

models/base.rb has generic attributes and methods for in memory data store implementation and for json conversion

The application by default runs on port 4567

The cars available can be seen using /cars_ui after running the server.

Brute force has been used to identify the nearest car available. That part can be optimized in terms of DSA
