using System;
namespace hallgato
{
    internal class Program
    {
        struct Hallgato
            public string vnev, knev, matalap;

        static void Main(string[] args)
        {
            int n;
            do
            {
                n = int.Parse(Console.ReadLine());
            } while (n < 0);

            Hallgato[] hallgatok = new Hallgato[n];
            for (int i = 0; i < n; i++)
            {
                    string[] rows = Console.ReadLine().Split(' ');
                    hallgatok[i].vnev = rows[0];
                    hallgatok[i].knev = rows[1];
                    hallgatok[i].matalap = double.Parse(rows[2]);
            }

            List<Hallgato> matek = new List<Hallgato>();
            int db = 0;
            for (int i = 0; i < n; i++)
            {
                if (hallgatok[i].knev == "Máté" && hallgatok[i].matalap >= 3.0)
                {
                    db++;
                    matek.Add(hallgatok[i]);
                }
            }

            Console.WriteLine(db);
            for (int i = 0; i < db; i++)
                Console.WriteLine(matek[i].vnev + " " + matek[i].knev + " " + matek[i].matalap);
        }
    }
}