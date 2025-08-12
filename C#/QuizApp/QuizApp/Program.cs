//// See https://aka.ms/new-console-template for more information

//string question1 = "What is O2";
//string answer1 = "Oxygen";

//string question2 = "What is 2+2";
//string answer2 = "4";

//string question3 = "What color do you get by mixing blue and yellow";
//string answer3 = "Green";

////quiz to user
//int score = 0;
//Console.WriteLine(question1);
//string userAnswer1 = Console.ReadLine();
//if (userAnswer1.Trim().ToLower() == answer1.ToLower())
//{

//    Console.WriteLine("Correct!");
//    //score = score+1;
//    score++;
//}
//else
//{
//    Console.WriteLine("Wrong, the correct answer is: " + answer1);
//}

//Console.WriteLine(question2);
//string userAnswer2 = Console.ReadLine();
//if (userAnswer2.Trim().ToLower() == answer2.ToLower())
//{
//    Console.WriteLine("Correct!");
//    score++;
//}
//else
//{
//    Console.WriteLine("Wrong, the correct answer is: " + answer2);
//}


//Console.WriteLine(question3);
//string userAnswer3 = Console.ReadLine();
//if (userAnswer3.Trim().ToLower() == answer3.ToLower())
//{
//    Console.WriteLine("Correct!");
//    score++;
//}
//else
//{
//    Console.WriteLine("Wrong, the correct answer is: " + answer3);
//}

////Score check

//Console.WriteLine($"Quiz completed! Your final score is: {score}/3");
//if (score == 3)
//{
//    Console.WriteLine("Excellent! You got all the answers right!");
//}
//else if (score > 0)
//{
//    Console.WriteLine("Good Job, but keep learning!");
//}
//else
//{
//    Console.WriteLine("Try again and see if you can get some answers right next time!");
//}


//Console.ReadKey();

Console.WriteLine("Enter first number below:");
double num1 = double.Parse(Console.ReadLine());
Console.WriteLine("Enter second number below:");
double num2 = double.Parse(Console.ReadLine());

Console.WriteLine("Choose an operation: +, -, *, /");
string operatorChoice = Console.ReadLine();
if (operatorChoice == "-")
{
    Console.WriteLine("Subtraction: "+ (num1-num2));
}else if (operatorChoice == "+")
{
    Console.WriteLine("Addition: " + (num1 + num2));
}else if(operatorChoice == "*")
{
    Console.WriteLine("Multiplication: " + (num1 * num2));
}
else if (operatorChoice == "/")
{
    if(num2 == 0)
    {
        Console.WriteLine("Invalid Entry! Division by 0 not allowed");
    }
    else
    {
        Console.WriteLine("Division: " + (num1/num2));
    }
}
else
{
    Console.WriteLine("Invalid Operation, please try again");
}

Console.ReadKey();