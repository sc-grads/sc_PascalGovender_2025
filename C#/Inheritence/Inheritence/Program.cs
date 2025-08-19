namespace Inheritence
{
    internal class Program
    {
        static void Main(string[] args)
        {
           /* Dog myDog = new Dog();

            myDog.Sound(); // Calling method from the derived class

            Cat myCat = new Cat();
            myCat.Sound(); // Calling method from the derived class
           */


            //Employee joe = new Employee("Joe", 30, "Developer", 12345);
            //joe.DisplayEmployeeInfo(); // Calling method from the derived class

            Manager carl = new Manager("Carl", 40, "Team Lead", 67890, 7);
            carl.DisplayManagerInfo(); // Calling method from the derived class

            carl.becomeOlder(5); // Calling method from the base class

            Console.ReadKey();
        }
    }

}
