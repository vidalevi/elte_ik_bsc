module Homework2 where

-- Parametikus polimorfizmus
triTuplify :: a -> b -> c -> (a, b, c)
triTuplify a b c = (a, b, c)

replaceMiddle :: d -> (a,b,c) -> (a,d,c)
replaceMiddle d (a, b, c) = (a, d, c)

dropThird :: (a,b,c,d) -> (a,b,d)
dropThird (a,b,c,d) = (a,b,d)

identity :: a -> a
identity a = a


-- Ad-hoc polimorfizmus
mulThree :: Num a => a -> a -> a -> a
mulThree a b c = a*b*c

comparison :: Ord a => a -> a -> (Bool {- első nagyobb egyenlő-e -} , Bool {- első kisebb egyenlő-e -})
comparison a b = (a>=b, a<=b)


-- Nehezebb (nem kötelező) feladatok
vecAdd :: Floating a => (a,a) -> (a,a) -> (a,a)
vecAdd (a,b) (c,d) = (a+c,b+d)

vecSub :: Floating a => (a,a) -> (a,a) -> (a,a)
vecSub (a,b) (c,d) = (a-c, b-d)

vecCMul :: Floating a => a -> (a,a) -> (a,a)
vecCMul a (b,c) = (b*a, c*a)

vecCDiv :: Floating a => a -> (a,a) -> (a,a)
vecCDiv a (b,c) = (b/a, c/a)

arg :: Floating a => (a,a) -> a
arg (a,b) = atan(b/a) / pi * 180
