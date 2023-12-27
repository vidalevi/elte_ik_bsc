module Homework4 where


concatList :: [[a]] -> [a]
concatList [] = []
concatList (x:xs) = x ++ concatList xs


factorial :: Int -> Int
factorial n
    | n > 0 = n * factorial (n-1)
    | n <= 0 = 1


index :: Int -> [a] -> a
index 0 (x:xs) = x
index i (x:xs) = index (i-1) xs


zipLists :: [a] -> [b] -> [(a,b)]
zipLists [] _ = []
zipLists _ [] = []
zipLists (x:xs) (y:ys) = [(x,y)] ++ zipLists xs ys


fakeDropSort :: Ord a => [a] -> [a]
fakeDropSort [] = []
fakeDropSort [x] = [x]
fakeDropSort (x:xs)
    | x < (head xs) = x : fakeDropSort xs
    | otherwise = fakeDropSort xs


onlyIncreasing :: Ord a => [(a,a,a)] -> [(a,a,a)]
onlyIncreasing [] = []
onlyIncreasing ((a,b,c):xs)
    | a < b && b < c = (a,b,c) : onlyIncreasing xs
    | otherwise = onlyIncreasing xs