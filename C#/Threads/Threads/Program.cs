namespace Threads
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*  Console.WriteLine("Hello, World!");

              Thread.Sleep(1000);

              Console.WriteLine("Threads");
              Thread.Sleep(1000);
              Console.WriteLine("Threads");
              Thread.Sleep(1000);
              Console.WriteLine("Threads");
              Thread.Sleep(1000);
              Console.WriteLine("Threads");
            */


            /* new Thread(() =>
             {
                 Thread.Sleep(1000);
                 Console.WriteLine("Hello, World!");
             }).Start();

             new Thread(() => {
                 Thread.Sleep(1000);
                 Console.WriteLine("Threads");
                 }).Start();

             */

            /* var taskCompleteSource = new TaskCompletionSource<bool>();
             var thread = new Thread(() =>
             {
                 Thread.Sleep(1000);
                 Console.WriteLine("Hello, World!");
                 taskCompleteSource.TrySetResult(true);
                 Console.WriteLine($"Thread {Thread.CurrentThread.ManagedThreadId} has completed work.");
             });

             thread.Start();
             var test = taskCompleteSource.Task.Result;
             Console.WriteLine("task was done " + test);*/

           /* Enumerable.Range(0, 100).ToList().ForEach(i =>
            {
                new Thread(() =>
                {
                    Thread.Sleep(1000);
                    Console.WriteLine($"Thread {Thread.CurrentThread.ManagedThreadId} has completed work.");
                }).Start();
            });*/



            Console.WriteLine("Main Thread Started");
            Thread thread1 = new Thread(ThreadFunction);
            Thread thread2 = new Thread(ThreadFunction2);

            thread1.Start();
            thread2.Start();

            thread1.Join();
            Console.WriteLine("Thread 1 has completed.");

            thread2.Join();
            Console.WriteLine("Thread 2 has completed.");

            Console.ReadKey();
        }

        public static void ThreadFunction()
        {
            Thread.Sleep(1000);
            Console.WriteLine("Hello, World!");
        }

        public static void ThreadFunction2()
        {
            Thread.Sleep(1000);
            Console.WriteLine("Threads");
        }
    }
}
