using System.Text.RegularExpressions;

namespace RegexE
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // defining a regular expression with a pattern
            Regex regex = new Regex(@"\d");

            // Test string
            string text = "Hi there 123";

            // Find hits
            MatchCollection hits = regex.Matches(text);

            // displaying the results
            Console.WriteLine("{0} hits found:\n   {1}",
                              hits.Count,
                              text);

            // displaying the results
            foreach (Match aHit in hits)
            {
                GroupCollection groups = aHit.Groups;
                Console.WriteLine("'{0}' found at {1}",
                                  groups["word"].Value,
                                  groups[0].Index
                                 );
            }
                


            /*Define a method ExtractPatterns in the Exercise class.

The ExtractPatterns method should take a string input as a parameter.

Use a regular expression to match all email addresses in the input string.

Print each matched email address to the console.*/

            Regex regex1 = new Regex(@"\w+@\w+\.\w{3}");

            string input = "Contact us at support@example.com or sales@example.org";

            MatchCollection hits1 = regex1.Matches(input);

            foreach (Match aHit in hits)
            {
                Console.WriteLine("'{0}' found at {1}",
                                  aHit.Value,
                                  aHit.Index
                                 );
            }

            //displaying email addresses
            Console.WriteLine("\nEmail addresses found:");
            foreach (Match email in hits1)
            {
                Console.WriteLine(email.Value);
            }

            Console.ReadKey();

        }
    }
}
