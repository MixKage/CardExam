// using Microsoft.AspNetCore.Mvc;
// using BackendApi.Models;
//
// using static BackendApi.Models.ModelClass;
//
// namespace BackendApi.Controllers
// {
//     [ApiController]
//     [Route("User")]
//     public class UserController : ControllerBase
//     {
//         private readonly ILogger<UserController> _logger;
//         public UserController(ILogger<UserController> logger)
//         {
//             _logger = logger;
//         }
//
//         [HttpPost("/CreateUser")]
//         public IActionResult PostUser([FromBody] UserCreateInput input)
//         {
//            var res = Repository.UserRepository.CreateUser(input);
//             return res == null ? Conflict() : Ok(res);
//         }
//
//         [HttpGet("/GetUser")]
//         public IActionResult GetUser()
//         {
//             var res = Repository.UserRepository.GetUser();
//             return res == null ? Conflict() : Ok(res);
//         }
//     } 
// }

using System.Security.Claims;
using BackendApi.Data.InputData;
using BackendApi.Models;
using BackendApi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BackendApi.Controllers;

[ApiController]
[Route("user/[controller]")]
public class UserController : ControllerBase
{
    UserService _service;
    
    public UserController(UserService service)
    {
        _service = service;
    }

    [HttpPost]
    public IActionResult Create(UserInput.UserCreateInput user)
    {
        User newUser = new User
            {
                Login = user.Login, 
                Password = user.Password, 
                University = user.University, 
                Course = user.Course,
                DateOfRegistration = DateTime.Now
            };
        
        _service.Create(newUser);
        return CreatedAtAction(nameof(GetById), new { id = newUser.Id }, newUser);
    }

    [HttpGet("{id}")]
    public ActionResult<User> GetById(int id)
    {
        User? user = _service.GetById(id);

        if(user is not null)
        {
            return user;
        }
        else
        {
            return NotFound();
        }
    }
    // //For admin Only
    // [HttpGet]
    // [Route("Admins")]
    // [Authorize(Roles = "Admin")]
    // public IActionResult AdminEndPoint()
    // {
    //     var currentUser = GetCurrentUser();
    //     return Ok($"Hi you are an {currentUser.Role}");
    // }
    // private TestUserModel GetCurrentUser()
    // {
    //     var identity = HttpContext.User.Identity as ClaimsIdentity;
    //     if (identity != null)
    //     {
    //         var userClaims = identity.Claims;
    //         return new TestUserModel
    //         {
    //             Username = userClaims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier)?.Value,
    //             Role = userClaims.FirstOrDefault(x => x.Type == ClaimTypes.Role)?.Value
    //         };
    //     }
    //     return null;
    // }
}