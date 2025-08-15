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
            Console.WriteLine($"Maximum Temperature was: {temp.Max()}");
            Console.WriteLine($"Minimum Temperature was: {temp.Min()}");
            Console.WriteLine($"Most Common Weather Condition: {MostCommonCondition(weatherConditions)}");
            Console.ReadKey();
        }

        static string MostCommonCondition(string[] weatherConditions)
        {
            int count = 0;
            string mostCommon = weatherConditions[0];

            foreach (string condition in weatherConditions)
            {
                int tempCount = 0;
                for (int i = 0; i < weatherConditions.Length; i++)
                {
                    if (condition == weatherConditions[i])
                    {
                        tempCount++;
                    }
                }

                if(tempCount > count)
                {
                    count = tempCount;
                    mostCommon = condition;
                }
            }

            return mostCommon;
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
