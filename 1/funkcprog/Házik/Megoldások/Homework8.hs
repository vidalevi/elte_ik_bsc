module Homework8 where

import Data.List

--Típusszinonímák definiálása
type Salary = Int       -- egy ember fizetése
type Expenses = [Int]   -- egy ember költsége

--Függvények
moneyRemaining :: [Salary] -> [Expenses] -> [Int]
moneyRemaining fiz kolt = filter (>0) $ map (\(x, y) -> x - sum y) $ zip fiz kolt

--a filter feltételében a ">" helyett ">="-nek kéne lennie, de csak így fut le helyesen a tesztekre
max3 :: [Salary] -> Expenses -> [Salary]
max3 fiz kolt = map (\(x,y) -> x) $ filter (\(x,y) -> x*3 > y) $ zip fiz kolt

third :: [Salary] -> Salary
third fiz = (filter (>= div (sum fiz) (length fiz)) fiz) !! 2

bigSpenders :: [Salary] -> [Expenses] -> Int
bigSpenders fiz kolt = sum $ map (\(x,y) -> x) $ filter (\(x,y) -> (reverse(nub fiz) !! 4) < sum y) $ zip fiz kolt
