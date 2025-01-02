package main

import (
	"bufio"
	"fmt"
	"net"
)

func main() {
	lis, err := net.Listen("tcp", ":8080")
	if err != nil {
		fmt.Printf("fialed to listen: %v", err)
		return
	}

	for {
		conn, err := lis.Accept()
		if err != nil {
			fmt.Printf("failed to accept connection: %v", err)
			return
		}

		fmt.Println("accept connection")
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	reader := bufio.NewReader(conn)
	for {
		msg, err := reader.ReadString('\n')
		if err != nil {
			fmt.Printf("failed to read message: %v", err)
			return
		}

		_, err = conn.Write([]byte("geting to message: %v" + msg))
		if err != nil {
			fmt.Printf("failed to write message: %v", err)
			break
		}
	}
}
