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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace InvoiceManagement
{
    /// <summary>
    /// Interaction logic for LoginView.xaml
    /// </summary>
    public partial class LoginView : UserControl
    {
        public LoginView()
        {
            InitializeComponent();

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string passEntered = passBox.Password;

            string? envPass = Environment.GetEnvironmentVariable("InvoiceManagement");

            if (envPass != null)
            {
                if (envPass == passEntered)
                {
                    MessageBox.Show("Login successful!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                else
                {
                    MessageBox.Show("Incorrect password. Please try again.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Environment variable 'InvoiceManagement' not found.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        public void OnPasswordChanged(object sender, RoutedEventArgs e)
        {
            btnLogin.IsEnabled = !string.IsNullOrEmpty(passBox.Password);
        }
    }
}
