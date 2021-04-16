using System;

namespace exercise2
{
    class Solution {
        public int solution(int[] A)
        {
            Array.Sort(A);
            int n = A.Length;
            // find the max frequency using
            // linear traversal
            int max_count = 1, res = A[0];
            int curr_count = 1;

            for (int i = 1; i < n; i++)
            {
                if (A[i] == A[i - 1])
                    curr_count++;
                else
                {
                    if (curr_count > max_count)
                    {
                        max_count = curr_count;
                        res = A[i - 1];
                    }
                    curr_count = 1;
                }
            }

            // If last element is most frequent
            if (curr_count > max_count)
            {
                max_count = curr_count;
                res = A[n - 1];
            }

            return res;
        }
           

    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("enter length:");
            int length = Convert.ToInt32(Console.ReadLine());
            int[] arr = new int[length];
            for (int i = 0; i < length; i++)
            {
                Console.WriteLine($"enter value for {i + 1} element :");
                arr[i] = Convert.ToInt32(Console.ReadLine());
            }
            Solution s = new Solution();
            s.solution(arr);
            Console.ReadLine();
        }
    }
}
