{-
    Python5 — a hypothetic language
    Copyright (C) 2015 - Yuriy Syrovetskiy

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}

{-# LANGUAGE NoImplicitPrelude #-}

module Types where

import Python5.Builtin
import Test.Hspec

spec :: Spec
spec =
    describe "list operations" $ do
        let fruits = ["Banana", "Apple", "Lime"]
        it "list comprehensions" $ do
            let loud_fruits = [fruit.upper() | fruit <- fruits]
            loud_fruits `shouldBe` ["BANANA", "APPLE", "LIME"]
        it "enumerate" $ do
            list(enumerate(fruits))
                `shouldBe` [(0, "Banana"), (1, "Apple"), (2, "Lime")]
