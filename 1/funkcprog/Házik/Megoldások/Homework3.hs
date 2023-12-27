module Homework3 where

-- Listafügvvények használata
descending :: Int -> Int -> [Int]
descending a b = reverse [b..a]

padWithZeros :: Int -> [Int] -> [Int]
padWithZeros k f = replicate k 0 ++ f ++ replicate k 0

isLongerThan :: Int -> [a] -> Bool
isLongerThan a b = length (take (a+1) b) > a    -- nem jó: isLongerThan 3 [1..] nem fut le -> vesszük az a+1-dik elemét a listának

repeatList :: [a] -> [a]
repeatList a = cycle a


-- Listagenerátorok
trimTheBushes :: [String] -> [String]
trimTheBushes a = [x | x <- a, x/="bokor"]

addSqrt :: [Double] -> [(Double, Double)]
addSqrt a = [(x, sqrt x) | x <- a, x>=0]

decompress :: [(Char, Int)] -> String
decompress xs = concat[replicate b a | (a, b) <- xs]


-- Segédfüggvény a stroTuples-hez:
{-(a,b,c)
(a,c,b)
(b,a,c)
(b,c,a)
(c,a,b)
(c,b,a)-}
segedSortTuples :: Ord a => (a,a,a) -> (a,a,a)
segedSortTuples (a,b,c)
    | a < b && b < c = (a,b,c)
    | a < c && c < b = (a,c,b)
    | b < a && a < c = (b,a,c)
    | b < c && c < a = (b,c,a)
    | c < a && a < b = (c,a,b)
    | c < b && b < a = (c,b,a)

sortTuples :: Ord a => [(a,a,a)] -> [(a,a,a)]
sortTuples xs = [ segedSortTuples (a,b,c) | (a,b,c) <- xs]
