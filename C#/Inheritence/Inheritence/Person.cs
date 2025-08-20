using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inheritence
{
    public class Person
    {
        public string Name { get; private set; }
        public int Age { get; private set; }
        // Constructor
        public Person(string name, int age)
        {
            Name = name;
            Age = age;
            Console.WriteLine("Person constructor called.");
        }
        // Method to display person details
        public void DisplayPersonInfo()
        {
            Console.WriteLine($"Name: {Name}, Age: {Age}");
        }

        
        /// <summary>
        /// Increases the current age by the specified number of years.
        /// </summary>
        /// <param name="years">The number of years to add to the current age. Must be a non-negative value.</param>
        /// <returns>The updated age after adding the specified number of years.</returns>
        public int becomeOlder(int years)
        {
            Age += years;
            return Age;
        }
    }


    // Derived class
    public class Employee : Person
    {
        public string JobTitle { get; private set; }
        public int EmployeeId { get; private set; }
        public Employee(string name, int age, string jobTitle, int employeeId) : base(name, age)
        {
            JobTitle = jobTitle;
            EmployeeId = employeeId;
            Console.WriteLine("Employee (derived class) constructor called.");
        }

        // Overriding the DisplayInfo method
        public void DisplayEmployeeInfo()
        {
            DisplayPersonInfo(); // Call the base class method
            Console.WriteLine($"Job Title: {JobTitle}, Employee ID: {EmployeeId}");
        }
    }

    public class Manager : Employee
    {
        public int TeamSize { get; private set; }
        public Manager(string name, int age, string jobTitle, int employeeId, int teamSize) 
            : base(name, age, jobTitle, employeeId)
        {
            TeamSize = teamSize;
            Console.WriteLine("Manager (derived class) constructor called.");
        }
        // Overriding the DisplayInfo method
        public void DisplayManagerInfo()
        {
            DisplayEmployeeInfo(); // Call the base class method
            Console.WriteLine($"Team Size: {TeamSize}");
        }
    }
}
