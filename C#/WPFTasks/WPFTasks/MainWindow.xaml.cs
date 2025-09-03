using System.Diagnostics;
using System.Net.Http;
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

namespace WPFTasks
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
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Task.Run(() =>
            {
                Debug.WriteLine("Thread No. " + Thread.CurrentThread.ManagedThreadId);
                HttpClient webClient = new HttpClient();
                string html = webClient.GetStringAsync("http://ipv4.download.thinkbroadband.com/20MB.zip").Result;

                btn1.Dispatcher.Invoke(() =>
                {
                    btn1.Content = "Download Completed part 1";
                });
            });
        }

        private async void Button2_Click(object sender, RoutedEventArgs e)
        {
            Debug.WriteLine("Thread No. " + Thread.CurrentThread.ManagedThreadId+"before await");

            await Task.Run(() =>
            {
                Debug.WriteLine("Thread No. " + Thread.CurrentThread.ManagedThreadId + "during await");

                HttpClient webClient = new HttpClient();
                string html = webClient.GetStringAsync("http://www.google.com").Result;
            });

            Debug.WriteLine("Thread No. " + Thread.CurrentThread.ManagedThreadId + "after await");

            btn1.Content = "Download Completed";
        }


    }
}