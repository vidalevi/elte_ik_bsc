using System;
using System.Collections.Generic;

namespace dlninp
{
    struct Rekord
    {
        public int hely, madDb;
        public string nev;
    }
    internal class Program
    {
        static void Main(string[] args)
        {
            //Beolvasás
            string[] fstRow = Console.ReadLine().Split(' ');
            int n = int.Parse(fstRow[0]);
            int m = int.Parse(fstRow[1]);
            string bird = fstRow[2];
            List<Rekord> madar = new List<Rekord>();
            for (int i = 0; i < n; i++)
            {
                string[] row = Console.ReadLine().Split(' ');
                madar.Add(new Rekord
                {
                    hely = int.Parse(row[0]),
                    nev = row[1],
                    madDb = int.Parse(row[2])
                });

            }

            //1. feladat: Összegzés
            int db = 0;
            for (int i = 0; i < n; i++)
                db += madar[i].madDb;
            Console.WriteLine("#\n" + db);

            //2. feladat: Maximumkiválasztás
            int maxDb = 0, maxPlace = 0;
            for (int i = 0;i < n; i++)
            {
                if (madar[i].nev == bird && maxDb < madar[i].madDb)
                {
                    maxDb = madar[i].madDb;
                    maxPlace = madar[i].hely;
                }
            }
            Console.WriteLine("#\n" + maxPlace);

            //3. feladat: Megszámolás + mind eldöntés
            db = 0;
            for(int i = 0; i < n; i++)
            {
                int j = 0;
                while (j < i && madar[i].nev != madar[j].nev) j++;
                bool mind = j >= i;
                if (mind) db++;
            }
            Console.WriteLine("#\n" + db);

            //4. feladat: Megszámolásban megszámolás
            db = 0;
            for(int i = 0; i < n; i++)
            {
                int counter = 0;
                for (int j = 0; j < n; j++)
                    if (madar[i].hely == madar[j].hely) counter++;
                if (counter == 1) db++;
            }
            Console.WriteLine("#\n" + db);

            //5. feladat: Kiválogatás + saját megoldás
            db = 0;
            List<int> dominant = new List<int>();
            for (int i = 0; i < n; i++)
            {
                int currentPlace = madar[i].hely;
                if (madar[i].nev == bird)
                {
                    int birdDb = madar[i].madDb;
                    bool van = true;
                    int j = 0;
                    while (j < n && van)
                    {
                        if (currentPlace == madar[j].hely && madar[j].nev != bird && birdDb < madar[j].madDb) van = false;
                        j++;
                    }
                    if (van)
                    {
                        db++;
                        dominant.Add(currentPlace);
                    }
                }
            }
            Console.Write("#\n" + db + " ");
            for (int i = 0; i < db; i++)
                Console.Write(dominant[i] + " ");
        }
    }
}