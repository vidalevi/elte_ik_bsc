module Homework5 where


--Rekurzió akkumulátorokkal
assocIndex :: [a] -> [(Int, a)]
assocIndex [] = []
assocIndex (x:xs) = assocSeged (x:xs) 0
    where
        assocSeged :: [a] -> Int -> [(Int, a)]
        assocSeged [] _ = []
        assocSeged (x:xs) i = (i,x) : assocSeged xs (i+1)

mapWithIndex :: (Int -> a -> b) -> [a] -> [b]
mapWithIndex fgv [] = []
mapWithIndex fgv (x:xs) = mapSeged fgv (x:xs) 0
    where
        mapSeged :: (Int -> a -> b) -> [a] -> Int -> [b]
        mapSeged _ [] _ = []
        mapSeged fgv (x:xs) i = fgv i x : mapSeged fgv xs (i+1)


--Magasabbrendű függvények írása
allTrue :: (a -> Bool) -> [a] -> Bool
allTrue fgv [] = True
allTrue fgv (x:xs) = fgv x && allTrue fgv xs    --sokkal gyorsabb, mint akkumulációs rekurzióval, mert, ha csak az egyik hamis akkor hamisat ad vissza. pl: True && False && True = False

pairwiseMap :: (a -> a -> b) -> [a] -> [b]
pairwiseMap fgv [] = []
pairwiseMap fgv [x] = []
pairwiseMap fgv (x:xs) = fgv x (head xs) : pairwiseMap fgv xs

findIndex :: (a -> Bool) -> [a] -> Int
findIndex fgv [] = (-1)
findIndex fgv (x:xs) = findSeged (map fgv (x:xs)) 0     --map fgv (x:xs) -> True és False-okkal teli lista
    where
        findSeged :: [Bool] -> Int -> Int
        findSeged [] _ = -1
        findSeged (x:xs) i
            | x == True = i
            | otherwise = findSeged xs (i+1)

kMap :: a -> (a -> a) -> [a]
kMap x fgv = x : kMap (fgv x) fgv   --2 : kMap 4 (*2) : kMap 8 (*2) : kMap 16 (*2) ... végtelen
                                    --2 : 8 : 16 : 32 ...


--Magasabbrendű függvények használata
group :: Eq a => [a] -> [[a]]
group [] = []
group (x:xs) = (x : takeWhile (\y -> y == x) xs) : group (dropWhile (\y -> y == x) xs)


negyzetSzamok :: [Int]
negyzetSzamok = [x*x | x <- [0..]]

removeSqIndices :: [a] -> [a]
removeSqIndices [] = []
removeSqIndices (x:xs) = removeSeged (x:xs) negyzetSzamok 0
    where
        removeSeged :: [a] -> [Int] -> Int -> [a]
        removeSeged [] _ _ = []
        removeSeged (x:xs) (n:negyzetSzamok) i
            | i == n = removeSeged xs negyzetSzamok (i + 1)
            | otherwise = x : removeSeged xs (n:negyzetSzamok) (i + 1)