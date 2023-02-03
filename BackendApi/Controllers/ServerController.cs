using System.Net;
using BackendApi.Const;
using BackendApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace BackendApi.Controllers;

[ApiController]
[Route("server/[controller]")]
public class ServerController : ControllerBase
{
    ServerService _service;
    
    public ServerController(ServerService service)
    {
        _service = service;
    }

    // Ответ сервара, что он жив
    [HttpGet("ping")]
    public HttpStatusCode PingServer()
    {
        return HttpStatusCode.OK;
    }
    
    // Получение минимально необходимой для работы версии мобильного приложения
    [HttpGet("minimal_version")]
    public int MinimalVersion()
    {
        return ServerInformationConstant.MinimalVersionMobileApp;
    }
}
