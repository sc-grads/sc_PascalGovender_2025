
////FOR LOOP
//for (int i = 0; i < 10; i++)
//{
//    Console.WriteLine("i is " + i);
//}

//-----------------------------------------------------------------------------------------------
///ROCKET PROJECT
// in strings \ is an "Escape Character"
// \n stands for "new line"
// \r - carriage return

//string rocket = "     |\r\n     |\r\n    / \\\r\n   / _ \\\r\n  |.o '.|\r\n  |'._.'|\r\n  |     |\r\n ,'|  | |`.\r\n/  |  | |  \\\r\n|,-'--|--'-.|";

//for (int counter = 10; counter >= 0; counter--)
//{
//    Console.Clear();
//    Console.WriteLine("Counter is " + counter);
//    Console.WriteLine(rocket);
//    rocket = "\r\n" + rocket;
//    Thread.Sleep(1000);
//}
//Console.WriteLine("The Rocket has Landed!");

//Console.ReadKey();

//--------------------------------------------------------------------------------------
////WHILE LOOP

//Console.WriteLine("Enter go or stay");

//string userChoice = Console.ReadLine();

//while (userChoice == "go")
//{
//    Console.WriteLine("Go for a mile");
//    Console.WriteLine("Wanna keep going? Enter go.");
//    userChoice = Console.ReadLine();
//}
//Console.WriteLine("Finally you are staying!");

//Console.ReadKey();

//--------------------------------------------------------------------------------------
//// GUESS THE NUMBER

//Random random = new Random();

//int secretNumber = random.Next(1, 101);
//int userGuess = 0;
//int counter = 0;

//Console.WriteLine("Guess the number I'm thinking of between 1 and 100");

//while (userGuess != secretNumber)
//{
//    counter++;
//    Console.WriteLine("Enter your guess:");
//    userGuess = int.Parse(Console.ReadLine());
//    if (userGuess < secretNumber)
//    {
//        Console.WriteLine("Too low! Try again.");
//    }
//    else if (userGuess > secretNumber)
//    {
//        Console.WriteLine("Too high! Try again.");
//    }
//    else
//    {
//        Console.WriteLine("Congratulations! You guessed the number right! It took you " + counter + " tries!");
//    }
//}

//Console.ReadKey();

//DO WHILE LOOP

int num;

do
{
    Console.WriteLine("Enter a positive whole number");
    num = int.Parse(Console.ReadLine());
} while (num <= 0);
Console.WriteLine("Finally!!!");
Console.ReadKey();

//break - stops the loop
//continue - skips the current loop