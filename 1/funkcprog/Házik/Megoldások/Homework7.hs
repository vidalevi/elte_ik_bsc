module Homework7 where

{-# LANGUAGE InstanceSigs #-}

-- REKURZÍV TÍPUSOK

--1. Bináris fa
data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Eq, Show)

tr1 :: Tree Int
tr1 = Node (Leaf 1) 2 (Node (Node (Leaf 3) 4 (Leaf 5)) 6 (Leaf 7))

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree fgv (Leaf x) = Leaf (fgv x)
mapTree fgv (Node x a y) = Node (mapTree fgv x) (fgv a) (mapTree fgv y)

sumTree :: Num a => Tree a -> a
sumTree (Leaf x) = x
sumTree (Node x a y) = (sumTree x) + a + (sumTree y)


--2. Stream
data Stream a = SCons a (Stream a)

takeStream :: Int -> Stream a -> [a]
takeStream x (SCons a as)
    | x <= 0 = []
    | otherwise = a : takeStream (x - 1) as

repeatStream :: a -> Stream a
repeatStream x = SCons x (repeatStream x)

iterateStream :: a -> (a -> a) -> Stream a
iterateStream x f = SCons x (iterateStream (f x) f)

zipWithStream :: (a -> b -> c) -> Stream a -> Stream b -> Stream c
zipWithStream fgv (SCons x xs) (SCons y ys) = SCons (fgv x y) (zipWithStream fgv xs ys)

takeWhileStream :: (a -> Bool) -> Stream a -> [a]
takeWhileStream fgv (SCons x xs)
    |fgv x = x : takeWhileStream fgv xs
    |otherwise = []

--PEANO SZÁMOK
data Nat = Zero | Succ Nat

peanoToInt :: Nat -> Int
peanoToInt Zero = 0
peanoToInt (Succ x) = 1 + peanoToInt x

instance Show Nat where
    show p = "Peano " ++ show (peanoToInt p)

instance Eq Nat where
    (==) :: Nat -> Nat -> Bool
    Zero == Zero = True
    (Succ x) == (Succ y) = x == y
    _ == _ = False

instance Ord Nat where
    (>=) :: Nat -> Nat -> Bool
    (Succ x) >= (Succ y) = x >= y
    _ >= Zero = True

    (<=) :: Nat -> Nat -> Bool
    (Succ x) <= (Succ y) = x <= y
    Zero <= _ = True

    (<) :: Nat -> Nat -> Bool
    (Succ x) < (Succ y) = x < y
    Zero < _ = True

    (>) :: Nat -> Nat -> Bool
    (Succ x) > (Succ y) = x > y
    _ > Zero = True

lengthP :: [a] -> Nat
lengthP [] = Zero
lengthP (x:xs) = Succ (lengthP xs)