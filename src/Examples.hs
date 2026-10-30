-- | A fixed suite of example tests, written by hand: input and expected output.
-- This is the "222 tests" of the article, in miniature.
module Examples (examples) where

examples :: [([Int], [Int])]
examples =
  [ ([], [])
  , ([1], [1])
  , ([2, 1], [1, 2])
  , ([1, 2], [1, 2])
  , ([3, 1, 2], [1, 2, 3])
  , ([5, 4, 3, 2, 1], [1, 2, 3, 4, 5])
  , ([2, 2, 1], [1, 2, 2])
  , ([-1, 0, -3], [-3, -1, 0])
  , ([10, -10, 0, 5], [-10, 0, 5, 10])
  , ([7, 7, 7], [7, 7, 7])
  , ([4, 1, 3, 9, 7], [1, 3, 4, 7, 9])
  , ([100, 50, 75, 25], [25, 50, 75, 100])
  ]
