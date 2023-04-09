package routes

import (
	"github.com/BackendApiCardExam/pkg/controllers"
	"github.com/gorilla/mux"
)

var RegisterBookStoresRoutes = func(router *mux.Router) {
	router.HandleFunc("/v1/api/card/", controllers.CreateBook).Methods("POST")
	router.HandleFunc("/v1/api/card/{CardId}", controllers.GetBookById).Methods("GET")
}
