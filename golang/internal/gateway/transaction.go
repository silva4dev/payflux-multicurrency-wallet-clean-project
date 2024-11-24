package gateway

import "github.com.br/silva4dev/wallet-digital-microservice-project/internal/entity"

type TransactionGateway interface {
	Create(transaction *entity.Transaction) error
}
