using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using BackendApi.Models;
using BackendApi.Models.Old;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace BackendApi.Controllers;

[Route("api/[controller]")]
[ApiController]
public class LoginController : ControllerBase
{
    private readonly IConfiguration _config;
    public LoginController(IConfiguration config)
    {
        _config = config;
    }

    [AllowAnonymous]
    [HttpPost]
    public ActionResult Login([FromBody] TestUserLogin userLogin)
    {
        var user = Authenticate(userLogin);
        if (user != null)
        {
            var token = GenerateToken(user);
            return Ok(token);
        }

        return NotFound("user not found");
    }

    // To generate token
    private string GenerateToken(TestUserModel user)
    {
        var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
        var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier,user.Username),
            new Claim(ClaimTypes.Role,user.Role)
        };
        var token = new JwtSecurityToken(_config["Jwt:Issuer"],
            _config["Jwt:Audience"],
            claims,
            expires: DateTime.Now.AddMinutes(15),
            signingCredentials: credentials);


        return new JwtSecurityTokenHandler().WriteToken(token);

    }

    //To authenticate user
    private TestUserModel Authenticate(TestUserLogin userLogin)
    {
        var currentUser = TestUserConstants.Users.FirstOrDefault(x => x.Username.ToLower() ==
            userLogin.Username.ToLower() && x.Password == userLogin.Password);
        if (currentUser != null)
        {
            return currentUser;
        }
        return null;
    }
}
