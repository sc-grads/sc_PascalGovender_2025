using System;
using Domain;

namespace CalculatorTest
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            var calculator = new Calculator();
            if (calculator.Sum(2, 2) != 4)
            {
                throw new Exception($"The Sum(2,2) was expected to be 4 but returned {calculator.Sum(2, 2)}");
            }
        }

       
    }
}
