using System;

namespace exercise4
{
    class Program
    {
        static void Main(string[] args)
        {
            int num1, num2, n, sum, r;
            Console.Write("Enter positive number1 :");
            num1 = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter positive number2 :");
            num2 = Convert.ToInt32(Console.ReadLine());


            Console.WriteLine("Armstrong Number from {0} to {1}", num1, num2);
            for (int i = num1; i <= num2; i++)
            {
                sum = 0;
                n = i;
                while (n != 0)
                {
                    r = n % 10;
                    sum = sum + (r * r * r);
                    n = n / 10;
                }
                if (i == sum)
                    Console.WriteLine(i);
            }

            Console.ReadKey();
        }
    }
}
