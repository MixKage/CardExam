namespace BackendApi.Models;

public class User
{
    public int Id { get; set; }
    public string Login { get; set; }
    public string Password { get; set; }
    public DateTime DateOfRegistration { get; set; }
    public string Univercity { get; set; }
    public string Direction { get; set; }
    public int Grade { get; set; }
}

