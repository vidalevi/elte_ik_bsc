{-# LANGUAGE InstanceSigs #-}
module Ora7 where

-- Konstruktorok: a saját típusaink primitív felépítő függvényei

-- data <TÍPUSNÉV> <TÍPUSPARAMÉTEREK> = <KONSTRUKTORK1> <PARAMÉTEREK> | <KONSTRUKTOR2> ...
-- Data.Maybe
-- Data.List

-- []
-- (:) a (List a)

data List a = Nil | Cons a (List a) -- lehet végtelen (de csak lehet)
  deriving (Eq, Show)

mapSajatList :: (a -> b) -> List a -> List b
mapSajatList f Nil = Nil
mapSajatList f (Cons x xs) = Cons (f x) (mapSajatList f xs)

data Stream a = SCons a (Stream a) deriving (Eq, Show)

mapStream :: (a -> b) -> Stream a -> Stream b
mapStream f (SCons a as) = SCons (f a) (mapStream f as)

headStream :: Stream a -> a
headStream (SCons a _) = a

repeatStream :: a -> Stream a
repeatStream a = SCons a (repeatStream a)

convertToOurList :: [a] -> List a
convertToOurList [] = Nil
convertToOurList (x : xs) = Cons x (convertToOurList xs)
-- sima [a]-ból a mi listánkba
kMap :: (a -> a) -> a -> Stream a
kMap f x = SCons x (kMap f (f x))
-- de most stream
takeStream :: Int -> Stream a -> [a]
takeStream 0 _ = []
takeStream db (SCons x xs) = x : takeStream (db - 1) xs
-- első K elemet kiszedi a streamből

data Alma = B Int deriving Eq

instance Show Alma where
  show :: Alma -> String
  show (B i) = "Almát kaptam és annak az értéke " ++ show i

instance Ord Alma where
  (<=) :: Alma -> Alma -> Bool
  (B i) <= (B j) = i <= j

-- Definiáljunk egy Metró típust, három konstruktorral (M1, M2, M3)
-- Az M3-nak legyen egy String paramétere ami azt jelzi éppen milyen járat pótolja (pl "M30")
-- Kérjünk a fordítótol automatikus Eq instance-ot
-- Írjunk manuális Show és Ord instance-ot
-- Az Ord instance mindig a nagyobb számú metrót tartsa nagyobbnak (pl M3 >= M2)
data Metro = M1 | M2 | M3 String deriving Eq

instance Show Metro where
  show :: Metro -> String
  show M1 = "1-es metró"
  show M2 = "2-es metró"
  show (M3 x) = "3-as metró " ++ show x

instance Ord Metro where
  (<=) :: Metro -> Metro -> Bool
  M1 <= M2 = True
  M2 <= (M3 s) = True
  M1 <= (M3 s) = True
  x <= y = x == y


-- Definiáljunk egy PottedPlant adatt
-- Három konstruktora legyen: FigTree (fügefa), Kaktusz (Cactus) és Hínár (Kelp)
-- A fügefának legyen egy Int paramétere ami azt reprezentálja mennyi gyümölcse van
-- A kaktusznak legyen egy Bool és egy Int paramétere amik azt reprezentálják szúros-e és mennyi tükséje van
-- Írjunk manuális Eq, Ord és Show instance-ot
-- írjunk egy verifyPlant :: PottedPlant -> Maybe PottedPlant függvényt ami leszűri a lehetetlen növényeket
-- kaktusz akkor lehetetlen ha szúros de nincs tüskéje
-- fügefa akkor lehetetlen ha negatív gyümölcse van
