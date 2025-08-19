using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces
{
    public interface IPaymentProcessor
    {
        void ProcessPayment(decimal amount);
    }

    public class CreditCardProcessor : IPaymentProcessor
    {
        public void ProcessPayment(decimal amount)
        {
            // Implementation for processing credit card payments
            Console.WriteLine($"Processing credit card payment of {amount:C}");
        }
    }

    public class PayPalProcessor : IPaymentProcessor
    {
        public void ProcessPayment(decimal amount)
        {
            // Implementation for processing PayPal payments
            Console.WriteLine($"Processing PayPal payment of {amount:C}");
        }
    }
    public class PaymentService
    {
        private readonly IPaymentProcessor _paymentProcessor;
        public PaymentService(IPaymentProcessor paymentProcessor)
        {
            _paymentProcessor = paymentProcessor;
        }
        public void MakePayment(decimal amount)
        {
            _paymentProcessor.ProcessPayment(amount);
        }
    }
}
