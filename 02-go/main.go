package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
)

const Port = 8080

type PayloadResponse struct {
	Language  string    `json:"language"`
	Hostname  string    `json:"hostname"`
	Timestamp time.Time `json:timestamp`
	Uuid      string    `json:"uuid"`
}

type HealthResponse struct {
	Status string `json:"status"`
}

func payloadHandler(c *fiber.Ctx) error {
	hostname, _ := os.Hostname()
	uuid, _ := uuid.NewRandom()

	response := PayloadResponse{
		Language:  "🐹 go",
		Hostname:  hostname,
		Timestamp: time.Now(),
		Uuid:      fmt.Sprintf("%s", uuid),
	}
	return c.JSON(response)
}

func healthHandler(c *fiber.Ctx) error {
	response := HealthResponse{
		Status: "OK",
	}
	return c.JSON(response)
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
	app := fiber.New()
	port := getEnv("PORT", Port)

	app.Get("/", payloadHandler)
	app.Get("/health", healthHandler)

	fmt.Printf("🐹 Server started successfully on port %d\n", port)
	log.Fatal(app.Listen(fmt.Sprintf(":%d", port)))
}
