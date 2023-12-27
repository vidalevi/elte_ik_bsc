module Ora2 where


tuple1 :: (Int, String)
tuple1 = (1, "alma")

xAndXPlus1 :: Int -> (Int, Int)
xAndXPlus1 x = (x, x + 1)

a :: (Int, Bool, String, Integer)
a = (2, True, "nem", 3)

b :: (Double, Bool, Bool, Int, Int, Char)
b = (1.2, True, False, 3, 4, 'b')

firstElem :: (Int, Bool) -> Int
firstElem (c,b) = c

firstElem' :: (String, Bool) -> String
firstElem' (c,b) = c

firstElem'' :: (a, Bool) -> a
firstElem'' (a,b) = a

secondElem :: (Int, Bool) -> Bool
secondElem (e, f) = f


firstElem''' :: (a, b) -> a
firstElem''' (a,b) = a


--- secondElem, kap egy tetszőleges (a,b) tuple-t és adja vissza a második elemét
--- swap, kap egy tetszőleges (a,b) tuple-t és fordítsa meg benne az elemek sorrendjét
--- thrfst, kap egy tetszőleges (a,b,c) tuple-t és visszaadja az első és harmadik elemét

secondElem' :: (a, b) -> b
secondElem' (a,b) = b

swap :: (a,b) -> (b, a)
swap (a,b) = (b,a)

thrfst :: (a,b,c) -> (a,c)
thrfst (a,b,c) = (a,c)


-- ad-hoc polimorfizmus
eq :: Eq a => a -> a -> Bool
eq a b = a == b

addthree :: Num a => a -> a -> a -> a
addthree a b c = a + b + c

getMax :: Ord a => a -> a -> a -> a
getMax a b c = max (max a b) c

-- notEq3 függvényt ami 3 kifejezésről eldönti hogy EGYIK SEM egyenlő a másikkal
-- funkyNum függvényt ami 4 számot összeszoroz
-- superMin öt számból a legkisebbet adja vissza

-- (Eq a, Num a) =>
-- Eq a => Num a =>

notEq3 :: Eq a => a -> a -> a -> Bool
notEq3 a b c = a /= b && a /= c && b /= c

funkyNum :: Num a => a -> a -> a -> a -> a
funkyNum a b c d = a * b * c * d

superMin :: Ord a => a -> a -> a -> a -> a -> a
superMin a b c d e = min (min (min (min a b) c) d) e
