using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inheritence
{
    internal class Animal
    {
        public void Eat()
        {
            Console.WriteLine("Eating...");
        }

        // Virtual method to be overridden in derived classes
        public virtual void Sound()
        {
            Console.WriteLine("Animal sound...");
        }
    }

    // Dog class inherits from Animal class
    //derives from Animal class(child class)
    class Dog : Animal
    {
        // Overriding the Sound method from Animal class
        public override void Sound()
        {
            base.Sound(); // Call the base class method
            Console.WriteLine("Barking...");
        }
    }

    class Cat : Animal
    {
        // Overriding the Sound method from Animal class
        public override void Sound()
        {
            Console.WriteLine("Meowing...");
        }
    }

    class Collie : Dog
    {
        public void Herd()
        {
            Console.WriteLine("Herding...");
        }
    }
}
