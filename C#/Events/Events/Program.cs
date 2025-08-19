namespace Events
{
    // Using the Generic Delegate EventHandler<TEventArgs>

    //public delegate void TemperatureChangedEventHandler(string message);


    public class TemperatureChangedEventArgs : EventArgs
    {
        public int Temperature { get; }
        public TemperatureChangedEventArgs(int temperature)
        {
            Temperature = temperature;
        }
    }

    public class TemperatureMonitor
    {
        //public event TemperatureChangedEventHandler OnTemperatureChanged;
        public EventHandler<TemperatureChangedEventArgs> TemperatureChanged;

        private int _temperature;
        public int Temperature
        {
            get => _temperature;
            set
            {
                if (_temperature != value)
                {
                    _temperature = value;
                    OnTemperatureChanged(new TemperatureChangedEventArgs(_temperature));
                }
            }
        }

        protected virtual void OnTemperatureChanged(TemperatureChangedEventArgs e)
        {
            TemperatureChanged?.Invoke(this,e);
        }
    }

    //sample subscriber class
    public class TemperatureAlert
    {
        public void OnTemperatureChanged(object sender, TemperatureChangedEventArgs e)
        {
            Console.WriteLine($"Alert: temperature is {e.Temperature} sender is: {sender}");
        }
    }

    public class TempCoolingAlert
    {
        public void OnTemperatureChanged(object sender, TemperatureChangedEventArgs e)
        {
            Console.WriteLine($"Cooling Alert: temperature is {e.Temperature} sender is: {sender}");
        }
    }
    internal class Program
    {
        
        static void Main(string[] args)
        {
            TemperatureMonitor monitor = new TemperatureMonitor();
            TemperatureAlert alert = new TemperatureAlert();
            TempCoolingAlert coolingAlert = new TempCoolingAlert();

            monitor.TemperatureChanged += alert.OnTemperatureChanged;
            monitor.TemperatureChanged += coolingAlert.OnTemperatureChanged;

            monitor.Temperature = 25; 

            Console.WriteLine("Enter a temperature value:");
            monitor.Temperature = int.Parse(Console.ReadLine());

            Console.ReadKey();
        }
    }
}
