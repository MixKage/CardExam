using Microsoft.AspNetCore.Mvc;
using BackendApi.Models;

using static BackendApi.Models.ModelClass;

namespace BackendApi.Controllers
{
    [ApiController]
    [Route("User")]
    public class UserController : ControllerBase
    {
        private readonly ILogger<UserController> _logger;
        public UserController(ILogger<UserController> logger)
        {
            _logger = logger;
        }

        [HttpPost("/CreateUser")]
        public IActionResult PostUser([FromBody] UserCreateInput input)
        {
           var res = Repository.UserRepository.CreateUser(input);
            return res == null ? Conflict() : Ok(res);
        }

        [HttpGet("/GetUser")]
        public IActionResult GetUser()
        {
            var res = Repository.UserRepository.GetUser();
            return res == null ? Conflict() : Ok(res);
        }
    } 
}