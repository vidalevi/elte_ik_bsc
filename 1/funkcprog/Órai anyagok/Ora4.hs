module Ora4 where

fib :: Int -> Int
fib 1 = 1
fib 2 = 1
fib n = fib (n - 1) + fib (n - 2)


sum' :: [Int] -> Int
sum' [] = 0
sum' (x : xs) = x + sum' xs -- x = head, xs = tail

product' :: [Int] -> Int
product' [] = 1
product' (x : xs) = x * product' xs

{-
product' [1,3,4]
1 * product' [3, 4]
1 * (3 * product' [4])
1 * (3 * (4 * product' []))
1 * (3 * (4 * _))
-}

-- length' :: [a] -> Int
-- all' :: [Bool] -> Bool
-- incr1 :: [Int] -> [Int]

length' :: [a] -> Int
length' [] = 0
length' (x : xs) = 1 + length' xs

all' :: [Bool] -> Bool
all' [] = True
all' (x : xs) = x && all' xs

incr' :: [Int] -> [Int]
incr' [] = []
incr' (x : xs) = (x + 1) : incr' xs

{-
[] - 0
(_:_) - 1 vagy több
(x:(y:xs)) - 2 vagy több
(_,_) - tuple (semmilyen listára)
[_,_] - 2
(x:y:[]) - 2
((:) x xs) - 1 vagy több (ugyanaz mint az (x:xs))
((,) x xs) - tuple
[_:_] - 1
((_,_):xs) - 1 vagy több
[[]] - 1
((x:xs),y) - ez nem egy lista
([]:[]) - 1 = [[]]
-}

removeEvens :: [Int] -> [Int]
removeEvens [] = []
removeEvens (x:xs) = if even x then removeEvens xs else x : removeEvens xs

-- Guardok

removeEvens' :: [Int] -> [Int]
removeEvens' [] = []
removeEvens' (x:xs)
  | even x = removeEvens' xs
  | otherwise = x : removeEvens' xs

-- AZ OTHERWISE NEM KULCSSZÓ

-- takeSqrts :: [Double] -> [Double]
-- vegyen gyököt, de a negatív számokat hagyja el
-- take' :: Int -> [a] -> [a]
-- replicate' :: Int -> a -> [a]

takeSqrts :: [Double] -> [Double]
takeSqrts [] = []
takeSqrts (x:xs)
  | x < 0 = takeSqrts xs
  | otherwise = sqrt x : takeSqrts xs

take' :: Int -> [a] -> [a]
take' a [] = []
take' a (x:xs)
  | a <= 0 = []
  | otherwise = x : take' (a - 1) xs

replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' a x = x : replicate' (a - 1) x


takeSq64 :: [Int] -> [Int]
takeSq64 [] = []
takeSq64 (x:xs)
  | 64 <- x * x = x : takeSq64 xs
  | otherwise = takeSq64 xs


accumCountEvens :: [Int] -> Int
accumCountEvens xs = accumCountEvens' xs 0
  where
    accumCountEvens' :: [Int] -> Int {- akkumulációs paraméter-} -> Int
    accumCountEvens' [] accum = accum
    accumCountEvens' (x:xs) accum
      | even x = accumCountEvens' xs (accum + 1)
      | otherwise = accumCountEvens' xs accum
{-
accumCountEvens [1,2,3,4]
accumCountEvens' [1,2,3,4] 0
accumCountEvens' [2,3,4] 0
accumCountEvens' [3,4] 1
accumCountEvens' [4] 1
accumCountEvens' [] 2
2
-}

labelBackwards :: [a] -> [(a, Int)]
labelBackwards as = labelBackwards' as
  where
    labelBackwards' :: [a] -> [(a, Int)]
    labelBackwards' [] = []
    labelBackwards' [x] = [(x, 0)]
    labelBackwards' (x:xs)
      | ((y, i):ys) <- labelBackwards' xs = (x, i + 1) : (y, i) : ys
{-
labelBackwards ['a', 'b', 'c'] (x = 'a', xs = ['b', 'c'], y = 'b', i = 1) -> ('a', 2) : ('b', 1) : ('c', 0) : []
labelBackwards ['b', 'c'] (y = 'c', i = 0, ys = []) -> ('b', 1) : ('c', 0) : []
labelBackwards ['c'] -> [('c', 0)]

-}
