using System;
namespace negativ
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int n;
            do
            {
                n = int.Parse(Console.ReadLine());
            } while (n < 0);

            double[] tomb = new double[n];
            for (int i = 0; i < n; i++)
                    tomb[i] = double.Parse(Console.ReadLine());

            int db = 0;
            for (int i = 0; i < n; i++)
            {
                int j = 0;
                while (j <= i - 1 && !(tomb[j] == tomb[i])) j++;
                bool van = j <= i - 1;
                if (tomb[i] < 0 && !van) db++;
            }

            Console.WriteLine(db);
        }
    }
}