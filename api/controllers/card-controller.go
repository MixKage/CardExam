package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/BackendApiCardExam/api/models"
	"github.com/BackendApiCardExam/api/utils"
	"github.com/gorilla/mux"
)

var NewCard models.Card

func GetCardById(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	bookId := vars["CardId"]
	ID, err := strconv.ParseInt(bookId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing")
	}
	cardDetails, _ := models.GetCardByIdFromDb(ID)
	res, _ := json.Marshal(cardDetails)
	w.Header().Set("content-type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func CreateCard(w http.ResponseWriter, r *http.Request) {
	CreateCard := &models.Card{}
	utils.ParseBody(r, CreateCard)
	c := CreateCard.CreateCardToDb()
	res, _ := json.Marshal(c)
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
