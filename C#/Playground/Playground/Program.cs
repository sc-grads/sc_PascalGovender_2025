namespace Playground
{
    public class Student
    {
        public int ID { get; set; }
        public string Name { get; set; } = string.Empty;
        public int Grade { get; set; }

        public Student(string name, int id, int grade)
        {
            ID = id;
            Name = name;
            Grade = grade;
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            var students = new Dictionary<string, Student>
            {
                {"John", new Student("John",1,85)},
                {"Alice", new Student("Alice",2,90)},
                {"Bob", new Student("Bob",3,78)}
            };

            foreach (KeyValuePair<string, Student> s in students)
            {
                Console.WriteLine($"Name: {s.Value.Name}, Id: {s.Value.ID}, Grade: {s.Value.Grade}");
            }

            Console.ReadKey();
        }
    }
}
