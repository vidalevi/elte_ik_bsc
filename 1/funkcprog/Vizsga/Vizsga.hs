module Vizsga where
import Data.List
import Data.Char
import Data.Maybe

removeEmpties :: [[a]] -> [[a]]
removeEmpties xs = filter (not . null) xs

dropUntil :: ([a] -> Bool) -> [a] -> [a]
dropUntil _ [] = []
dropUntil f (x:xs)
    | not (f (x:xs)) = dropUntil f xs
    | otherwise = (x:xs)

sumOfDigits :: Integral a => a -> a
sumOfDigits 0 = 0
sumOfDigits x = (mod (abs x) 10) + sumOfDigits (div (abs x) 10)

hasBy :: Eq b => (a -> b) -> [a] -> [b] -> Bool
hasBy _ [] _ = False
hasBy f (x:xs) ys
    | elem (f x) ys = True
    | otherwise = hasBy f xs ys

morse :: [(Char,String)]
morse = [(' ',"/"),('a',".-"),('b',"-..."),('c',"-.-."),('d',"-.."),('e',"."),('f',"..-."),('g',"--."),('h',"...."),('i',".."),('j',".---"),('k',"-.-"),('l',".-.."),('m',"--"),('n',"-."),('o',"---"),('p',".--."),('q',"--.-"),('r',".-."),('s',"..."),('t',"-"),('u',"..-"),('v',"...-"),('w',".--"),('x',"-..-"),('y',"-.--"),('z',"--..")]
encodeMorse :: String -> String
encodeMorse xs = unwords $ morseHelp xs
    where
        morseHelp :: String -> [String]
        morseHelp [] = []
        morseHelp (x:xs)
            | isNothing (lookup x morse) = "?" : morseHelp xs
            | otherwise = fromJust (lookup x morse) : morseHelp xs

productIfs :: Num b => [a -> Bool] -> [(a, b)] -> b
productIfs fs xs = product $ map (\(x,y) -> y) $ filter (\(x,y) -> decideIf fs x) xs
    where
        decideIf :: [a -> Bool] -> a -> Bool
        decideIf [] _ = True
        decideIf (x:xs) y
            | x y = decideIf xs y
            | otherwise = False

data Place a = Lake String a | Mountain String  a | Cave String a deriving (Show, Eq)
levelLineL :: (Num a, Ord a) => [Place a] -> a -> [String]
levelLineL [] _ = []
levelLineL ((Mountain name l):xs) n = levelLineL xs n
levelLineL ((Cave name l):xs) n = levelLineL xs n
levelLineL ((Lake name l):xs) n
    | l < n = name : levelLineL xs n
    | otherwise = levelLineL xs n
