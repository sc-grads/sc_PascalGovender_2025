﻿namespace FunctionsFull
{
    internal class Program
    {
        //Field (or instance varible)
        static int myResult;
        static void Main(string[] args)
        {
            Console.WriteLine("Enter a number and I'll add 10 to it!");
            int num1 = int.Parse(Console.ReadLine());
  

            myResult = AddTwoValues(num1, 10);
            Console.WriteLine("The result is " + myResult);
            Console.ReadKey();
        }

        static int AddTwoValues(int value1, int value2)
        {
            myResult  = value1 + value2;
            return myResult;
        }

        static int SubtractTwoValues(int value1, int value2)
        {
            myResult = value1 - value2;
            return myResult;
        }

    }
}
