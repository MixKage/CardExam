using BackendApi.Models.Card;
using BackendApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace BackendApi.Controllers;

[ApiController]
[Route("card/[controller]")]
public class CardController : ControllerBase
{
    CardService _service;
    
    public CardController(CardService service)
    {
        _service = service;
    }
    
    [HttpPost]
    public IActionResult Create(Card newCard)
    {
        _service.Create(newCard);
        return CreatedAtAction(nameof(GetById), new { id = newCard.Id }, newCard);
    }

    [HttpGet("{id}")]
    public ActionResult<Card> GetById(int id)
    {
        Card? card = _service.GetById(id);

        if(card is not null)
        {
            return card;
        }
        else
        {
            return NotFound();
        }
    }
}
