using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuizAppV2
{
    internal class Quiz
    {
        private Question[] questions;
        private int _score;

        public Quiz(Question[] questions)
        {
            this.questions = questions;
            _score = 0; // Initialize score to 0
        }

        public void Start()
        {
            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Welcome to the Quiz!");
            Console.ResetColor(); // Reset color to default

            foreach (var question in questions)
            {
                DisplayQuestion(question);
                int userAnswer = GetUserAnswer();
                if (question.IsCorrect(userAnswer))
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("Correct!");
                    _score++; // Increment score for correct answer
                }
                else
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine($"Incorrect! The correct answer was: {question.Options[question.CorrectOptionIndex]}");
                }
                Console.ResetColor(); // Reset color to default
            }

            DisplayResults();

        }

        private void DisplayResults()
        {
            Console.ForegroundColor = ConsoleColor.Magenta;
            Console.WriteLine("╔═════════════════════════════════════════════════════════════════════════╗");
            Console.WriteLine("║                                 Results                                 ║");
            Console.WriteLine("╚═════════════════════════════════════════════════════════════════════════╝");
            Console.ResetColor(); // Reset color to default
            Console.WriteLine("Thank you for participating in the quiz!");
            Console.WriteLine($"Your score: {_score} out of {questions.Length}");

            double percentage = ((double)_score / questions.Length) * 100;
            if (percentage >= 80)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("Excellent job! You scored above 80%!");
            }
            else if (percentage >= 50)
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine("Good job! You scored between 50% and 80%.");
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("You scored below 50%. Better luck next time!");
            }
            Console.ResetColor(); // Reset color to default
        }

        public void DisplayQuestion(Question question)
        { 
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("╔═════════════════════════════════════════════════════════════════════════╗");
            Console.WriteLine("║                                 Question                                ║");
            Console.WriteLine("╚═════════════════════════════════════════════════════════════════════════╝");
            Console.ResetColor(); // Reset color to default
            Console.WriteLine(question.QuestionText);
            for (int i = 0; i < question.Options.Length; i++)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Write("  ");
                Console.Write(i + 1);
                Console.ResetColor(); // Reset color to default
                Console.WriteLine($". {question.Options[i]}");
            }

        }

        private int GetUserAnswer()
        {
            int answer;
            while (true)
            {
                Console.Write("Please select an option (1-4): ");
                string input = Console.ReadLine();
                if (int.TryParse(input, out answer) && answer >= 1 && answer <= 4)
                {
                    return answer - 1; // Convert to zero-based index
                }
                Console.WriteLine("Invalid input. Please enter a number between 1 and 4.");
            }
        }
    }
}
