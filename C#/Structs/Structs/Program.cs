namespace Structs
{
    public struct Point
    {
        public int X { get; }
        public int Y { get;}

        public Point(int x, int y)
        {
            X = x;
            Y = y;
        }
        public void Display()
        {
            Console.WriteLine($"Point: ({X}, {Y})");
        }

        public double DistanceTo(Point other)
        {
            return Math.Sqrt(Math.Pow(other.X - X, 2) + Math.Pow(other.Y - Y, 2));
        }
    }
    internal class Program
    {
        static void Main(string[] args)
        {
            Point p = new Point(10, 20);
            p.Display();

            Point p2 = new Point(20, 30);
            p2.Display();

            Point p3 = new Point(50, 60);
            p3.Display();

            double distance = p.DistanceTo(p2);
            Console.WriteLine($"Distance from Point 1 to Point 2: {distance:F2}");

            Console.ReadKey();
        }
    }
}
