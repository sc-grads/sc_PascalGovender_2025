using System;
using System.Collections.Generic;
using System.Configuration;
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
using System.Data.SqlClient;
using System.Data;
namespace WPFZooManager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        SqlConnection connection;
        public MainWindow()
        {
            InitializeComponent();

            string connectionString = ConfigurationManager.ConnectionStrings["WPFZooManager.Properties.Settings.CSharpUdemyDBConnectionString"].ConnectionString;
            connection = new SqlConnection(connectionString);
            ShowZoos();
            ShowAllAnimals();
        }

        private void ShowZoos()
        {
            try
            {


                string query = "SELECT * FROM Zoo";

                // Create a SqlDataAdapter to execute the query and fill a DataTable
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);

                using (adapter)
                {
                    DataTable zooTable = new DataTable();
                    adapter.Fill(zooTable);

                    lstZoos.DisplayMemberPath = "Location";

                    lstZoos.SelectedValuePath = "Id";

                    lstZoos.ItemsSource = zooTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }

        }
        private void ShowAssociatedAnimals()
        {
            try
            {
                string query = "SELECT * FROM Animal a inner join ZooAnimal za on a.Id = za.AnimalID where za.ZooID = @ZooId";

                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@ZooId", lstZoos.SelectedValue);

                SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);

                using (adapter)
                {
                    DataTable animalTable = new DataTable();
                    adapter.Fill(animalTable);

                    lstAssociatedAnimals.DisplayMemberPath = "Name";

                    lstAssociatedAnimals.SelectedValuePath = "Id";

                    lstAssociatedAnimals.ItemsSource = animalTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                // MessageBox.Show(ex.Message);

            }

        }
        private void lstZoos_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ShowAssociatedAnimals();
            ShowSelectedZooInText();
        }
        private void ShowAllAnimals()
        {
            try
            {
                string query = "SELECT * FROM Animal";
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);

                using (adapter)
                {
                    DataTable animalTable = new DataTable();
                    adapter.Fill(animalTable);
                    lstAnimals.DisplayMemberPath = "Name";
                    lstAnimals.SelectedValuePath = "Id";
                    lstAnimals.ItemsSource = animalTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }

        }

        private void btnDeleteZoo_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "DELETE FROM Zoo WHERE Id = @ZooId";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@ZooId", lstZoos.SelectedValue);

                connection.Open();
                sqlCommand.ExecuteScalar();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowZoos();
            }
        }

        private void btnRemoveAnimal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "DELETE FROM ZooAnimal WHERE AnimalID = @AnimalId AND ZooID = @ZooId";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@AnimalId", lstAnimals.SelectedValue);
                sqlCommand.Parameters.AddWithValue("@ZooId", lstZoos.SelectedValue);
                connection.Open();
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowAssociatedAnimals();
            }
        }

        private void btnDeleteAnimal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "DELETE FROM Animal WHERE Id = @AnimalId";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@AnimalId", lstAnimals.SelectedValue);

                connection.Open();
                sqlCommand.ExecuteScalar();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowAllAnimals();
            }

        }

        private void btnAddZoo_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "INSERT INTO Zoo (Location) VALUES (@Location)";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@Location", txtBox.Text);

                connection.Open();
                sqlCommand.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowZoos();
                txtBox.Clear();
            }
        }

        private void btnAddAnimal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "INSERT INTO Animal (Name) VALUES (@Name)";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@Name", txtBox.Text);

                connection.Open();
                sqlCommand.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowAllAnimals();
                txtBox.Clear();
            }
        }

        private void btnAddtoZoo_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "INSERT INTO ZooAnimal (ZooID, AnimalID) VALUES (@ZooId, @AnimalId)";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@ZooId", lstZoos.SelectedValue);
                sqlCommand.Parameters.AddWithValue("@AnimalId", lstAnimals.SelectedValue);
                connection.Open();
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowAssociatedAnimals();
            }
        }

        private void btnUpdateZoo_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "UPDATE Zoo SET Location = @Location WHERE Id = @ZooId";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@Location", txtBox.Text);
                sqlCommand.Parameters.AddWithValue("@ZooId", lstZoos.SelectedValue);
                connection.Open();
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowZoos();
                ShowAssociatedAnimals();
                txtBox.Clear();
            }

        }

        private void btnUpdateAnimal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = "UPDATE Animal SET Name = @Name WHERE Id = @AnimalId";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@Name", txtBox.Text);
                sqlCommand.Parameters.AddWithValue("@AnimalId", lstAnimals.SelectedValue);
                connection.Open();
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
                ShowAllAnimals();
                ShowAssociatedAnimals();
                txtBox.Clear();
            }
        }

        private void ShowSelectedZooInText()
        {
            if (lstZoos.SelectedItem != null)
            {
                DataRowView selectedRow = (DataRowView)lstZoos.SelectedItem;
                txtBox.Text = selectedRow["Location"].ToString();
            }
            else
            {
                txtBox.Clear();
            }
        }

        private void ShowSelectedAnimalInText()
        {
            if (lstAnimals.SelectedItem != null)
            {
                DataRowView selectedRow = (DataRowView)lstAnimals.SelectedItem;
                txtBox.Text = selectedRow["Name"].ToString();
            }
            else
            {
                txtBox.Clear();
            }
        }

        private void lstAnimals_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ShowSelectedAnimalInText();
        }
    }
}
