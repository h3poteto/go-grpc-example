```
protoc -I. \
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
