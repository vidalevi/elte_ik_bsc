module Ora9 where

--[1,2,3] = 1 : 2 : 3 : []
--          1 + 2 + 3 + 0
--          1 * 2 * 3 * 1

sum' :: [Int] -> Int
sum' [] = 0
sum' (x : xs) = x + sum' xs


foldr2 :: (a -> b -> b) -> b -> [a] -> b
foldr2 f b [] = b
foldr2 f b (x : xs) = x `f` foldr2 f b xs


sum'' :: Num a => [a] -> a
sum'' xs = foldr (+) 0 xs

product'' :: Num a => [a] -> a
product'' xs = foldr (*) 1 xs

length'' :: [a] -> Int
length'' [] = 0
length'' (x : xs) = 1 + length'' xs

length' :: [a] -> Int
length' xs = foldr (\x xs' -> 1 + xs') 0 xs

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x xs' -> f x : xs') []
--                  ^ map f xs

map'' :: (a -> b) -> [a] -> [b]
map'' f [] = []
map'' f (x : xs) = f x : map'' f xs


concat' :: [[a]] -> [a]
concat' = foldr (\x xs' -> x ++ xs') []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x xs' -> if p x then x : xs' else xs') []
-- \x -> f x == f

-- concatMap' :: (a -> [b]) -> [a] -> [b]

drop' :: Int -> [a] -> [a]
drop' k [] = []
drop' k (x : xs) = if k <= 0 then x : xs else drop' (k - 1) xs

drop'' :: Int -> [a] -> [a]
drop'' i xs = foldr (\x f k -> if k <= 0 then x : f k else f (k - 1)) (\i' -> []) xs i
--                    a -> b -> b

take' :: Int -> [a] -> [a]
take' k [] = []
take' k (x : xs) = if k <= 0 then [] else x : take' (k - 1) xs

take'' :: Int -> [a] -> [a]
take'' k' xs = foldr (\x f k -> if k <= 0 then [] else x : f (k - 1)) (\k -> []) xs k'

(+++) :: [a] -> [a] -> [a]
reverse' ::  [a] -> [a]
minimum' :: Ord a => [a] -> a -> a
maximum' :: Ord a => [a] -> a -> a
or' :: [Bool] -> Bool
and' :: [Bool] -> Bool


-- NEHÉZ FELADAT
(!?)


type List a = [a]
