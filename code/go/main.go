package main

import (
	"fmt"
	"strings"
	"time"
)

func h(s string) (string, error) {
	trim := strings.TrimSpace(s)

	return trim, nil
}

func main() {
	t := time.Now().Format(time.RFC3339)

	tt, err := h(t)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(tt)
}
