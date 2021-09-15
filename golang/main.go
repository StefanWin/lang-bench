package main

import (
	"fmt"
	"log"
	"os"
	"time"
)

func plainCopy(src []byte) []byte {
	dst := make([]byte, len(src))
	for i := 0; i < len(src); i += 3 {
		r, g, b := src[i], src[i+1], src[i+2]
		dst[i] = r
		dst[i+1] = g
		dst[i+2] = b
	}
	return dst
}

func avgGray(src []byte) []byte {
	dst := make([]byte, len(src))
	for i := 0; i < len(src); i += 3 {
		r, g, b := src[i], src[i+1], src[i+2]
		sum := (int(r) + int(g) + int(b))
		if sum > 255 {
			sum = 255
		}
		avg := byte(sum / 3)
		dst[i] = avg
		dst[i+1] = avg
		dst[i+2] = avg
	}
	return dst
}

func percGray(src []byte) []byte {
	dst := make([]byte, len(src))
	for i := 0; i < len(src); i += 3 {
		r, g, b := src[i], src[i+1], src[i+2]
		r = byte(float32(r) * 0.2126)
		g = byte(float32(g) * 0.7152)
		b = byte(float32(b) * 0.0722)
		val := r + g + b
		dst[i] = val
		dst[i+1] = val
		dst[i+2] = val
	}
	return dst
}

func main() {
	alg := "copy"
	args := os.Args
	if len(args) > 1 {
		alg = args[1]
	}
	data, err := os.ReadFile("../img.raw")
	if err != nil {
		log.Fatal(err)
	}
	var fn func([]byte) []byte
	switch alg {
	case "copy":
		fn = plainCopy
	case "avg_gray":
		fn = avgGray
	case "perc_gray":
		fn = percGray
	default:
		fn = plainCopy
	}

	start := time.Now()
	dst := fn(data)
	dur := time.Since(start)
	fmt.Printf("%s took %dms\n", alg, dur.Milliseconds())
	if err := os.WriteFile(fmt.Sprintf("img_go_%s.raw", alg), dst, 0644); err != nil {
		log.Fatal(err)
	}
}
