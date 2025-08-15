using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    internal class Car
    {
        //member variables
        private string _model;
        private string _brand;
        private bool _isLuxury;

        public static int NumberOfCars = 0;

        //properties
        public string Model { get => _model; set => _model = value; }
        public string Brand
        {
            get { if (Luxury) { return _brand + " - Luxury Edition"; }else { return _brand; } }
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    Console.WriteLine("Brand cannot be empty or null.");
                }
                else { _brand = value; }
            }
        }
        public bool Luxury
        {
            get => _isLuxury;
            set => _isLuxury = value;
        }

        public Car(string model, string brand, bool luxury) { 

            NumberOfCars++;

            Model = model;
            Brand = brand;
            Luxury = luxury;
            Console.WriteLine($"A {Brand} {Model} created with luxury status: {Luxury}");
            
        }

        public Car()
        {
            NumberOfCars++;
        }

    }
}
