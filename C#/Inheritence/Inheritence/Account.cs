using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Inheritence
{
    public class Account
    {
        public string AccountNumber { get; private set; }
        public decimal Balance { get; private set; }

        public Account(string accountNumber, decimal initialBalance)
        {
            AccountNumber = accountNumber;
            Balance = initialBalance;
        }

        public void Deposit(decimal amount)
        {
            Balance += amount;
            Console.WriteLine($"Deposited {amount:C} to account {AccountNumber}. New balance: {Balance:C}");
        }

        public virtual void Withdraw(decimal amount)
        {
            if (amount > Balance)
            {
                Console.WriteLine($"Insufficient funds for withdrawal from account {AccountNumber}.");
            }
            else
            {
                Balance -= amount;
                Console.WriteLine($"Withdrew {amount:C} from account {AccountNumber}. New balance: {Balance:C}");
            }
        }
    }

    public sealed class SavingsAccount : Account
    {
        public SavingsAccount(string accountNumber, decimal initialBalance)
            : base(accountNumber, initialBalance)
        {
        }

        public override void Withdraw(decimal amount)
        {
            if (amount > Balance)
            {
                Console.WriteLine($"Insufficient funds for withdrawal from savings account {AccountNumber}.");
            }
            else
            {
                base.Withdraw(amount);
                Console.WriteLine($"Withdrew {amount:C} from savings account {AccountNumber}. New balance: {Balance:C}");
            }
        }
    }
}
