{-# LANGUAGE InstanceSigs #-}
module Homework10 where

data ListWithHoles a = Nil | Cons a (ListWithHoles a)| Hole (ListWithHoles a) deriving Show
instance Eq a => Eq (ListWithHoles a) where
    (==) :: ListWithHoles a -> ListWithHoles a -> Bool
    Nil == Nil = True
    Cons x y == Cons x' y' = x == x' && y == y'
    Hole x == Hole x' = x == x'
    _ == _ = False
-----------------------------------------------
dehole :: ListWithHoles a -> [a]
dehole (Hole xs) = dehole xs
dehole (Cons x xs) = x : dehole xs
dehole Nil = []
-----------------------------------------------
fromMaybeList :: [Maybe a] -> ListWithHoles a
fromMaybeList (Nothing:xs) = Hole (fromMaybeList xs)
fromMaybeList ((Just x):xs) = Cons x (fromMaybeList xs)
fromMaybeList [] = Nil
-----------------------------------------------
preserveHoles :: ListWithHoles a -> [Maybe a]
preserveHoles Nil = []
preserveHoles (Hole xs) = Nothing : preserveHoles xs
preserveHoles (Cons x xs) = (Just x) : preserveHoles xs
-----------------------------------------------
filterLWH :: (a -> Bool) -> [a] -> ListWithHoles a
filterLWH f [] = Nil
filterLWH f (x:xs)
    | f x = Cons x (filterLWH f xs)
    | otherwise = Hole (filterLWH f xs)
-----------------------------------------------
fillHoles :: ListWithHoles a -> a -> [a]
fillHoles Nil x = []
fillHoles (Hole xs) x = x : fillHoles xs x
fillHoles (Cons x xs) y = x : fillHoles xs y