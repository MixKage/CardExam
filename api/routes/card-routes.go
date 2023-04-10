package routes

import (
	"github.com/BackendApiCardExam/api/controllers"
	"github.com/gorilla/mux"
)

var RegisterBookStoresRoutes = func(router *mux.Router) {
	router.HandleFunc("/v1/api/card/", controllers.CreateCard).Methods("POST")
	router.HandleFunc("/v1/api/card/{CardId}", controllers.GetCardById).Methods("GET")
}
