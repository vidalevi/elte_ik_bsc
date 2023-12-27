module Homework9 where

---------------------------------------------------

composeAll :: [a -> a] -> (a -> a)
composeAll [] = \x -> x
composeAll (x:xs) = x . composeAll xs

composeAll' :: [a -> a] -> (a -> a)
composeAll' xs = foldr (\x' xs' -> x' . xs') (\x -> x) xs

---------------------------------------------------

minimum2 :: Ord a => [a] -> a -> a
minimum2 [] x = x
minimum2 (x:xs) y = min x (minimum2 xs y)

maximum2 :: Ord a => [a] -> a -> a
maximum2 [] x = x
maximum2 (x:xs) y = max x (maximum2 xs y)

minimum2' :: Ord a => [a] -> a -> a
minimum2' [] y = y
minimum2' (x:xs) y = foldr (min) y (x:xs)

maximum2' :: Ord a => [a] -> a -> a
maximum2' [] y = y
maximum2' (x:xs) y = foldr (max) y (x:xs)

---------------------------------------------------

reverse2 :: [a] -> [a]
reverse2 [] = []
reverse2 (x:xs) = reverse2 xs ++ [x]
--Egy másik, kevésbé elegáns megoldás: reverse2 xs = last xs : (reverse2 (init xs))

reverse2' :: [a] -> [a]
reverse2' = foldr (\x xs -> xs ++ [x]) []

---------------------------------------------------

concatMap2 :: (a -> [b]) -> [a] -> [b]
concatMap2 f [] = []
concatMap2 f (x:xs) = f x ++ concatMap2 f xs

concatMap2' :: (a -> [b]) -> [a] -> [b]
concatMap2' f = foldr (\x xs -> f x ++ xs) []

---------------------------------------------------
safeIndex :: Int -> [a] -> Maybe a
safeIndex _ [] = Nothing
safeIndex y (x:xs)
    | y == 0 = Just x
    | otherwise = safeIndex (y-1) xs

safeIndex' :: Int -> [a] -> Maybe a
safeIndex' y xs = (foldr (\x f i -> if i == 0 then Just x else f (i-1)) (\_ -> Nothing) xs) y