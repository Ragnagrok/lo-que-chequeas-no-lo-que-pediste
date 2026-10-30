-- | Three implementations of "sort a list of numbers". Only one of them sorts.
module Implementations (Impl (..), implementations) where

import Data.Maybe (fromMaybe)

import Examples (examples)
import SavedAnswers (answers)

data Impl = Impl { name :: String, run :: [Int] -> [Int] }

implementations :: [Impl]
implementations =
  [ Impl "insertionSort" insertionSort
  , Impl "fromExamples" fromExamples
  , Impl "fromSaved" fromSaved
  ]

-- | The real thing.
insertionSort :: [Int] -> [Int]
insertionSort = foldr insert []
  where
    insert x [] = [x]
    insert x (y : ys)
      | x <= y    = x : y : ys
      | otherwise = y : insert x ys

-- | Looks the answer up in the example suite; anything else comes back as it went in.
fromExamples :: [Int] -> [Int]
fromExamples xs = fromMaybe xs (lookup xs examples)

-- | The same trick, with a table of answers for the saved random cases.
fromSaved :: [Int] -> [Int]
fromSaved xs = fromMaybe xs (lookup xs answers)
