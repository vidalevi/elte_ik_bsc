module LastHomework where

import Data.Char
import Data.List
import Data.Maybe

which :: ([Char], [Char], [Char]) -> Char -> Int
which (xs,ys,zs) x
    | elem x xs = 1
    | elem x ys = 2
    | elem x zs = 3
    | otherwise = 0

matches :: (Int, Int) -> (Int, Int) -> Bool
matches (x,y) (i,j)
    | x == i = True
    | x == j = True
    | y == i = True
    | y == j = True
    | otherwise = False

toUpperCase :: String -> String
toUpperCase "" = ""
toUpperCase (x:xs)
    | not (isAlpha x) = (x:xs)
    | otherwise = toUpper x : xs

swap :: Maybe a -> b -> Maybe b
swap Nothing a = Nothing
swap (Just x) y = Just y

numeric :: String -> Int
numeric [] = 0
numeric (x:xs)
    | x == 'r' = 4 + numeric xs
    | x == 'w' = 2 + numeric xs
    | x == 'x' = 1 + numeric xs

pythagoreans :: [(Int, Int, Int)]
pythagoreans = [(x,y,z) | x <- [1..100], y <- [1..100], z <- [1..100], x*x + y*y == z*z, x <= y, y <= z]

hasLongWord :: Int -> String -> Bool
hasLongWord _ "" = False
hasLongWord n (x:xs) = accWords n n (x:xs)
    where
        accWords :: Int -> Int -> String -> Bool
        accWords _ 0 _ = True
        accWords _ _ [] = False
        accWords n acc (x:xs)
            | isSpace x = accWords n n xs
            | otherwise = accWords n (acc-1) xs

align :: Int -> String -> String
align n xs
    | length xs >= n = xs
    | otherwise = replicate (n - (length xs)) ' ' ++ xs

modify :: (a -> Maybe a) -> [a] -> [a]
modify _ [] = []
modify f (x:xs)
    | isNothing (f x) = xs
    | otherwise = fromJust (f x) : xs

isLonger :: [a] -> Int -> Bool
isLonger [] _ = False
isLonger _ 0 = True
isLonger (x:xs) n = isLonger xs (n-1)

removeAccents :: String -> String
removeAccents "" = ""
removeAccents (x:xs)
    | x == 'á' = 'a':removeAccents xs
    | x == 'é' = 'e':removeAccents xs
    | x == 'ö' || x == 'ő' || x == 'ó' = 'o':removeAccents xs
    | x == 'ú' || x == 'ű' || x == 'ü' = 'u':removeAccents xs
    | x == 'í' = 'i':removeAccents xs
    | otherwise = x:removeAccents xs

strip :: String -> String
strip xs = reverse $ frontStrip $ reverse $ frontStrip xs
    where
        frontStrip :: String -> String
        frontStrip ('_':xs) = frontStrip xs
        frontStrip xs = xs

data RPS = Rock | Paper | Scissors deriving (Show, Eq)

beats :: RPS -> RPS
beats Paper = Rock
beats Rock = Scissors
beats Scissors = Paper

firstBeats :: [RPS] -> [RPS] -> Int
firstBeats xs ys = helpBeats 0 (zip xs ys)
    where
        helpBeats :: Int -> [(RPS,RPS)] -> Int
        helpBeats n [] = n
        helpBeats n ((x,z):zs)
            | beats x == z = helpBeats (n+1) zs
            | otherwise = helpBeats n zs

data Temperature = Daytime Int | Night Int deriving (Show, Eq)

isDaytime :: Temperature -> Bool
isDaytime (Daytime x) = True
isDaytime (Night x) = False

extremes :: [Temperature] -> (Int, Int)
extremes xs = (maximum $ dayEx xs, minimum $ nightEx xs)
    where
        dayEx :: [Temperature] -> [Int]
        dayEx [] = []
        dayEx ((Daytime x):xs) = x : dayEx xs
        dayEx ((Night x):xs) = dayEx xs
        
        nightEx :: [Temperature] -> [Int]
        nightEx [] = []
        nightEx ((Night x):xs) = x : nightEx xs
        nightEx ((Daytime x):xs) = nightEx xs
