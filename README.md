# go-grpc-example
This repository is a experimental field of grpc.

## Install
You have to install `protoc` command for generate files. Please read an [official document](https://github.com/google/protobuf).

For example:

```
$ mkdir -p tmp/protoc
$ cd tmp/protoc
$ curl -sL https://github.com/google/protobuf/releases/download/v3.5.0/protoc-3.5.0-linux-x86_64.zip
$ unzip protoc-3.5.0-linux-x86_64.zip
$ sudo cp bin/protoc /usr/local/bin/protoc
$ sudo chmod +x /usr/local/bin/protoc
```
## Generate server files
I have already prepared Makefile.

```
$ make
dep ensure
go get -u github.com/gogo/protobuf/proto
go get -u github.com/gogo/protobuf/protoc-gen-gogo
go get -u github.com/gogo/protobuf/gogoproto
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/mwitkow/go-proto-validators/protoc-gen-govalidators
protoc -I. -I/home/akira/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --proto_path=/home/akira/src --proto_path=/home/akira/src/github.com/gogo/protobuf/protobuf --proto_path=. --go_out=plugins=grpc:./ --govalidators_out=./ --grpc-gateway_out=logtostderr=true:./ protocol/*.proto
cd client/ruby && bundle install --path vendor/bundle
Using public_suffix 3.0.1
Using bundler 1.15.4
Using multipart-post 2.0.0
Using google-protobuf 3.5.0 (x86_64-linux)
Using jwt 2.1.0
Using little-plugger 1.1.4
Using multi_json 1.12.2
Using memoist 0.16.0
Using os 0.9.6
Using grpc-tools 1.8.0
Using addressable 2.5.2
Using faraday 0.13.1
Using googleapis-common-protos-types 1.0.1
Using logging 2.2.2
Using signet 0.8.1
Using googleauth 0.6.2
Using grpc 1.8.0 (x86_64-linux)
Bundle complete! 2 Gemfile dependencies, 17 gems now installed.
Bundled gems are installed into ./vendor/bundle.
cd client/ruby && protoc -I ../../protocol -I/home/akira/src  -I/home/akira/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --proto_path=/home/akira/src --proto_path=/home/akira/src/github.com/gogo/protobuf/protobuf --proto_path=. --ruby_out=. --grpc_out=. --plugin=protoc-gen-grpc=/home/akira/src/github.com/h3poteto/go-grpc-example/client/ruby/vendor/bundle/ruby/2.3.0/bin/grpc_tools_ruby_protoc_plugin ../../protocol/*.proto
[libprotobuf WARNING google/protobuf/compiler/ruby/ruby_generator.cc:424] Omitting proto2 dependency 'github.com/mwitkow/go-proto-validators/validator.proto' from proto3 output file 'customer_service_pb.rb' because we don't support proto2 and no proto2 types from that file are being used.

```


## Start gRPC server

```
$ go run server/server.go
```

## Start gateway server

```
$ go run gateway/gateway.go
```

```
$ curl -X POST http://localhost:9090/v1/customer_service/add_person -H "Content-Type: text/plain" -d '{"name": "akira", "age": 12}'
{}%
$ curl http://localhost:9090/v1/customer_service/list_person
{"result":{"name":"akira","age":12}}
```
