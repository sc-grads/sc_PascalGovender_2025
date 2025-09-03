using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace StudentRegistrationProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        ConnectToDBs ctDB = new ConnectToDBs();
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            ctDB.Registerstudent(int.Parse(txtID.Text), txtName.Text, txtSurname.Text, txtAddress.Text, txtCity.Text, txtPhone.Text);
            MessageBox.Show("Student Registered Successfully!");

            txtAddress.Clear();
            txtCity.Clear();
            txtID.Clear();
            txtName.Clear();
            txtPhone.Clear();
            txtSurname.Clear();


        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            ctDB.Deletestudent(int.Parse(txtID.Text));
            MessageBox.Show("Student Deleted Successfully!");

            txtAddress.Clear();
            txtCity.Clear();
            txtID.Clear();
            txtName.Clear();
            txtPhone.Clear();
            txtSurname.Clear();
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            
            ctDB.Updatestudent(int.Parse(txtID.Text), txtName.Text, txtSurname.Text, txtAddress.Text, txtCity.Text, txtPhone.Text);
            MessageBox.Show("Student Updated Successfully!");

            txtAddress.Clear();
            txtCity.Clear();
            txtID.Clear();
            txtName.Clear();
            txtPhone.Clear();
            txtSurname.Clear();
        }

        private void btnReadData_Click(object sender, RoutedEventArgs e)
        {
            StudentData studentData = new StudentData();    
            studentData.Show();
        }
    }
}