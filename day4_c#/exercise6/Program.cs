using System;
using System.Linq.Expressions;

namespace exercise6
{
    class Program
    {
        static void Main(string[] args)
        {
            Func<int, int> addOne = n => n + 1;
            Console.WriteLine("Result: {0}", addOne(5));

            Expression<Func<int, int>> addOneExpression = n => n + 1;

            var addOneFunc = addOneExpression.Compile();
            Console.WriteLine("Result: {0}", addOneFunc(5));
        }


    }
}
