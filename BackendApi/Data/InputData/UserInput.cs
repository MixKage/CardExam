using System.ComponentModel.DataAnnotations;

namespace BackendApi.Data.InputData;

public class UserInput
{
    public record UserCreateInput(
    [StringLength(50)][Required] string Login,
    [StringLength(50)][Required] string Password,
    [StringLength(50)][Required] string University,
    [Required] int Course
    );
}
