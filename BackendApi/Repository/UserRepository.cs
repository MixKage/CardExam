namespace BackendApi.Repository;

using Models;
public class UserRepository
{
    // public static long? CreateUser(UserCreateInput input)
    // {
    //     using (ApplicationContext db = new ApplicationContext())
    //     {
    //         long? id = null;
    //         User user1 = new User { Login = input.login, Password = input.password, DateOfRegistration = DateTime.Now, University = input.University, Direction = input.Direction, Grade = input.Grade };
    //         db.Users.Add(user1);
    //         db.SaveChanges();
    //         return id = user1.Id;
    //     }
    //
    //    
    //    
    // }

    public static User[]? GetUser()
    {
        try
        {
            using (ApplicationContext db = new ApplicationContext())
            {
                var users = db.Users.ToArray();
                return users;
            }
        }
        catch (Exception)
        {
            return null;
        }
    }
}

