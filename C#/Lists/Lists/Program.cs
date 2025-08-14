namespace Lists
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // This program demonstrates the use of a List in C#

            /*
            // Create a List of strings to hold color names
            //List<string> colors = new List<string>();

            //colors.Add("Red");
            //colors.Add("Green");
            //colors.Add("Blue");

            // initializing a List with some colors
            List<string> colors =[
            
                "Red",
                "Green",
                "Blue"
            ];

            // display the colors in the list
            foreach (string color in colors)
            {
                Console.WriteLine(color);
            }

            // remove a color from the list
            colors.Remove("Red");

            Console.WriteLine("\nAfter removing Green:");
            foreach (string color in colors)
            {
                Console.WriteLine(color);
            }

            // delete all occurrences of "Red" from the list
            bool deletedRed = colors.Remove("Red");
            while (deletedRed)
            {
                deletedRed = colors.Remove("Red");
            }*/


            ////Sorting a List of integers
            /*
            List<int> numbers = new List<int> {7,22,6,45,95,2,4,0,8 };

            Console.WriteLine("Original List:");
            foreach (int number in numbers)
            {
                Console.WriteLine(number);
            }

            // Sort the list
            numbers.Sort();
            Console.WriteLine("\nSorted List:");
            foreach (int number in numbers)
            {
                Console.WriteLine(number);
            }

            // returns a new List with numbers greater than 10
            Console.WriteLine("\nNumbers greater than 10:");
            List<int> higherThan10 =  numbers.FindAll(x => x > 10);
            foreach (int number in higherThan10)
            {
                Console.WriteLine(number);
            }

           /* static int Squarring(int x)
            {
                return x * x;
            }

            static int SquarringLambda(int x) => x * x;

            // Define predicate to check if a number is greater than 10
            Predicate<int> isGreaterThan10 = x => x > 10;
            List<int> higherTen = numbers.FindAll(isGreaterThan10);

            Console.WriteLine("\nNumbers greater than 10 using Predicate:");
            foreach (int number in higherTen)
            {
                Console.WriteLine(number);
            }


           bool hasLargeNumbers = numbers.Any(x => x > 50); // returns true if any number is greater than 50
            if (hasLargeNumbers)
            {
                Console.WriteLine("\nThere are numbers greater than 50 in the list.");
            }
            else
            {
                Console.WriteLine("\nThere are no numbers greater than 50 in the list.");
            }
            */


            // Create a List of Product objects directly in the code
            //Complex data types
            List<Product> products = new List<Product>
            {
                new Product { Name = "Laptop", Price = 999.99 },
                new Product { Name = "Smartphone", Price = 499.99 },
                new Product { Name = "Tablet", Price = 299.99 }
            };

            List<Product> cheapProducts = products.Where(p => p.Price < 300.00).ToList();

            Console.WriteLine("Products with price less than 300:");
            foreach (Product product in cheapProducts)
            {
                Console.WriteLine($"{product.Name} - ${product.Price}");
            }


            Console.ReadKey();
        }
    }
}
//LAMBDA EXPRESSIONS
// A lambda expression consists of 2 parts:
// 1. Input parameters: x =>
// 2. Expression or statement block: x > 10

//parameters are written before the arrow (=>) read as 'goes to',
//and the expression or block of code follows it.

//this reads as:
//"Take an input x and turn it into x multiplied by x"
// x => x * x

//DELEGATES
/*In C#, a delegate is a type that represents references to methods 
 with a specific parameter list and return type.

It allows methods to be passed as parameters, 
 
 */