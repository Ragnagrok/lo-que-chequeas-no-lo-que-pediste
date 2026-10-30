-- | Runs every implementation against three checks and prints the scores:
--
--   * examples: the fixed suite of example tests;
--   * saved: the definition, but only on random cases drawn once and saved;
--   * fresh: the definition, on a thousand new random cases each run.
module Main (main) where

import Test.QuickCheck

import Examples (examples)
import Implementations (Impl (..), implementations)
import Saved (saved)
import Spec (meetsSpec)

main :: IO ()
main = do
  putStrLn (row "implementation" "examples" "saved" "fresh")
  mapM_ report implementations
  where
    report impl = do
      fresh <- freshCheck (run impl)
      putStrLn (row (name impl) (exampleScore (run impl)) (savedScore (run impl)) fresh)

    row a b c d = pad 16 a ++ pad 11 b ++ pad 9 c ++ d
    pad n s = take n (s ++ repeat ' ')

exampleScore :: ([Int] -> [Int]) -> String
exampleScore f = score [f input == expected | (input, expected) <- examples]

savedScore :: ([Int] -> [Int]) -> String
savedScore f = score (map (meetsSpec f) saved)

score :: [Bool] -> String
score oks = show (length (filter id oks)) ++ "/" ++ show (length oks)

freshCheck :: ([Int] -> [Int]) -> IO String
freshCheck f = do
  result <- quickCheckWithResult stdArgs { chatty = False, maxSuccess = 1000 } (meetsSpec f)
  pure $ case result of
    Success {}                     -> "OK (1000 new cases)"
    Failure { failingTestCase = c } -> "FAILED on " ++ unwords c
    _                              -> "gave up"
