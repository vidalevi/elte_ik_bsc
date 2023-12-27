module Ora3 where

list :: [Int]
list = [0, 1, 2, 3]


infiniteList :: [Int]
infiniteList = [1..]


{-

head :: [a] -> a
tail :: [a] -> [a]
length :: [a] -> Int

take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]

(++) :: [a] -> [a] -> [a]
(:)  :: a -> [a] -> [a]

1 : 2 : 3 : 4 : [] == 1 : (2 : (3 : (4 : [])))

{ x | x eleme N }

-}

-- [2..]

startingFromTwo :: [Int]
startingFromTwo = [ x + 1 | x <- [1..] ]

onlyEvens :: [Int] -> [Int]
onlyEvens xs = [ x | x <- xs, mod x 2 == 0 ]

{-
onlyPositives függvényt ami egy listát vár paraméterül és visszaadja a pozitív számokat benne
squares kifejezés ami négyzet számokat tartalmaz
cubesPlus1 kifejezés ami azokat a számokat tartalmazza amelyek egyenlőek valami x^3 + 1-el.
multiplyBy ami egy stringet és egy számot vár paraméterül és annyiszor visszaadja a stringet ++-olva amennyi a szám értéke

Q => a -- Q egy megkötés NEM paraméter
a -> b -- a paraméter és b visszatérési érték
a -> b -> c -> ... -> d = a,b,c ... bemenet és d kimenet
Q => a -> b -> .... -> d = Q megkötés és a,b,... paraméterek és d a visszatérés


-}

startingFrom :: Int -> [Int]
startingFrom x = [x..]


onlyPositives :: [Int] -> [Int]
onlyPositives xp = [ x | x <- xp, x > 0 ]

squares :: [Int]
squares = [ x * x | x <- [0..] ]

cubesPlus1 :: [Int]
cubesPlus1 = [ x ^ 3 + 1 | x <- [0..] ]

{-

repeat :: a -> [a]
replicate :: Int -> a -> [a]
null :: [a] -> Bool

-}

{-
divisors, ami egy számot vár paraméterül és visszaadja az osztóit (kivéve az 1-et és magát a számot)
isPrime, ami megállapítja egy szám prím-e
primes , ami egy konstans és csak a prímeket tartalmazza

0,1 az nem prím
-}

{-

[ x                 | x        <- xs,                                 p x ]
  mit adunk vissza   xs eleme    miből szedjük az elemeket     feltétel
-}

divisors :: Int -> [Int]
divisors xs = [ x | x <- [2..(xs-1)], mod xs x == 0]

isPrime :: Int -> Bool
isPrime y = null (divisors y)

primes :: [Int]
primes = [y | y <- [2..], isPrime y]

permutations' :: [a] -> [b] -> [(a,b)]
permutations' as bs =  [ (a,b) | a <- as , b <- bs ]

{-

String == [Char]
stars nevű függvény, ami egy növekvő számú '*' karaktert tartalmaz, stars == ["*", "**", "***", stb]
unzero ami egy listát kap paraméterül és kiszűri az összes számot aminek az utolsó számjegye 0
unsuperzero ami egy listát kap paraméterül és kiszűri az összes számot aminek az utolsó számjegyei 0ák
-}


stars :: [String]
stars = [ replicate x '*' | x <- [1..] ]

unzero :: [Int] -> [Int]
unzero xs = [ x | x <- xs, mod x 10 /= 0 ]
