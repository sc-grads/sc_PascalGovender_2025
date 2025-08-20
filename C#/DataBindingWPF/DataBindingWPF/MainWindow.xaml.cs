using DataBindingWPF.Data;
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

namespace DataBindingWPF
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public List<Person> People = new List<Person>
        {
            new Person { Name = "Alice", Age = 30 },
            new Person { Name = "Bob", Age = 25 },
            new Person { Name = "Charlie", Age = 35 },
            new Person { Name = "Diana", Age = 28 },
            new Person { Name = "Ethan", Age = 22 }
        };
        public MainWindow()
        {
            InitializeComponent();
            //this.DataContext = person;

            lstbxPeople.ItemsSource = People;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            // display the person's name and age in a message box
            //MessageBox.Show($"Name: {person.Name}, Age: {person.Age}");
            var selectedItems = lstbxPeople.SelectedItems;
            foreach (var item in selectedItems)
            {
                var p = (Person)item;
                MessageBox.Show($"Name: {p.Name}, Age: {p.Age}");
            }
        }
    }
}