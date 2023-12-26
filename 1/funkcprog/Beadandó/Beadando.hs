{-# LANGUAGE InstanceSigs #-}
module Beadando where
import Data.List

showState a = show a
showMage a = show a
eqMage a b =  a == b
showUnit a = show a
showOneVOne a = show a 

type Name = String
type Health = Integer
type Spell = (Integer -> Integer)
type Army = [Unit]
type EnemyArmy = Army
type Amount = Integer
------------ELSŐ FELADAT------------
data State a = Alive a | Dead
instance Show a => Show (State a) where
    show :: State a -> String
    show (Alive a) = show a
    show Dead = "Dead"
instance Eq a => Eq (State a) where
    (==) :: State a -> State a -> Bool
    (Alive a) == (Alive b) = a == b
    Dead == Dead = True

data Entity = Golem Health | HaskellElemental Health deriving (Show, Eq)

data Mage = Master Name Health Spell
instance Show Mage where
    show :: Mage -> String
    show (Master x y z) = if y < 5 then "Wounded " ++ x else x
instance Eq Mage where
    (==) :: Mage -> Mage -> Bool
    (Master nev1 elet1 _) == (Master nev2 elet2 _) = nev1 == nev2 && elet1 == elet2

papi = let 
    tunderpor enemyHP
        | enemyHP < 8 = 0
        | even enemyHP = div (enemyHP * 3) 4
        | otherwise = enemyHP - 3
    in Master "Papi" 126 tunderpor
java = Master "Java" 100 (\x ->  x - (mod x 9))
traktor = Master "Traktor" 20 (\x -> div (x + 10) ((mod x 4) + 1))
jani = Master "Jani" 100 (\x -> x - div x 4)
skver = Master "Skver" 100 (\x -> div (x+4) 2)

potionMaster = 
  let plx x
        | x > 85  = x - plx (div x 2)
        | x == 60 = 31
        | x >= 51 = 1 + mod x 30
        | otherwise = x - 7 
  in Master "PotionMaster" 170 plx

data Unit = M (State Mage) | E (State Entity) deriving Eq
instance Show Unit where
    show :: Unit -> String
    show (M a) = show a
    show (E a) = show a
-----------MÁSODIK FELADAT----------
formationFix :: Army -> Army
formationFix xs = (filter armyAlive xs) ++ (filter (not . armyAlive) xs)
    where
        armyAlive :: Unit -> Bool
        armyAlive (E (Alive _)) = True
        armyAlive (M (Alive _)) = True
        armyAlive _ = False
----------HARMADIK FELADAT----------
over :: Army -> Bool
over [] = True
over (E (Alive _):xs) = False
over (M (Alive _):xs) = False
over (x:xs) = over xs
----------NEGYEDIK FELADAT----------
fight :: EnemyArmy -> Army -> Army
fight [] xs = xs
fight xs [] = []
fight (E (Alive (HaskellElemental n)):xs) (y:ys) = fightEntity 3 y : fight xs ys
fight (E (Alive (Golem n)):xs) (y:ys) = fightEntity 1 y : fight xs ys
fight (M (Alive (Master _ _ fgv)):xs) (y:ys) = fightMage fgv [y] ++ fight xs (fightMage fgv ys)
fight (x:xs) (E Dead:ys) = E Dead : fight xs ys
fight (x:xs) (M Dead:ys) = M Dead : fight xs ys
fight (E Dead:xs) (y:ys) = y : fight xs ys
fight (M Dead:xs) (y:ys) = y : fight xs ys

fightEntity :: Health -> Unit -> Unit
fightEntity damage (E (Alive (Golem hp))) = if hp-damage > 0 then E (Alive (Golem (hp - damage))) else E Dead
fightEntity damage (E (Alive (HaskellElemental hp))) = if hp-damage > 0 then E (Alive (HaskellElemental (hp - damage))) else E Dead
fightEntity damage (M (Alive (Master name hp spell))) = if hp-damage > 0 then M (Alive (Master name (hp-damage) spell)) else M Dead
fightEntity damage x = x

fightMage :: (Health -> Health) -> Army -> Army
fightMage _ [] = []
fightMage fgv (E (Alive (Golem hp)):ys) = if fgv hp > 0 then E (Alive (Golem (fgv hp))) : fightMage fgv ys else E Dead : fightMage fgv ys
fightMage fgv (E (Alive (HaskellElemental hp)):ys) = if fgv hp > 0 then E (Alive (HaskellElemental (fgv hp))) : fightMage fgv ys else E Dead : fightMage fgv ys
fightMage fgv (M (Alive (Master name hp spell)):ys) = if fgv hp > 0 then M (Alive (Master name (fgv hp) spell)) : fightMage fgv ys else M Dead : fightMage fgv ys
fightMage fgv (x:ys) = x : fightMage fgv ys
----------ÖTÖDIK FELADAT----------
haskellBlast :: Army -> Army
haskellBlast [] = []
haskellBlast xs = if length xs < 5 then dmgUnit xs else blastFinal xs $ head $ sortOn(\(x,y,z) -> -y) $ createArmyLists xs 0
    where
        createArmyLists :: Army -> Int -> [(Int, Integer, Army)]
        createArmyLists [] _ = []
        createArmyLists xs counter = if length xs >= 5 then (counter, (maxDmg (take 5 xs) 0), (take 5 xs)) : createArmyLists (tail xs) (counter+1) else []

        maxDmg :: Army -> Integer -> Integer
        maxDmg [] x = x
        maxDmg (E (Alive (Golem hp)):xs) counter = if hp >= 5 then maxDmg xs (counter+5) else maxDmg xs (counter+hp)
        maxDmg (E (Alive (HaskellElemental hp)):xs) counter = if hp >= 5 then maxDmg xs (counter+5) else maxDmg xs (counter+hp)
        maxDmg (M (Alive (Master name hp spell)):xs) counter = if hp >= 5 then maxDmg xs (counter+5) else maxDmg xs (counter+hp)
        maxDmg (x:xs) counter = maxDmg xs counter

        dmgUnit :: Army -> Army
        dmgUnit [] = []
        dmgUnit (E (Alive (Golem hp)):xs) = if hp<=5 then E Dead : dmgUnit xs else E (Alive (Golem (hp-5))) : dmgUnit xs
        dmgUnit (E (Alive (HaskellElemental hp)):xs) = if hp<=5 then E Dead : dmgUnit xs else E (Alive (HaskellElemental (hp-5))) : dmgUnit xs
        dmgUnit (M (Alive (Master name hp spell)):xs) = if hp<=5 then M Dead : dmgUnit xs else M (Alive (Master name (hp-5) spell)) : dmgUnit xs
        dmgUnit (x:xs) = x : dmgUnit xs

        blastFinal :: Army -> (Int, Integer, Army) -> Army
        blastFinal xs (l,dmg,ys) = (take l xs) ++ (dmgUnit ys) ++ (drop (5+l) xs)
----------HATODIK FELADAT----------
multiHeal :: Health -> Army -> Army
multiHeal _ [] = []
multiHeal hp (x:xs) = if (healCounter hp hp (x:xs)) == 0 then healUnit hp (x:xs) else multiHeal (healCounter hp hp (x:xs)) (healUnit hp (x:xs))
    where
        healCounter :: Health -> Health -> Army -> Health
        healCounter hp num [] = if hp == num then 0 else num
        healCounter hp 0 xs = 0
        healCounter hp num (E Dead:xs) = healCounter hp num xs
        healCounter hp num (M Dead:xs) = healCounter hp num xs
        healCounter hp num (x:xs) = healCounter hp (num-1) xs

        healUnit :: Health -> Army -> Army
        healUnit _ [] = []
        healUnit 0 xs = xs
        healUnit p (E (Alive (Golem hp)):xs) = E (Alive (Golem (hp+1))) : healUnit (p-1) xs
        healUnit p (E (Alive (HaskellElemental hp)):xs) = E (Alive (HaskellElemental (hp+1))) : healUnit (p-1) xs
        healUnit p (M (Alive (Master name hp spell)):xs) = M (Alive (Master name (hp+1) spell)) : healUnit (p-1) xs
        healUnit p (x:xs) = x : healUnit p xs
----------HETEDIK FELADAT (EXTRA)----------
battle :: Army -> EnemyArmy -> Maybe Army
battle xs ys
    | over xs && over ys = Nothing
    | over xs && not(over ys) = Just (ys)
    | not(over xs) && over ys = Just (xs)
    | otherwise = battle (formationFix $ multiHeal 20 $ haskellBlast $ fight ys xs) (formationFix $ fight xs ys)
----------TIZEDIK FELADAT (EXTRA)----------
data OneVOne = Winner String | You Health OneVOne | HaskellMage Health OneVOne deriving Eq
instance Show OneVOne where
    show (Winner x) = "<|| Winner " ++ x ++ " ||>"
    show (You hp x) = "<You " ++ show hp ++ "; " ++ (tail (init (show x))) ++ ">"
    show (HaskellMage hp x) = "<HaskellMage " ++ show hp ++ "; " ++ (tail (init (show x))) ++ ">"
----------TIZENEGYEDIK FELADAT (EXTRA)----------
finalBattle :: Health -> Health -> OneVOne
finalBattle x y = decideTurn True x y
    where
        decideTurn :: Bool -> Health -> Health -> OneVOne
        decideTurn False x y
            | y == 0 = You x (Winner "HaskellMage")
            | x < 4 = You x (decideTurn True (x*4) y)
            | y > 15 = You x (decideTurn True x (div (y*3) 5))
            | otherwise = if y > 9 then You x (decideTurn True x (y-9)) else You x (HaskellMage 0 (Winner "You"))
        decideTurn True x y
            | x == 0 = HaskellMage y (Winner "You")
            | y < 4 = HaskellMage y (decideTurn False (div x 2) (y*4))
            | x > 20 = HaskellMage y (decideTurn False (div (x*3) 4) y)
            | otherwise = if x > 11 then HaskellMage y (decideTurn False (x-11) y) else HaskellMage y (You 0 (Winner "HaskellMage"))
