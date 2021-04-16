using System;

namespace exercise5
{
    class Program
    {
        class Box {
            double length;
            double height;
            double breadth;
            public double getVolume()
            {
                return length * breadth * height;
            }
            public void setLength(double len)
            {
                length = len;
            }

            public void setBreadth(double bre)
            {
                breadth = bre;
            }

            public void setHeight(double hei)
            {
                height = hei;
            }

            public static Box operator +(Box b, Box c)
            {
                Box box = new Box();
                box.length = b.length + c.length;
                box.breadth = b.breadth + c.breadth;
                box.height = b.height + c.height;
                return box;
            }

        }




        static void Main(string[] args)
        {
            Box box1 = new Box();
            box1.setBreadth(2);
            box1.setHeight(3);
            box1.setLength(5);
            Console.WriteLine("Volume of box1: {0}", box1.getVolume());

            Box box2 = new Box();
            box2.setBreadth(2);
            box2.setHeight(3);
            box2.setLength(3);
            Console.WriteLine("Volume of box2: {0}", box2.getVolume());

            Box box3 = new Box();
            box3 = box1 + box2;
            Console.WriteLine("Volume of box3: {0}", box3.getVolume());
        }
    }
}
