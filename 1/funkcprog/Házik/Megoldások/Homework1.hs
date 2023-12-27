module Homework1 where

-- Első feladat - Függvényhasználat

addThree :: Int -> Int
addThree x = x + 3

double :: Int -> Int
double x = x * 2

one :: Int -- "konstans függvény", olyan amelynek nincs bemeneti paramétere
one = 1

two :: Int
two = double one

four :: Int
four = addThree one

doubleThenAddThree :: Int -> Int
doubleThenAddThree x = addThree (double x)

nine :: Int
nine = double(addThree two) - one



-- Második Feladat - Mintaillesztés és If-Then-Else

cITE :: Int -> Int -> Int -> Int
cITE a b c = if a < 0 then b else c 

isDollar :: Char -> Bool
isDollar '$' = True
isDollar _ = False

bigNumCheck :: Int -> Int -> Int -> Int -> Bool
bigNumCheck a b c d = if a*b*c*d == 2180720 then True else False

xor1 :: Bool -> Bool -> Bool
xor1 x y = if x == True && y == True then False else (if x == True && y == False then True else (if x == False && y == True then True else False))

xor2 :: Bool -> Bool -> Bool
xor2 True True = False
xor2 True False = True
xor2 False True = True
xor2 False False = False

xor3 :: Bool -> Bool -> Bool
xor3 a b = not(not (a && not (a && b)) && not(b && not(a && b)))