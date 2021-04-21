using System;

namespace exercise1
{
    public class Point
    {
        public int X { get; set; }
        public int Y { get; set; }
    }
    public class Customer
    {
        public int CustomerID { get; private set; }
        public string Name { get; set; }
        public string City { get; set; }
        public Customer(int ID)
        {
            CustomerID = ID;
        }

        public override string ToString()
        {
            return Name + "\t" + City;
        }
    }


    class Program
    {
        static void Main(string[] args)
        {
            Customer c = new Customer(1);
            c.Name = "Maria Anders";
            c.City = "Berlin";

            Console.WriteLine(c);
        }

    }
}
