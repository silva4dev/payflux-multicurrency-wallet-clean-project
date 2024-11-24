package gateway

import "github.com.br/silva4dev/wallet-digital-microservice-project/internal/entity"

type ClientGateway interface {
	Get(id string) (*entity.Client, error)
	Save(client *entity.Client) error
}
