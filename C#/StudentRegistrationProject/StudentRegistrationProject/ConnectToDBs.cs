using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Mapping;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentRegistrationProject
{
    public class ConnectToDBs
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=StudentRegSambeDB;Integrated Security=True;TrustServerCertificate=True");
        SqlCommand cmd;
        SqlDataReader dReader;
        DataRow row;
        DataTable dt = new DataTable();

        public void Registerstudent(int StudentID,string Name,string Surname, string Address, string City, string CellPhone)
        {
            con.Open();
            cmd = new SqlCommand("INSERT INTO StudentRegs (StudentID, Name, Surname, Address, City, CellPhone) VALUES (@StudentID, @Name, @Surname, @Address, @City, @CellPhone)", con);
            cmd.Parameters.AddWithValue("@StudentID", StudentID);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Surname", Surname);
            cmd.Parameters.AddWithValue("@Address", Address);
            cmd.Parameters.AddWithValue("@City", City);
            cmd.Parameters.AddWithValue("@CellPhone", CellPhone);
            cmd.ExecuteNonQuery();
            con.Close();    


        }

        public void Deletestudent(int StudentID)
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM StudentRegs WHERE StudentID = @StudentID", con);
            cmd.Parameters.AddWithValue("@StudentID", StudentID);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public void Updatestudent(int StudentID, string Name, string Surname, string Address, string City, string CellPhone)
        {
            con.Open();
            cmd = new SqlCommand("UPDATE StudentRegs SET Name = @Name, Surname = @Surname, "+
                "Address = @Address, City = @City, CellPhone = @CellPhone WHERE StudentID = @StudentID", con);
            cmd.Parameters.AddWithValue("@StudentID", StudentID);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Surname", Surname);
            cmd.Parameters.AddWithValue("@Address", Address);
            cmd.Parameters.AddWithValue("@City", City);
            cmd.Parameters.AddWithValue("@CellPhone", CellPhone);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public DataTable Displaystudent()
        {
            dt.Clear();
            con.Open();
            cmd = new SqlCommand("SELECT * FROM StudentRegs", con); 
            dReader = cmd.ExecuteReader();
            dt.Load(dReader);
            con.Close();
            return dt;
        }
    }
}
