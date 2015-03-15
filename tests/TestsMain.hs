import Data.Complex
import Test.Hspec

import Python5.Builtin as Builtin

main = hspec $ do
    describe "__builtin__.abs" $ do
        it "returns the absolute value of a number" $ do
            Builtin.abs 1 `shouldBe` 1
            Builtin.abs (-2) `shouldBe` 2
        it "The argument may be an integer or a floating point number" $ do
            Builtin.abs (3 :: Integer) `shouldBe` 3
            Builtin.abs (-4 :: Double) `shouldBe` 4
        it "If the argument is a complex number, its magnitude is returned" $ do
            Builtin.abs (3 :+ 4) `shouldBe` 5