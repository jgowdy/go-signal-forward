package main

import (
	"C"
)

func main() {
}

//export GoAdd
func GoAdd(a, b float64) float64 {
	return a + b
}
