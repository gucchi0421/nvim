package main

import (
	"fmt"
	"net"
	"time"
)

func main() {
	host := "localhost"
	protocol := "tcp"

	for port := 1; port <= 1024; port++ {
		if scan(protocol, host, port) {
			fmt.Printf("%d open\n", port)
		}
	}

	fmt.Println("Done")
}

func scan(protocol, host string, port int) bool {
	address := fmt.Sprintf("%s:%d", host, port)
	conn, err := net.DialTimeout(protocol, address, 1*time.Second)
	if err != nil {
		return false
	}
	conn.Close()
	return true
}
