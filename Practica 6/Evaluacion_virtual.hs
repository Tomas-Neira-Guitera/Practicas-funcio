-- Ejercicio 1:

-- Tipar compose12 twice compose

twice :: (a -> a) -> a -> a
twice f x = f (f x)

compose :: (b' -> c') -> (a' -> b') -> a' -> c'
compose f g x = f (g x)

compose12 :: (d'' -> c'') -> (a'' -> b'' -> d'') -> a'' -> b'' -> c''
compose12 f g x y = f (g x y)


d'' <- a -> a
c'' <- a -> a

compose12 twice :: (a'' -> (b'' -> a -> a)) -> a'' -> b'' -> a -> a
compose12 twice :: (a'' -> b'' -> a -> a) -> (a'' -> b'' -> a -> a)

a'' <- b' -> c'
(b'' -> a -> a) <- (a' -> b') -> a' -> c'
a' = c' 

compose12 twice compose :: (b' -> a') -> (a' -> b') -> a' -> a'

---------------------------------------------------------------------------------
-- Ejercicio 2:

compose12 twice compose :: (b' -> a') -> (a' -> b') -> a' -> a'
compose12 twice compose = compose12 twice compose f g x

compose12 twice compose f g x
---------------------------
                            def compose12, f <- twice, g <- compose, x <- f, y <- g
twice (compose f g) x
---------------------
                            def twice, f <- compose f g, x <- x
                        
compose f g (compose f g x)
-----------------------------
                            def de compose, f <- f, g <- g, x <- (compose f g x)
                        
f (g (compose f g x))
      -------------
                          def de compose, f <- f, g <- g, x <- x
f (g (f (g x)))


anon :: (b' -> a') -> (a' -> b') -> a' -> a'
anon = \f g x -> f (g (f (g x)))
