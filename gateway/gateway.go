package main

import (
	"log"
	"net/http"
	"os"

	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	gw "github.com/h3poteto/go-grpc-example/protocol"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

func run() error {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}
	err := gw.RegisterCustomerServiceHandlerFromEndpoint(ctx, mux, "localhost:"+os.Getenv("SERVER_PORT"), opts)
	if err != nil {
		return err
	}

	log.Printf("gateway server start port: %s", os.Getenv("GATEWAY_PORT"))
	return http.ListenAndServe(":"+os.Getenv("GATEWAY_PORT"), mux)
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
