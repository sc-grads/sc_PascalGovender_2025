using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
 
[Route("api/database")]
[ApiController]
public class DatabaseController : ControllerBase
{
    private readonly string _connectionString = "Server=localhost;Database=AutoTestDB;User Id=Auto_user;Password=123456;";
 
    [HttpGet("test")]
    public IActionResult TestConnection()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                return Ok("SQL Server connection successful!");
            }
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
    }
}
 