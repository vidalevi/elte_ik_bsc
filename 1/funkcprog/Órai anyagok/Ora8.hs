module Ora8 where

import Data.List
-- TYPE ALIAS = TÍPUSSZINONÍMA

type Almafa = Int
type String = Int

-- Qualification
f :: Ora8.String -> Ora8.String
f x = x + 1

---

($$) :: (a -> b) -> a -> b
($$) f a = f a

g :: [Int] -> [Int]
g = map (div 10) . filter (>2) . map (+1)

(#) :: (b -> c) -> (a -> b) -> a -> c
(#) f g a = f $ g a

-- Függvénykompozíció
-- Paraméterelhagyás / Éta-redukció

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn x xs = map tail $ tail $ groupBy (/=) $ x : xs

-- zipWith
-- takeWhile
-- dropWhile
-- map
-- filter
-- concatMap
-- groupBy
-- sortOn

-- Leszűri a páros számokat, map megnöveli az összes számot 1-el, majd sorrendbe rakja az elemeket
doStuff :: [Int] -> [Int]
doStuff xs = sort $ map (+1) $ filter even xs
-- map függvény, de az elem indexét is paraméterül kapja
mapWithIndex :: (Int -> a -> b) -> [a] -> [b]
mapWithIndex f xs = map (\(i, a) -> f i a) $ zip [0..] xs
-- filter függvény, de az elem indexét is paraméterül kapja
filterWithIndex :: (Int -> a -> Bool) -> [a] -> [a] -- HOLE
filterWithIndex f xs = map (\(_,a) -> a) $ filter (\(i, a) -> f i a) $ zip [0..] xs

-- Adjuk vissza egy listából a páros számok négyzetét
sqOfEvens :: [Int] -> [Int]
sqOfEvens xs = map (^2) $ filter even xs
-- Adjuk össze egy listában az i. számokat a list végétől nézve az i. számával
bwSum :: [Int] -> [Int]
bwSum xs = zipWith (\x y -> x + y) xs (reverse xs)
-- pl.: bwSum [1,2,4] == [1 + 4, 2 + 2, 4 + 1]

-- Sorba rakjuk az elemeket egy listában és megszámoljok mindenből mennyi van
sortAndCount :: Ord a => [a] -> [(a, Int)]
sortAndCount xs = map (\x -> (head x, length x)) $ groupBy (==) $ sort xs
