package gateway

import "github.com.br/silva4dev/wallet-digital-microservice-project/domain/entity"

type TransactionGateway interface {
	Create(transaction *entity.Transaction) error
}
