import Text.Printf
main = do
  putStrLn (printf "hello, %s\n" ("world" :: String))
  putStrLn (printf "1 + 1 = %d\n" (2 :: Int))
  putStrLn (printf "hello, %d\n" ("world" :: String))
