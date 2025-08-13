using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    internal class Customer
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string ContactNmber { get; set; }

        public Customer(string name, string address, string contactNumber)
        {
            Name = name;
            Address = address;
            ContactNmber = contactNumber;
            Console.WriteLine($"Customer created: {Name}, Address: {Address}, Contact: {ContactNmber}");
        }

        public Customer(string name)
        {
            Name = name;
            ContactNmber = "Not Provided";
            Console.WriteLine($"Customer created: {Name}");
        }

    }
}
