namespace Interfaces
{
    // This is an example of an interface in C#.
    
    internal class Program
    {
        static void Main(string[] args)
        {
            /*
            IPaymentProcessor creditCardProcessor  = new CreditCardProcessor();
            PaymentService paymentService = new PaymentService(creditCardProcessor);
            paymentService.MakePayment(100.00m);

            IPaymentProcessor payPalProcessor = new PayPalProcessor();
            paymentService = new PaymentService(payPalProcessor);
            paymentService.MakePayment(50.00m);
            */
            // Uncomment the above lines to test the payment processing functionality.

            /*Decoupling:
            - The Application class is now decoupled from specific logger implementations.
            - This allows for easier testing and flexibility in logging strategies.
            - You can easily switch between different logging mechanisms without 
                changing the Application class.
            */
            ILogger logger = new FileLogger();
            Application app = new Application(logger);
            app.Run();

            ILogger dbLogger = new DatabaseLogger();
            app = new Application(dbLogger);
            app.Run();

            Console.ReadKey();
        }
    }
}
