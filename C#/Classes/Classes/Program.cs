namespace Classes
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Customer Jack = new Customer("Jack");

            Console.WriteLine($"Customer Name: {Jack.Name}");
            Console.ReadKey();
        }
    }
}
