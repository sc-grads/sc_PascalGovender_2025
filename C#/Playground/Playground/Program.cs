namespace Playground
{
    public interface ITask<T>
    {
        T Perform();
    }

    public class EmailTask : ITask<string>
    {
        public string Recipient { get; set; }
        public string Message { get; set; }

        public string Perform()
        {
               return $"Email sent to {Recipient} with message: {Message}";
        }
    }

    public class ReportTask : ITask<string>
    {
        public string ReportName { get; set; }

        public string Perform()
        {
            return $"Report {ReportName}";
        }
    }

    public class TaskProcessor<TTask,TResult>
        where TTask : ITask<TResult>
    {
        private TTask _task;
        public TaskProcessor(TTask task)
        {
            _task = task;
        }

        public TResult Execute()
        {
            return _task.Perform();
        }

    }

    internal class Program
    {
        static void Main(string[] args)
        {
            var emailTask = new EmailTask()
            {
                Message = "Hello, World!",
                Recipient = "Jackson@gmail.com"
            };

            var reportTask = new ReportTask()
            {
                ReportName = "Annual Report"
            };

            var emailProcessor = new TaskProcessor<EmailTask, string>(emailTask);
            var reportProcessor = new TaskProcessor<ReportTask, string>(reportTask);

            Console.WriteLine(emailProcessor.Execute());
            Console.WriteLine(reportProcessor.Execute());
        }
    }
}
