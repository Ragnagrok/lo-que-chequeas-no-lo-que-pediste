-- | The definition of correct: the output is in order, and it has exactly the
-- elements of the input. Nothing here lists cases.
module Spec (meetsSpec) where

import Data.List (sort)

meetsSpec :: ([Int] -> [Int]) -> [Int] -> Bool
meetsSpec f xs = ordered ys && sameElements xs ys
  where
    ys = f xs

ordered :: [Int] -> Bool
ordered ys = and (zipWith (<=) ys (drop 1 ys))

-- 'sort' only to compare multisets; the implementations under test don't see it.
sameElements :: [Int] -> [Int] -> Bool
sameElements xs ys = sort xs == sort ys
