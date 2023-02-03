namespace BackendApi.Models;

public class User
{
    public int Id { get; set; }
    public string Login { get; set; }
    public string Password { get; set; }
    public DateTime DateOfRegistration { get; set; }
    public string University { get; set; }
    public int Course { get; set; }
}

