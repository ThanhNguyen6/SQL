using System;

namespace exercise2
{
    public class Arithmetic
    {
        int a;
        int b;
        public Arithmetic(int m, int n)
        {
            a = m;
            b = n;
        }
        public int Add()
        {
            return a + b;
        }
        public int Minus()
        {
            return a - b;
        }
        public int Multiplication()
        {
            return a * b;
        }
        public int Divide()
        {
            return a / b;
        }

    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter first integer");
            int a = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter second integer");
            int b = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter your arithmetic choice:");
            Console.WriteLine("1: Add:");
            Console.WriteLine("2: Minus");
            Console.WriteLine("3: multiplication");
            Console.WriteLine("4: division");
            int choice = Convert.ToInt32(Console.ReadLine());
            Arithmetic ari = new Arithmetic(a, b);
            switch (choice)
            {
                case 1:
                    Console.WriteLine(ari.Add());
                    break;
                case 2:
                    Console.WriteLine(ari.Minus());
                    break;
                case 3:
                    Console.WriteLine(ari.Multiplication());
                    break;
                default:
                    Console.WriteLine("here is the result of arithematic: "+ ari.Divide());
                    break;
            }
            Console.ReadKey();
        }
    }
}
