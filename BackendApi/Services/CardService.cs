using BackendApi.Data;
using BackendApi.Models.Card;
using Microsoft.EntityFrameworkCore;

namespace BackendApi.Services;

public class CardService
{
    private readonly CardExamContext _context;

    public CardService(CardExamContext context)
    {
        _context = context;
    }
    
    public Card? GetById(int id)
    {
        return _context.Cards
            .AsNoTracking()
            .Include(c => c.Comments)
            .Include(c => c.QuestionAnswers)
            .SingleOrDefault(p => p.Id == id);
    }

    public Card Create(Card newCard)
    {
        
        _context.Cards.Add(newCard);
        _context.SaveChanges();
        return newCard;
    }
}
