using System.Collections;
using BackendApi.Models;
using BackendApi.Models.Card;
using BackendApi.Models.Old;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace BackendApi.Data;

public class DbInitializer
{
    public static void Initialize(CardExamContext context)
    {

        if (context.Users.Any())
        {
            return; // DB заполнена
        }

        var pepperoniTopping = new Topping { Name = "Pepperoni", Calories = 130 };
        var sausageTopping = new Topping { Name = "Sausage", Calories = 100 };
        var hamTopping = new Topping { Name = "Ham", Calories = 70 };
        var chickenTopping = new Topping { Name = "Chicken", Calories = 50 };
        var pineappleTopping = new Topping { Name = "Pineapple", Calories = 75 };

        var tomatoSauce = new Sauce { Name = "Tomato", IsVegan = true };
        var alfredoSauce = new Sauce { Name = "Alfredo", IsVegan = false };

        var users = new User[]
        {
            new User
            {
                Login = "Mix1",
                Password = "2213",
                University = "МИРЭА",
                Course = 2,
                DateOfRegistration = DateTime.Now
            },
            new User
            {
                Login = "Maxon",
                Password = "2421",
                University = "МИРЭА",
                Course = 4,
                DateOfRegistration = DateTime.Now
            },
            new User
            {
                Login = "Igor",
                Password = "5125",
                University = "ItHub",
                Course = 4,
                DateOfRegistration = DateTime.Now
            }
        };

        Comment[] comments = { new Comment { IdUser = 3, Text = "круто" } };
        QuestionAnswer[] questionAnswers =
        {
            new QuestionAnswer()
            {
                Question = "Вопрос 1", Answers = "Вот такие пироги", GoodAnswersId = ""
            },
            new QuestionAnswer()
            {
                Question = "Вопрос 2", Answers = "Ответик 2", GoodAnswersId = ""
            }

        };

        var cards = new Card[]
        {
            new Card
            {
                Name = "Эказмен по физике",
                Universe = "МИРЭА",
                Direction = "КБ-1",
                Course = 3,
                Description = "Это экзамен",
                CreatorId = 1,
                Rating = 3.4,
                EditorsId = "2",
                ViewersId = "",
                Comments = comments,
                DateExam = DateTime.Now,
                IsVisible = true,
                TypeCard = 1,
                QuestionAnswers = questionAnswers
            }
        };

        context.Users.AddRange(users);
        context.Cards.AddRange(cards);
        context.SaveChanges();
    }
}
