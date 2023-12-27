module Ora1 where

-- parancs: :l ÚTVONAL/fájl.hs

f :: Int -> Int
f x = x + 1

-- :r = újratöltés
-- :q = kilépés
-- :t <kif> = <kif> típusa

g :: Int -> Int -> Int
g x y = x + y

-- h függvényt ami két boolt vár és visszaadja a két bool vagyolását
-- i függvényt ami öt intet vár és visszaadja az összegüket
-- j függvényt ami egy stringet vár és visszaadja a hosszát plusz 1
-- String
-- Bool
--

-- t :: Bemenet -> Bemenet -> ... -> Kimenet

h :: Bool -> Bool -> Bool
h i h = i || h

i :: Int -> Int -> Int -> Int -> Int -> Int
i a b c d e = a + b + c + d + e

j :: String -> Int
j x = length x + 1

---

decide :: Bool -> Int
decide x = if x then 1 else 2

decide' :: Bool -> Int
decide' True = 3
decide' True = 1
decide' False = 2

isA :: Char -> Bool
isA 'a' = True
isA _ = False

isA' :: Char -> Bool
isA' x = if x == 'a' then True else False

isThree :: Int -> Bool
isThree 3 = True
isThree _ = False

--- isVowel, karaktert vár és boolt ad vissza, megnézi a bemenet magánhangzó-e
--- isDivisibleBy6, intet vár megnézi osztható-e 6al (mod x y = megnézi x-et osztja-e y)
--- isSingleDigitOdd, intet vár, megnézi egy jegyű páratlan szám-e

--- if ... then ... else (if ... then ... else ..)

--- tms.inf.elte.hu
