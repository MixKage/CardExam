package models

import (
	"github.com/BackendApiCardExam/api/config"
	"gorm.io/gorm"
)

var db *gorm.DB

type Card struct {
	gorm.Model
	Name             string           `json:"Name"`
	University       string           `json:"University"`
	Direction        string           `json:"Direction"`
	Course           string           `json:"Course"`
	Description      string           `json:"Description"`
	CreatorID        int              `json:"CreatorId"`
	Rating           int              `json:"Rating"`
	ViewersID        int              `json:"ViewersId"`
	Comments         []Comment        `json:"Comments"`
	DateExam         string           `json:"DateExam"`
	IsVisible        bool             `json:"IsVisible"`
	TypeCard         int              `json:"TypeCard"`
	QuestionsAnswers []QuestionAnswer `json:"QuestionsAnswers"`
}

type Comment struct {
	gorm.Model
	IDUser int    `json:"IdUser"`
	Text   string `json:"Text"`
	CardID int
}

type QuestionAnswer struct {
	gorm.Model
	Question string `json:"Question"`
	Answer   string `json:"Answer"`
	CardID   int
}

func init() {
	config.Connect()
	db = config.GetDB()
	db.AutoMigrate(&Card{}, &Comment{}, &QuestionAnswer{})
}

func (c *Card) CreateCardToDb() *Card {
	db.Create(&c)
	return c
}

func GetCardByIdFromDb(Id int64) (*Card, *gorm.DB) {
	var getCard Card
	db.Preload("QuestionsAnswers").Preload("Comments").Find(&getCard, "ID = ?", Id)
	return &getCard, db
}
