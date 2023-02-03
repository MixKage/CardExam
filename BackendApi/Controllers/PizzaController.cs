using BackendApi.Models;
using BackendApi.Models.Old;
using BackendApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace BackendApi.Controllers;
[ApiController]
[Route("[controller]")]
public class PizzaController : ControllerBase
{
    PizzaService _service;
    
    public PizzaController(PizzaService service)
    {
        _service = service;
    }
    
    [HttpGet("{id}")]
    public ActionResult<Pizza> GetById(int id)
    {
        var pizza = _service.GetById(id);

        if(pizza is not null)
        {
            return pizza;
        }
        else
        {
            return NotFound();
        }
    }
    
    [HttpPost]
    public IActionResult Create(Pizza pizza)
    {            
        _service.Create(pizza);
        return CreatedAtAction(nameof(GetById), new { id = pizza.Id }, pizza);
    }
    
    [HttpPut("{id}/addtopping")]
    public IActionResult AddTopping(int id, int toppingId)
    {
        var pizzaToUpdate = _service.GetById(id);

        if(pizzaToUpdate is not null)
        {
            _service.AddTopping(id, toppingId);
            return NoContent();    
        }
        else
        {
            return NotFound();
        }
    }

    [HttpPut("{id}/updatesauce")]
    public IActionResult UpdateSauce(int id, int sauceId)
    {
        var pizzaToUpdate = _service.GetById(id);

        if(pizzaToUpdate is not null)
        {
            _service.UpdateSauce(id, sauceId);
            return NoContent();    
        }
        else
        {
            return NotFound();
        }
    }

    [HttpDelete("{id}")]
    public IActionResult Delete(int id)
    {
        var pizza = _service.GetById(id);

        if(pizza is not null)
        {
            _service.DeleteById(id);
            return Ok();
        }
        else
        {
            return NotFound();
        }
    }
}
