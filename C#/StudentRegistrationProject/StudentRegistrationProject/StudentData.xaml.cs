using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace StudentRegistrationProject
{
    /// <summary>
    /// Interaction logic for StudentData.xaml
    /// </summary>
    /// 
    public partial class StudentData : Window
    {
        public StudentData()
        {
            InitializeComponent();
            ConnectToDBs ctDB = new ConnectToDBs();
            dataGridStudents.ItemsSource = ctDB.Displaystudent().DefaultView;
        }

        private void btnRefreshData_Click(object sender, RoutedEventArgs e)
        {
            ConnectToDBs ctDB = new ConnectToDBs();
            dataGridStudents.ItemsSource = ctDB.Displaystudent().DefaultView;
        }
    }
}
