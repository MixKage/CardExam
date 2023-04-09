package models

import (
	"github.com/BackendApiCardExam/pkg/config"
	"github.com/jinzhu/gorm"
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
}

type QuestionAnswer struct {
	gorm.Model
	Question string `json:"Question"`
	Answer   string `json:"Answer"`
}

func init() {
	config.Connect()
	db = config.GetDB()
	db.AutoMigrate(&Card{}, &Comment{}, &QuestionAnswer{})
}

func (c *Card) CreateCard() *Card {
	db.NewRecord(c)
	db.Create(&c)
	return c
}

func GetCardById(Id int64) (*Card, *gorm.DB) {
	var getCard Card
	db.Where("ID=?", Id).Find(&getCard)
	if err := db.Raw("SELECT question_answers.id, question_answers.created_at, question_answers.updated_at, question_answers.deleted_at, question_answers.question, question_answers.answer FROM cards INNER JOIN question_answers ON question_answers.card_id = cards.id Where cards.id = ?", Id).Scan(&getCard.QuestionsAnswers).Error; err != nil {
		panic(err)
	}
	if err := db.Raw("SELECT comments.id, comments.created_at, comments.updated_at, comments.deleted_at, comments.id_user, comments.text FROM cards INNER JOIN comments ON comments.card_id = cards.id WHERE comments.id = ?", Id).Scan(&getCard.Comments).Error; err != nil {
		panic(err)
	}
	return &getCard, db
}
