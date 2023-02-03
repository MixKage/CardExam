namespace BackendApi.Models.Card;

public class Card
{
    // Id карточки
    public int Id { get; set; }
    // Название карточки
    public string Name { get; set; }
    // Название университета
    public string Universe { get; set; }
    // Описание карточки
    public string Direction { get; set; }
    // Курс
    public int Course { get; set; }
    // Описание
    public string Description { get; set; }
    // Создатель карточки
    public int CreatorId { get; set; }
    // Рейтинг карточки
    public double Rating { get; set; }
    // Id пользователей, которым разрешено редактировать
    public string EditorsId { get; set; }
    // Id пользователей, которым разрешено просматривать
    public string ViewersId { get; set; }
    // Комментарии пользователей
    public ICollection<Comment> Comments { get; set; }
    // Дата экзамена
    public DateTime DateExam { get; set; }
    // Видна ли карточка в общем доступе
    public bool IsVisible { get; set; }
    // Тип карточки (1 - теория, 2 - тестирование, 3 - смешанная)
    public int TypeCard { get; set; }
    // Список вопрос-ответов
    public ICollection<QuestionAnswer> QuestionAnswers { get; set; }
}
