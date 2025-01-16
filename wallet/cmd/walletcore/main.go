package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com.br/silva4dev/wallet-digital-microservice-project/application/usecase/create_account"
	"github.com.br/silva4dev/wallet-digital-microservice-project/application/usecase/create_client"
	"github.com.br/silva4dev/wallet-digital-microservice-project/application/usecase/create_transaction"
	"github.com.br/silva4dev/wallet-digital-microservice-project/domain/event"
	"github.com.br/silva4dev/wallet-digital-microservice-project/domain/event/handler"
	"github.com.br/silva4dev/wallet-digital-microservice-project/infrastructure/database"
	"github.com.br/silva4dev/wallet-digital-microservice-project/pkg/events"
	"github.com.br/silva4dev/wallet-digital-microservice-project/pkg/kafka"
	"github.com.br/silva4dev/wallet-digital-microservice-project/pkg/uow"
	web "github.com.br/silva4dev/wallet-digital-microservice-project/web"
	"github.com.br/silva4dev/wallet-digital-microservice-project/web/webserver"
	ckafka "github.com/confluentinc/confluent-kafka-go/kafka"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	mysqlUser := os.Getenv("MYSQL_USER")
	mysqlPassword := os.Getenv("MYSQL_PASSWORD")
	mysqlHost := os.Getenv("MYSQL_HOST")
	mysqlPort := os.Getenv("MYSQL_PORT")
	mysqlDB := os.Getenv("MYSQL_DB")

	if mysqlUser == "" || mysqlPassword == "" || mysqlHost == "" || mysqlPort == "" || mysqlDB == "" {
		log.Fatal("Missing one or more required MySQL environment variables")
	}

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", mysqlUser, mysqlPassword, mysqlHost, mysqlPort, mysqlDB)
	db, err := sql.Open("mysql", dsn)

	if err != nil {
		log.Fatal("Failed to connect to database: ", err)
	}

	defer db.Close()

	kafkaBootstrapServers := os.Getenv("KAFKA_BOOTSTRAP_SERVERS")
	kafkaGroupID := os.Getenv("KAFKA_GROUP_ID")

	if kafkaBootstrapServers == "" || kafkaGroupID == "" {
		log.Fatal("Missing one or more required Kafka environment variables")
	}

	configMap := ckafka.ConfigMap{
		"bootstrap.servers": kafkaBootstrapServers,
		"group.id":          kafkaGroupID,
	}

	kafkaProducer := kafka.NewKafkaProducer(&configMap)

	eventDispatcher := events.NewEventDispatcher()
	eventDispatcher.Register("TransactionCreated", handler.NewTransactionCreatedKafkaHandler(kafkaProducer))
	eventDispatcher.Register("BalanceUpdated", handler.NewUpdateBalanceKafkaHandler(kafkaProducer))
	transactionCreatedEvent := event.NewTransactionCreated()
	balanceUpdatedEvent := event.NewBalanceUpdated()

	clientDb := database.NewClientDB(db)
	accountDb := database.NewAccountDB(db)

	ctx := context.Background()
	uow := uow.NewUow(ctx, db)

	uow.Register("AccountDB", func(tx *sql.Tx) interface{} {
		return database.NewAccountDB(db)
	})

	uow.Register("TransactionDB", func(tx *sql.Tx) interface{} {
		return database.NewTransactionDB(db)
	})
	createTransactionUseCase := create_transaction.NewCreateTransactionUseCase(uow, eventDispatcher, transactionCreatedEvent, balanceUpdatedEvent)
	createClientUseCase := create_client.NewCreateClientUseCase(clientDb)
	createAccountUseCase := create_account.NewCreateAccountUseCase(accountDb, clientDb)

	webserver := webserver.NewWebServer(":8080")

	clientHandler := web.NewWebClientHandler(*createClientUseCase)
	accountHandler := web.NewWebAccountHandler(*createAccountUseCase)
	transactionHandler := web.NewWebTransactionHandler(*createTransactionUseCase)

	webserver.AddHandler("/clients", clientHandler.CreateClient)
	webserver.AddHandler("/accounts", accountHandler.CreateAccount)
	webserver.AddHandler("/transactions", transactionHandler.CreateTransaction)

	fmt.Println("Server is running")
	webserver.Start()
}
