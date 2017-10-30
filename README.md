## Compile

```
$ protoc -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --proto_path=${GOPATH}/src \
  --proto_path=${GOPATH}/src/github.com/gogo/protobuf/protobuf \
  --proto_path=. \
  --go_out=plugins=grpc:./ \
  --govalidators_out=./ \
  --grpc-gateway_out=logtostderr=true:./ \
  protocol/*.proto
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
