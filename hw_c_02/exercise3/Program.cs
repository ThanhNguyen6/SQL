using System;

namespace exercise3
{
    class Program
    {
        public static int solution(int A, int B)
        {
            return (int) (Math.Floor(Math.Sqrt(B)) - Math.Ceiling(Math.Sqrt(A)) + 1);
        }

        static void Main(string[] args)
        {
            Console.WriteLine("enter first integer A:");
            int a = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("enter second integer B:");
            int b = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine($"here is the number of perfect square between A and B: {solution(a, b)}");
        }
    }
}
