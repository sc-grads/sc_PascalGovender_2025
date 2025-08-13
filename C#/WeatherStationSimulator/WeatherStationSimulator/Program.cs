namespace WeatherStationSimulator
{
    internal class Program
    {




        static void Main(string[] args)
        {
            Console.WriteLine("Enter the number of days to simulate");
            int days = int.Parse(Console.ReadLine());

            int[] temp = new int[days];
            string[] conditions = { "Sunny", "Rainy", "Cloudy", "Snowy" };
            string[] weatherConditions = new string[days];

            Random random = new Random();

            for (int i = 0; i < days; i++)
            {
                temp[i] = random.Next(-10, 40);
                weatherConditions[i] = conditions[random.Next(conditions.Length)];
            }

            Console.WriteLine($"Average Temperature is: {CalculateAverage(temp)}");
            Console.ReadKey();
        }

        static double CalculateAverage(int[] temperature)
        {
            double sum = 0;

            foreach (int i in temperature)
            {
                    sum += i;    
            }

            return sum / temperature.Length;
        }
    }
}
