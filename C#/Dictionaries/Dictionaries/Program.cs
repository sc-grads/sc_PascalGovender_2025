using System;

namespace Dictionaries
{
    class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int salary { get; set; }

        public Employee(int id, string name, int salary)
        {
            Id = id;
            Name = name;
            this.salary = salary;
        }

    }
    internal class Program
    {
        static void Main(string[] args)
        {
            /*
            // key - value

            //Declaring and initialising variable 
            Dictionary<int, string> employees = new Dictionary<int, string>();

            // Adding elements to the dictionary
            employees.Add(101, "John Doe");
            employees.Add(102, "Jane Smith");
            employees.Add(103, "Bob Brown");
            employees.Add(104, "Alice Green");
            employees.Add(105, "Charlie Blue");

            string name = employees[101]; // Accessing value by key
            Console.WriteLine(name);

            // updating an existing value
            employees[102] = "Alice Johnson";

            // Checking if a key exists before adding a new element
            if (employees.ContainsKey(104))
            {
                employees.Add(106, "Eve White"); // Adding a new element
            }

            bool added = employees.TryAdd(107, "Frank Black"); // Adding a new element with TryAdd
            if (!added)
            {
                Console.WriteLine("Employee with ID 107 already exists.");
            }

            employees.Remove(103); // Removing an element by key

            // Iterating through the dictionary
            foreach (KeyValuePair<int, string> employee in employees)
            {
                Console.WriteLine($"ID: {employee.Key}, Name: {employee.Value}");
            }

            // Finding the next available ID
            int counter = 101;

            while (employees.ContainsKey(counter))
            {
                counter++;
            }
            employees.Add(counter, "New Employee"); // Adding a new employee with the next available ID*/

            /*
            // Using a dictionary with a custom class
            Dictionary<int, Employee> employees = new Dictionary<int, Employee>();

            employees.Add(101, new Employee(101, "John Doe", 50000));
            employees.Add(102, new Employee(102, "Jane Smith", 60000));
            employees.Add(103, new Employee(103, "Bob Brown", 55000));
            employees.Add(104, new Employee(104, "Alice Green", 70000));
            employees.Add(105, new Employee(105, "Charlie Blue", 65000));

            // Accessing an employee by ID
            foreach (KeyValuePair<int, Employee> employee in employees)
            {
                Console.WriteLine($"ID: {employee.Key}, Name: {employee.Value.Name}, Salary: {employee.Value.salary}");
            }

            // Example of using a dictionary with a list of integers
            Dictionary<string, List<int>> numbers = new Dictionary<string, List<int>>();
            numbers.Add("nums1", new List<int> { 1, 2, 3 });
            foreach (KeyValuePair<string, List<int>> num in numbers)
            {
                foreach (int x in num.Value)
                {
                    Console.Write(x + " ");
                }
            }
            */

            // Example of using a dictionary with string keys and values and initialization syntax 1
            /*var codes = new Dictionary<string, string>
            {
                { "C#", "C Sharp" },
                { "Java", "Java Programming Language" },
                { "Python", "Python Programming Language" },
                { "JavaScript", "JavaScript Programming Language" }
            };*/

            // Example of using a dictionary with string keys and values
            var codes = new Dictionary<string, string>
            {
                ["NY"] = "New York",
                ["CA"] = "California",
                ["TX"] = "Texas",
                ["FL"] = "Florida",
                ["IL"] = "Illinois"
            };

            // checking if a key exists and accessing its value
            if (codes.TryGetValue("NY", out string cityName))
            {
                Console.WriteLine($"The full name of NY is {cityName}.");
            }

            foreach (var code in codes)
            {
                Console.WriteLine($"Code: {code.Key}, Full Name: {code.Value}");
            }
            Console.ReadLine();
        }
    }
}
