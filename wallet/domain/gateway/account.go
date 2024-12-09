package gateway

import "github.com.br/silva4dev/wallet-digital-microservice-project/domain/entity"

type AccountGateway interface {
	Save(account *entity.Account) error
	FindByID(id string) (*entity.Account, error)
	UpdateBalance(account *entity.Account) error
}
