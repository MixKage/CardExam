namespace BackendApi.Models.Card;

public class QuestionAnswer
{
    // Id вопрос-ответа
    public int Id { get; set; }
    // Вопрос
    public string Question { get; set; }
    // Список ответов и фотографий в BASE64
    public string Answers { get; set; }
    // Пустой, если это теоретический вопрос
    public string GoodAnswersId { get; set; }
}
