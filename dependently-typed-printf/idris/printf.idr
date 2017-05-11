data Format = Number | Str | Lit String

PrintfType : List Format -> Type
PrintfType = foldr (\fmt, t => case fmt of
  Number => Int -> t
  Str    => String -> t
  Lit _  => t
) String

printfFmts : (fmts : List Format) -> String -> PrintfType fmts
printfFmts []                acc = acc
printfFmts (Number :: fmts)  acc = \i => printfFmts fmts (acc ++ show i)
printfFmts (Str :: fmts)     acc = \s => printfFmts fmts (acc ++ s)
printfFmts (Lit s :: fmts)   acc = printfFmts fmts (acc ++ s)

toFormat : List Char -> List Format
toFormat []                    = []
toFormat ('%' :: 'd' :: chars) = Number  :: toFormat chars
toFormat ('%' :: 's' :: chars) = Str     :: toFormat chars
toFormat ('%' :: chars)        = Lit "%" :: toFormat chars
toFormat (c :: chars)          = case toFormat chars of
  Lit lit :: fmts => Lit (strCons c lit) :: fmts
  fmts            => Lit (strCons c "" ) :: fmts

printf : (fmt : String) -> (PrintfType . Main.toFormat . Prelude.Strings.unpack) fmt
printf _ = printfFmts _ ""

main : IO ()
main = putStrLn (printf "hello, %s" "world")
