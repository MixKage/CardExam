using BackendApi.Data;

namespace BackendApi.Services;

public class ServerService
{
    private readonly CardExamContext _context;

    public ServerService(CardExamContext context)
    {
        _context = context;
    }
    
    // Получение минимально необходимой версии приложения
    // Пинг сервера
}
