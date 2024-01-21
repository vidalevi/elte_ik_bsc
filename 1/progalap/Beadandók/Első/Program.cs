using System;
namespace elso_bead_kod
{
    internal class Program
    {
        struct ido public int erkezes, tavozas;
        
        static void Main(string[] args)
        {
            //Beolvasás
            int n, k;
            do
            {
                string[] fstRow = Console.ReadLine().Split(' ');
                n = int.Parse(input[0]);
                k = int.Parse(input[1]);
            } while (!(1 <= n && n <= 100));

            ido[] x = new ido[n];
            for (int i = 0; i < n; i++)
            {
                do
                {
                    string[] row = Console.ReadLine().Split(' ');
                    x[i].erkezes = int.Parse(row[0])
                    x[i].tavozas = int.Parse(row[1])
                } while (!(x[i].erkezes <= x[i].tavozas));
            }

            // Feladat:
            int db = 0;
            for (int i = 0; i < n; i++)
                if (x[i].erkezes <= k && k < x[i].tavozas)
                    db++;

            Console.WriteLine(db);
        }
    }
}