using System;

namespace exercise3
{
    
    class Program
    {
        private static void ReverseStringWithInbuiltMethod(string stringInput)
        {
            // With Inbuilt Method Array.Reverse Method  
            char[] charArray = stringInput.ToCharArray();
            Array.Reverse(charArray);
            Console.WriteLine(new string(charArray));
        }
        static void Main(string[] args)
        {
            Console.WriteLine("Please enter your string");
            string input = Console.ReadLine();
            Console.WriteLine("Here is the reverse string: ");
            ReverseStringWithInbuiltMethod(input);
           
        }
    }
}
