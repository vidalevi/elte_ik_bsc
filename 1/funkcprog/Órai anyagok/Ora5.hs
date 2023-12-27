module Ora5 where


reverse' :: [a] -> [a]
reverse' xs = reverse'' xs []
  where
    reverse'' :: [a] -> [a] -> [a]
    reverse'' [] xs = xs
    reverse'' (x : xs) ys = reverse'' xs (x : ys)

-- FUNKCIONÁLIS: MINDEN KIFEJEZÉS FÜGGVÉNY
-- where az nem függvény
-- module sem függvény
-- guardok se függvények
-- vajon a -> függvény-e
-- :: az nem függvény
-- Int, [a], (Bool, Char) :: Type
-- (->) :: Type -> Type -> Type

-- 1 + 2 + 3 == (1 + 2) + 3 BALRA
-- 1 ^ 2 ^ 3 == 1 ^ (2 ^ 3) JOBBRA
-- a -> b -> c
-- (a -> b) -> c
-- a -> (b -> c) -- CURRYZÉS


f :: Int -> Int -> Int
f x y = x + y

f' :: Int -> (Int -> Int)
f' x = \y -> x + y

-- LAMBDA/ANONIM függvény
-- lambda x:
-- \      x ->

g :: (Int -> Int) -> Int -- MAGASABBRENDŰ FÜGGVÉNY
g h = h 17

i :: (Int -> Int -> Int) -> Int
i j = j 3 4

-- PARCIÁLIS APPLIKÁLÁS = nem adjuk meg az összes paramétert

map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x : xs) = f x : map' f xs


{-
map (\x -> x + 1) [5,8,18] (x = 5, xs = [8,18])
(\x -> x + 1) 5 : map (\x -> x + 1) [8, 18]
6 : map (\x -> x + 1) [8, 18] (x = 8, xs = [18])
6 : ((\x -> x + 1) 8 : map (\x -> x + 1) [18])
6 : 9 : map (\x -> x + 1) [18]
6 : 9 ((\x -> x + 1) 18 : map (\x -> x + 1) [])
6 : 9 : 19 : map (\x -> x + 1) []
[6,9,19]


-} -- X -> Bool = PREDIKÁTUM

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' (\x -> x > 2) [1,3,2,4] == [1,2]
-- zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
-- zipWith' (\x y -> x + y) [1,2,3] [4,5,6,7] == [5, 7, 9]

-- SZELETEK / SLICES
-- \x -> x > 2
-- (> 2)

-- ÉTA REDUKCIÓ
-- \x -> f x == f

k :: Int -> Int
k = (+1)

l :: [Int] -> [Int]
l xs = filter (>2) (map (+1) xs)
