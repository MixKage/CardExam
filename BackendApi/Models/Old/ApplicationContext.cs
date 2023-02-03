using BackendApi.Const;
using Microsoft.EntityFrameworkCore;

namespace BackendApi.Models;

public class ApplicationContext : DbContext
{
    public DbSet<User> Users { get; set; } = null!;

    public ApplicationContext()
    {
        Database.EnsureCreated();
    }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseNpgsql($"Host=localhost;Port=5432;Database=usersdb;Username=postgres;Password={ConstantValues.PASSWORD}");        
    }
}