module Ora10 where


{-
# f [] = b
# f (x : xs) = g x (f xs)
# iterátor
-}


zip'' :: [a] -> [b] -> [(a,b)]
zip'' [] _ = []
zip'' (x:xs) [] = []
zip'' (x:xs) (y:ys) = (x,y) : zip xs ys


-- zip' :: [a] -> [b] -> [(a,b)]
-- zip' xs ys = foldr (\x xs' -> (foldr (\y ys' xs'' -> (x,y) : ys' xs'') (\_ -> []) ys) xs') [] xs


data Maybe' a = Just' a | Nothing' deriving Show

instance Eq a => Eq (Maybe' a) where
  (==) :: Eq a => Maybe' a -> Maybe' a -> Bool
  Nothing' == Nothing' = True
  Just' x == Just' y = x == y
  _ == _ = False

data Either' a b = Left' a | Right' b deriving Show

instance (Eq b, Eq a) => Eq (Either' a b) where
  (==) :: Either' a b -> Either' a b -> Bool
  Left' a == Left' b = a == b
  Right' b == Right' a = b == a
  _ == _ = False

data List a = Nil | Cons a (List a) deriving Show

instance Eq a => Eq (List a) where
  Nil == Nil = True
  (Cons a as) == (Cons b bs) = a == b && as == bs
  _ == _ = False

data Singleton a = Singleton a deriving Show

instance Eq a => Eq (Singleton a) where
  (==) :: Eq a => Singleton a -> Singleton a -> Bool
  (Singleton x) == (Singleton y) = x == y

data TripleEither a b c = LeftT a | Middle b | RightT c deriving Show

instance (Eq a, Eq b, Eq c) => Eq (TripleEither a b c) where
  (==) :: TripleEither a b c -> TripleEither a b c -> Bool
  (LeftT a) == (LeftT b) = a == b
  (Middle a) == (Middle b) = a == b
  (RightT a) == (RightT b) = a == b
  _ == _ = False
