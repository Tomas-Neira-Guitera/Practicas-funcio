-- Ejercicio 2:

compose12 twice compose :: b' -> a' -> (a' -> b') -> a' -> a'
compose12 twice compose = compose12 twice compose f g x

compose12 twice compose f g x
---------------------------
                            def compose12, f <- twice, g <- compose, f <- f, g <- g
twice (compose f g) x
---------------------
                            def twice, f <- compose f g, x <- x
                        
(compose f g) compose f g x
              -------------
                            def de compose, f <- f, g <- g, x <- x
                        
(compose f g) f (g x)
---------------------
                          def de compose, f <- f, g <- g, x <- f (g x)
f (g f (g x))

