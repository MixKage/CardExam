namespace BackendApi.Models.Card;

public class Comment
{
    // Id комментария
    public int Id { get; set; }
    // Id пользователя оставившего комментарий
    public int IdUser { get; set; }
    // Комментарий
    public string Text { get; set; }
}
