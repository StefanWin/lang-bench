package main

import (
	"fmt"
	"log"
	"os"
	"time"
)

func main() {
	data, err := os.ReadFile("../img.raw")
	if err != nil {
		log.Fatal(err)
	}
	dataCopy := make([]byte, len(data))

	start := time.Now()
	for i := 0; i < len(data); i += 3 {
		r, g, b := data[i], data[i+1], data[i+2]
		dataCopy[i] = r
		dataCopy[i+1] = g
		dataCopy[i+2] = b
	}
	dur := time.Since(start)
	fmt.Printf("took %dms\n", dur.Milliseconds())
	if err := os.WriteFile("img_go.raw", dataCopy, 0644); err != nil {
		log.Fatal(err)
	}
}
