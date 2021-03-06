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

{-# LANGUAGE NamedFieldPuns #-}

import Data.List          ( delete, isSuffixOf )
import Python5.Builtin
import System.Directory   ( getDirectoryContents, setCurrentDirectory )
import System.Environment ( getEnvironment )
import System.FilePath    ( (</>) )
import System.Process     ( CreateProcess(env), proc, readCreateProcess )
import Test.Tasty         ( defaultMain, testGroup )
import Test.Tasty.HUnit   ( (@?=), testCase )

examplesDir :: String
examplesDir = "examples"

testInput :: String
testInput = "TEST INPUT"

expectedOutput :: Dict String String
expectedOutput = dict
    [ "calc.hs" := "0.5\n8\n5.666666666666667\n5\n"
    , "control.hs" := "The product is: 384\n"
    , "data.hs" := unlines  [ "[BANANA, APPLE, LIME]"
                            , "[(0, Banana), (1, Apple), (2, Lime)]" ]
    , "dict.hs" := "3\n"
    , "functions.hs" := "0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 \n"
    , "io.hs" := "Hello, I'm Python5!\nWhat is your name?\nHi, TEST INPUT.\n"
    , "types.hs" := "ValueError ()\n"
    ]

main :: IO ()
main = do
    setCurrentDirectory ".." -- to the project dir
    files <- getDirectoryContents examplesDir
    let hsFiles = filter (".hs" `isSuffixOf`) files
    let examples = delete "Test.hs" hsFiles
    defaultMain $
        testGroup "examples"
            [ testCase ex $ do
                  result <- python5 (examplesDir </> ex) testInput
                  Just result @?= get(ex) expectedOutput
            | ex <- examples ]

python5 :: String -> String -> IO String
python5 scriptFile stdinContent = do
    curEnv <- getEnvironment
    let cmd = "bin" </> "python5"
        args = [scriptFile]
        env = Just $ curEnv ++ [("PYTHON5_LOCALTEST", "1")]
        processInfo = (proc cmd args){env}
    readCreateProcess processInfo stdinContent
