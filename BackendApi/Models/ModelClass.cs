namespace BackendApi.Models;
using System.ComponentModel.DataAnnotations;
public class ModelClass
{
    public record UserCreateInput(
    [StringLength(50)][Required] string login,
    [StringLength(50)][Required] string password,
    [StringLength(50)][Required] string Univercity,
    [StringLength(50)][Required] string Direction,
    [Required] int Grade
);
    public record UserLoginInput(
    [StringLength(50)][Required] string login,
    [StringLength(50)][Required] string password
);
    public record ID(
    [Required] long id
);
    public record UpdateInput(
    [Required] long id,
    [Required] string text
);
    public record PostCreate(
    [Required] string image,
    [StringLength(500)] string descryption,
    [StringLength(50)] string tag,
    long idAuthor
);
    public record CreateLike(
    [Required] long id_post,
    [Required] long id_account
);
    public record UpdatePerson(
    [Required] long Id,
    [Required] string? Email,
    [Required] string? Name,
    [Required] string? Status,
    [Required] long Country,
    [Required] long Age,
    [Required] string? Number,
    [Required] string? Avatar
);
}

