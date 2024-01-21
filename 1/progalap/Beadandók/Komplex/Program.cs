using System;
using System.Collections.Generic;

namespace telepules
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Deklarálás
            int n, m;
            int[,] ho;
            int db = 0;
            List<int> varos = new List<int>();

            //Beolvasás
            (n,m,ho) = beolvas();

            // Kiválogatás
            for (int i = 0; i < n; i++)
            {
                // Eldöntés
                bool van = false;
                int j = 0;
                while (!van && j < m)
                {
                    if (ho[i, j] == oszlopMin(ho, j, n))
                        van = true;
                    else
                        j++;
                }

                if (van)
                {
                    db++;
                    varos.Add(i+1);
                }
            }

            // Kiírás
            kiir(db, varos);
        }
        
        public static int oszlopMin(int[,] ho, int j, int n)
        {
            int minert = ho[0, j];
            for (int i = 1; i < n; i++)
                if (ho[i, j] < minert)
                    minert = ho[i, j];
            return minert;
        }


        public static (int n, int m, int[,] ho) beolvas()
        {
            if (Console.IsInputRedirected)
                return beolvas_biro();
            else
                return beolvas_kezi();
        }

        static (int n, int m, int[,] ho) beolvas_biro()
        {
            string[] row = Console.ReadLine().Split(' ');
            int n = int.Parse(row[0]);
            int m = int.Parse(row[1]);

            int[,] ho = new int[n, m];
            for (int i = 0; i < n; i++)
            {
                row = Console.ReadLine().Split(" ");
                for (int j = 0; j < m; j++)
                    ho[i, j] = int.Parse(row[j]);
            }
            return (n, m, ho);
        }

        static (int n, int m, int[,] ho) beolvas_kezi()
        {
            int n, m;
            bool jo;
            do
            {
                Console.ResetColor();
                Console.Write("Települések száma = ");
                jo = int.TryParse(Console.ReadLine(), out n) && n >= 1 && n <= 1000;
                if (!jo)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Helytelen input! (1 <= n <= 1000)");
                }
            } while (!jo);
            do
            {
                Console.ResetColor();
                Console.Write("Napok száma = ");
                jo = int.TryParse(Console.ReadLine(), out m) && m >= 1 && m <= 1000;
                if (!jo)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Helytelen input! (1 <= m <= 1000)");
                }
            } while (!jo);

            int[,] ho = new int[n, m];
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < m; j++)
                {
                    do
                    {
                        Console.ResetColor();
                        Console.Write("{0}. település {1}. napjának hőmérséklete = ", i + 1, j + 1);
                        jo = int.TryParse(Console.ReadLine(), out ho[i, j]) && ho[i, j] >= 0;
                        if (!jo)
                        {
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.WriteLine("Helytelen input! (-50 <= hő <= 50)");
                        }
                    } while (!jo);
                }
            }
            return (n, m, ho);
        }

        static void kiir(int db, List<int> varos)
        {
            if (Console.IsOutputRedirected)
            {
                Console.Write(db + " ");
                for (int i = 0; i < db; i++)
                    Console.Write(varos[i] + " ");
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Green;
                if (db == 0)
                    Console.WriteLine("Nincs a feltételnek megfelelő település!");
                else
                {
                    Console.WriteLine("{0} darab feltételnek megfelelő település van, sorszáma(ik):", db);
                    for (int i = 0; i < db - 1; i++)
                        Console.Write("{0}, ", varos[i]);
                    Console.WriteLine(varos[db - 1]);
                }
                Console.ForegroundColor = ConsoleColor.Black;
                Console.BackgroundColor = ConsoleColor.Gray;
                Console.WriteLine("Kérem, nyomjon ENTER-t a folytatáshoz!");
                Console.ResetColor();
                Console.ReadLine();
            }
        }
    }
}
