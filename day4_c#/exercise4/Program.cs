using System;
using System.Collections.Generic;

namespace exercise3
{
    public static class Extensions
    {
        public static List<T> Append<T>(this List<T> a, List<T> b)
        {
            var newList = new List<T>(a);
            newList.AddRange(b);
            return newList;
        }

        public static bool Compare(this Customer customer1, Customer customer2)
        {
            if (customer1.CustomerID == customer2.CustomerID &&
                customer1.Name == customer2.Name &&
                customer1.City == customer2.City)
            {
                return true;
            }

            return false;
        }
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

    class program
    {
        static List<Customer> CreateCustomers()
        {
            return new List<Customer>
                {
                    new Customer(1) { Name = "Maria Anders",     City = "Berlin"    },
                    new Customer(2) { Name = "Laurence Lebihan", City = "Marseille" },
                    new Customer(3) { Name = "Elizabeth Brown",  City = "London"    },
                    new Customer(4) { Name = "Ann Devon",        City = "London"    },
                    new Customer(5) { Name = "Paolo Accorti",    City = "Torino"    },
                    new Customer(6) { Name = "Fran Wilson",      City = "Portland"  },
                    new Customer(7) { Name = "Simon Crowther",   City = "London"    },
                    new Customer(8) { Name = "Liz Nixon",        City = "Portland"  }
                };
        }
        static void Main(string[] args)
        {
            var customers = CreateCustomers();

            var addedCustomers = new List<Customer>
    {
        new Customer(9)  { Name = "Paolo Accorti", City = "Torino" },
        new Customer(10) { Name = "Diego Roel", City = "Madrid" }
    };

            var updatedCustomers = customers.Append(addedCustomers);


            var newCustomer = new Customer(10)
            {
                Name = "Diego Roel",
                City = "Madrid"
            };
            foreach (var c in updatedCustomers)
            {

                if (newCustomer.Compare(c))
                {
                    Console.WriteLine("The new customer was already in the list");
                    return;
                }
            }

            Console.WriteLine("The new customer was not in the list");
        }

    }



}
