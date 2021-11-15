package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/google/uuid"
)

const Port = 8081

type response struct {
	Language  string    `json:"language"`
	Hostname  string    `json:"hostname"`
	Timestamp time.Time `json:timestamp`
	Uuid      string    `json:"uuid"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	language := "go"
	uuid_random, _ := uuid.NewRandom()
	hostname, _ := os.Hostname()
	timestamp := time.Now()

	data := &response{
		Language:  language,
		Hostname:  hostname,
		Timestamp: timestamp,
		Uuid:      fmt.Sprintf("%s", uuid_random)}
	response, _ := json.Marshal(data)

	w.Header().Set("Content-Type", "application/json")

	fmt.Fprintf(w, string(response))
}

func getEnv(key string, fallback int) int {
	/*
		Python's port = int(environ.get("PORT", 8080)) equivalent
	*/
	if v := os.Getenv(key); v != "" {
		port := v
		i, err := strconv.Atoi(port)
		if err != nil {
			log.Fatal("error")
		}
		return i
	} else {
		return fallback
	}
}

func main() {
	port := getEnv("PORT", Port)

	fmt.Printf("Listening on :%s\n", port)

	http.HandleFunc("/", handler)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}
