module Homework6 where


{-# LANGUAGE InstanceSigs #-}
import Data.List hiding (minimumBy)


-- GOLF KIFEJEZÉSEK
data GolfScore = Ace | Albatross | Eagle | Birdie | Par | Bogey Int deriving Show

instance Eq GolfScore where
    (==) :: GolfScore -> GolfScore -> Bool
    Ace == Ace = True
    Albatross == Albatross = True
    Eagle == Eagle = True
    Birdie == Birdie = True
    Par == Par = True
    (Bogey int) == (Bogey int') = int == int'
    _ == _ = False

score :: Int -> Int -> GolfScore
score _ 1 = Ace
score x y
    | x - y >= 3 = Albatross
    | x - y == 2 = Eagle
    | x - y == 1 = Birdie
    | x == y = Par
    | x < y = Bogey (y - x)



-- MAYBE TÍPUS
withFallback :: a -> Maybe a -> a
withFallback _ (Just a) = a
withFallback x Nothing = x

maybeMap :: (a -> b) -> Maybe a -> Maybe b
maybeMap _ Nothing = Nothing
maybeMap fgv (Just a) = Just (fgv a)

joinMaybe :: Maybe (Maybe a) -> Maybe a
joinMaybe (Just a) = a
joinMaybe Nothing = Nothing

filterNothing :: [Maybe a] -> [a]
filterNothing [] = []
filterNothing (x:xs)
    | Just y <- x = y : filterNothing xs
    | otherwise = filterNothing xs

bfm :: (a -> Maybe b) -> [a] -> [b]
bfm fgv [] = []
bfm fgv xs = filterNothing' (map fgv xs)
    where
        filterNothing' :: [Maybe a] -> [a]
        filterNothing' [] = []
        filterNothing' (x:xs)
            | Just y <- x = y : filterNothing' xs
            | otherwise = filterNothing' xs



--Magasabbrendű gyakorlás
takeWhilePair :: (a -> a -> Bool) -> [a] -> [a]
takeWhilePair _ [] = []
takeWhilePair _ [x] = [x]
takeWhilePair fgv (x:xs)
    | fgv x (head xs) = x : takeWhilePair fgv xs
    | otherwise = [x]


dropWhilePair :: (a -> a -> Bool) -> [a] -> [a]
dropWhilePair _ [] = []
dropWhilePair _ [x] = []
dropWhilePair fgv (x:xs)
    | fgv x (head xs) = dropWhilePair fgv xs
    | otherwise = x : xs


descendingSegments :: Ord a => [a] -> [[a]]
descendingSegments [] = []
descendingSegments [x] = []
descendingSegments (x:y:xs)
    | x > y = (takeWhilePair (>) (x:y:xs)) : descendingSegments (dropWhilePair (>) (x:y:xs))
    | otherwise = descendingSegments (y:xs)


unorderedEq :: Eq a => [a] -> [a] -> Bool
unorderedEq xs ys = eqHelp xs ys == eqHelp ys xs
    where
        eqHelp :: Eq a => [a] -> [a] -> [a]
        eqHelp [] _ = []
        eqHelp xs [] = xs
        eqHelp (x:xs) ys
            | elem x ys = eqHelp xs (delete x ys)
            | otherwise = eqHelp xs ys


minimumBy :: Ord b => (a -> b) -> {- nem üres -} [a] -> a
minimumBy fgv (x:xs) = head (sortOn fgv (x:xs))

powerSet :: [a] -> [[a]]
powerSet [] = [[]]
powerSet xs = subsequences xs