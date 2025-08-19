using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces
{
    public interface ILogger
    {
        void Log(string message);
    }

    public class FileLogger : ILogger
    {
        public void Log(string message)
        {
            // Implementation for logging to a file

            // This is an example of file handling in C#.
            string directoryPath = @"C:\Logs";
            string filePath = Path.Combine(directoryPath, "log.txt");

            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }
            File.AppendAllText(filePath, message + "\n");
        }
    }

    public class  DatabaseLogger : ILogger
    {
        public void Log(string message)
        {
            // Implementation for logging to a database
            // This is an example of database handling in C#.
            Console.WriteLine("Logging to the database is not implemented yet.");
            // You would typically use ADO.NET or an ORM like Entity Framework here.
        }
    }

    public class Application
    {
        private readonly ILogger _logger;
        public Application(ILogger logger)
        {
            _logger = logger;
        }
        public void Run()
        {
            // Example usage of the logger
            _logger.Log("Application started.");
            // Perform application logic here
            _logger.Log("Application finished.");
        }
    }

}
