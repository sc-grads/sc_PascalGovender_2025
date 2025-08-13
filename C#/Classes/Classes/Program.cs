namespace Classes
{
    internal class Program
    {
        static void Main(string[] args)
        {
            

            // Create a new instance of the Car class
            Car audi = new Car("A3","Audi",true);
            Car bmw = new Car("350i","BMW",false);

            

            Console.WriteLine($"The car brand is: {audi.Brand}"); // Accessing the brand property
            Console.WriteLine($"The car brand is: {bmw.Brand}"); // Accessing the brand property

            Console.ReadKey();
        }
    }
}
