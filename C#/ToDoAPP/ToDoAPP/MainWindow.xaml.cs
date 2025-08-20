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

namespace ToDoAPP
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void AddToDoButton_Click(object sender, RoutedEventArgs e)
        {
            string todoText = TodoInput.Text;

            if(!string.IsNullOrEmpty(todoText))
            {
                // Create a new TextBlock for the ToDo item
                TextBlock todoItem = new TextBlock
                {
                    Text ="- "+todoText,
                    Margin = new Thickness(5),
                    Foreground= new SolidColorBrush(Colors.Black)
                };
                // Add the new ToDo item to the StackPanel
                TodoList.Children.Add(todoItem);
                // Clear the input field
                TodoInput.Clear();
            }
            else
            {
                MessageBox.Show("Please enter a ToDo item.", "Input Error", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
    }
}