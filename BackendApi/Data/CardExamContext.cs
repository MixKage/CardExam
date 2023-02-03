using BackendApi.Models;
using BackendApi.Models.Card;
using BackendApi.Models.Old;
using Microsoft.EntityFrameworkCore;

namespace BackendApi.Data;

public class CardExamContext : DbContext
{
    public CardExamContext (DbContextOptions<CardExamContext> options)
        : base(options)
    {
        // Database.EnsureCreated();
    }
    
    
    // protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    // {
    //     optionsBuilder.UseNpgsql($"Host=localhost;Port=5432;Database=usersdb;Username=postgres;Password={ConstantValues.PASSWORD}");        
    // }

    public DbSet<User> Users => Set<User>();
    public DbSet<Card> Cards => Set<Card>();
    public DbSet<Comment> Comments => Set<Comment>();
}
