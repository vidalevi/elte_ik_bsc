using System;
namespace felujitas
{
    internal class Program
    {
        struct public int kezd, veg;

        static void Main(string[] args)
        {
            // Beolvasás
            int n, m;
            do
            {
                string[] firstRow = Console.ReadLine().Split(' ');
                n = int.Parse(firstRow[0]);
                m = int.Parse(firstRow[1]);
            } while (!(1 <= n && n <= 10000 && 1 <= m && m <= 100));

            x[] ut = new x[m];
            for (int i = 0; i < m; i++)
            {
                do
                {
                    string[] row = Console.ReadLine().Split(' ');
                    ut[i].kezd = int.Parse(row[0]);
                    ut[i].veg = int.Parse(row[1]);
                } while (!(0 <= ut[i].kezd && ut[i].kezd < ut[i].veg && ut[i].veg <= n));
            }
            // Feladat
            int min = -1;
            bool van = false;
            for (int i = 0; i < m; i++)
            {
                int db = 0;
                for (int j = 0; j < m; j++)
                    if (ut[i].kezd >= ut[j].kezd && ut[i].kezd + 9 <= ut[j].veg)
                        db++;

                if (db >= 3 && van == false)
                {
                    van = true;
                    min = ut[i].kezd;
                }
                else if (db >= 3 && van == true)
                    if (ut[i].kezd < min)
                        min = ut[i].kezd;
            }
            // Kimenet
            Console.WriteLine(min);
        }
    }
}