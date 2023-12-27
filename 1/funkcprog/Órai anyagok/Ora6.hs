{-# LANGUAGE InstanceSigs #-}
-- Bool-nak van két konstruktora: True, False
-- Konstruktor mindig nagybetűvel vagy :-al kezdődik
-- Konstruktorokra lehet mintailleszteni
-- Lista konstruktorai: [], (:)
-- Int, Float, Double stb-nek NEM a számok a konstruktorai de attól még tudunk rájunk mintailleszteni

-- data <TÍPUSNÉV> = <Konstruktor1> <param1> <param2> <param...> | <Konstruktor2> ... | Konstruktor3 ..

data Bool' = True' | False' deriving (Show, Eq, Ord) -- deriving ...

data Bool'' = True'' | False'' | Maybe'

-- Show, Eq, Ord
-- Num, Integral, Floating azok nem

-- olyan típust szeretnék definiálni ami egy számot tárol és azt, hogy az a szám páros-e

data NumAndIsEven = A Int Bool -- A :: Int -> Bool -> NumAndIsEven

--- Q a neve, C és D konstruktorok és legyen C-nek egy Char paramétere
data Q = C Char | D



-- instance <TÍPUSOSZTÁLY> <TÍPUS> where
instance Eq NumAndIsEven where
  (==) :: NumAndIsEven -> NumAndIsEven -> Bool
  (A int bool) == (A int' bool') = int == int' && bool == bool'


-- Legyen Gyümölcs (Fruit) típusunk ami felvehet Alma, Banán és Eper értékeket.
-- Az Alma konstruktor tárolja el azt is mennyi mag van benne (Int)
-- Kérjünk AUTOMATIKUS egyenlőség vizsgálatot erre a típusra

-- Legyen Metró (Metro) típusunk ami felvehet M3, M2 és M1 értékeket
-- Az M3 konstruktor tárolja el hogy éppen metrópótló jár e (Bool)
-- Írjunk MANUÁLIS egyenlőségvizsgálatot erre a típusra

instance Eq Q where
  (==) :: Q -> Q -> Bool
  D == D = True
  (C ch1) == (C ch2) = ch1 == ch2
  _ == _ = False
  {-
  D == (C ch1) = False
  (C ch1) == D = False
-}

data Fruit = Alma Int | Banán | Eper deriving Eq

data Metro = M3 Bool | M2 | M1

instance Eq Metro where
  (==) :: Metro -> Metro -> Bool
  (M3 b) == (M3 b') = b == b'
  M2 == M2 = True
  M1 == M1 = True
  _ == _ = False

hanyMagjaVanAzAlmanak :: Fruit -> Int
hanyMagjaVanAzAlmanak (Alma x) = x
hanyMagjaVanAzAlmanak _ = 0

--         V polimorf típust reprezentál
data Lehet a = Van a | Nincs deriving (Eq, Show)

lehetbool :: Lehet Bool -- specifikáltam hogy az 'a' mit jelent
lehetbool = Nincs

lehetbool' :: Lehet Bool
lehetbool' = Van True


lehetint' :: Lehet Int
lehetint' = Van 5

lehetint :: Lehet Int
lehetint = Nincs

-- Írjunk egy függvényt ami 'lehet' vár egy intet, ha viszont nem akkor adjunk vissza 0-t egyébként a kapott számot
lehetToInt :: Lehet Int -> Int
lehetToInt Nincs = 0
lehetToInt (Van int) = int

{-
Írjunk egy függvényt ami egy Lehet Int-hez hozzáad egy-et (ha van érték)
add1 :: Lehet Int -> Lehet Int

-- Szűrjük ki a listából a 'Nincs' értékeket
removeNone :: [Lehet a] -> [a]
-}

add1 :: Lehet Int -> Lehet Int
add1 Nincs = Nincs
add1 (Van e) = Van (e + 1)


removeNone :: [Lehet a] -> [a]
removeNone [] = []
--removeNone (x:xs) -- ((Van e) : xs)
--  | Van e <- x = e : removeNone xs
--  | otherwise = removeNone xs
removeNone (Nincs : xs) = removeNone xs
removeNone ((Van e) : xs) = e : removeNone xs
