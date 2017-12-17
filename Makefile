.PHONY: dep grpc-protobuf bundle

all: go-lib ruby-lib
ruby-lib: bundle grpc-protobuf
	cd client/ruby && protoc -I ../../protocol -I$(GOPATH)/src  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --proto_path=$(GOPATH)/src --proto_path=$(GOPATH)/src/github.com/gogo/protobuf/protobuf --proto_path=. --ruby_out=lib --grpc_out=lib --plugin=protoc-gen-grpc=$(shell cd client/ruby && bundle exec which grpc_tools_ruby_protoc_plugin) ../../protocol/*.proto
go-lib: dep grpc-protobuf
	protoc -I. -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --proto_path=$(GOPATH)/src --proto_path=$(GOPATH)/src/github.com/gogo/protobuf/protobuf --proto_path=. --go_out=plugins=grpc:./ --govalidators_out=./ --grpc-gateway_out=logtostderr=true:./ protocol/*.proto
dep: Gopkg.toml
	dep ensure
grpc-protobuf:
	go get -u github.com/gogo/protobuf/proto
	go get -u github.com/gogo/protobuf/protoc-gen-gogo
	go get -u github.com/gogo/protobuf/gogoproto
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	go get -u github.com/mwitkow/go-proto-validators/protoc-gen-govalidators
bundle: client/ruby/Gemfile
	cd client/ruby && bundle install --path vendor/bundle
clean:
	rm -rf vendor
	rm -rf client/ruby/vendor/bundle
