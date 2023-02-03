using BackendApi.Models;
using BackendApi.Models.Old;
using Microsoft.EntityFrameworkCore;

namespace BackendApi.Data;

public sealed class PizzaContext: DbContext
{
    public PizzaContext (DbContextOptions<PizzaContext> options)
        : base(options)
    {
        // Database.EnsureCreated();
    }
    
    
    // protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    // {
    //     optionsBuilder.UseNpgsql($"Host=localhost;Port=5432;Database=usersdb;Username=postgres;Password={ConstantValues.PASSWORD}");        
    // }

    public DbSet<Pizza> Pizzas => Set<Pizza>();
    public DbSet<Topping> Toppings => Set<Topping>();
    public DbSet<Sauce> Sauces => Set<Sauce>();
}