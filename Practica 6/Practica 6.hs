-- Ejercicio 1

Propiedad: doble = \x -> 2 * x

Por principio de extencionalidad es equivalente demostrar que,
para todo x. doble x = (\x -> 2 * x) x

Sea n un numero cualquiera. Se verá que doble n = (\x -> 2 * x) n 

doble n                                              (\x -> 2 * x) n 
-------                                              ----------------
        por def doble, con x <- n                                       por beta, con x <- n
n + n                                                2 * n 
                                                                        por aritmetica
                                                     n + n



b. Propiedad: compose doble doble = cuadruple

Por principio de extencionalidad es equivalente demostrar que,
para todo x. compose doble doble x = cuadruple x

Sea n un numero. Se verá que compose doble doble n = cuadruple n 

compose doble doble n                                                    cuadruple n 
---------------------                                                    ------------
            por def de componse, con f <- doble, g <- doble, x <- n                     por def de cuadruple, con x <- n 
doble (doble n)                                                          4 * n   
---------------                                                                         por aritmetica.
            por def de doble, con x <- doble n                           n + n + n + n 
doble n + doble n
-------
            por def de doble, con x <- n 
n + n + doble n 
        -------
            por def de doble, con x <- n 
n + n + n + n        

-- Ejercicio 2:

a. para todo x. para todo y. x && y = not ((not x) || (not y))

Sea b y b2 dos booleaneanos. Se vera que b && b2 = not ((not b) || (not b2))

b && b2                                         not ((not b) || (not b2))
            por def de &&                                                   por def de not 
b      b2                                       b                 b2
True   False = False                            True  = False     True  = False
True   True  = True                             False = True      False = True
False  False = False                                                        por def de ||
False  False = False                            b       b2
                                                True    True  = True 
                                                True    False = True
                                                False   True  = True
                                                False   False = False 

-- Ejercicio 4

Demostrar: uncurry (flip const) = snd

Por principio de extencionalidad es equivalente demostrar que,
para todo (x, y). uncurry (flip const) (x, y) = snd (x, y)

lado izq:
uncurry (flip const) (x , y)
----------------------------
                        por def de uncurry, f <- flip const, (x, y) <- (x, y) 
flip const x y
-----------------
                        por def de flip, f <- const, x <- x, y <- y
const y x
                        por def de const, x <- y, y <- x
y 

lado der:
snd (x, y)
---------- 
                        por def de snd, (x, y) <- (x, y)
y

-- Ejercicio 5
Por pp de extencionalidad para todo f. curry (uncurry f) = f
para todo x. para todo y. curry (uncurry f) x y = f x y

lado izq:
curry (uncurry f) x y
---------------------
                        por def de curry. f <- uncurry f, x <- x, y <- y
uncurry f (x, y)
----------------
                        por def de uncurry. f <- f, (x , y) <- (x, y)
f x y

lado der:
f x y 

-- Ejercicio 6

assoc :: (a,(b,c)) -> ((a,b),c)
assoc (x,(y,z)) = ((x,y),z)

appAssoc :: (((a,b),c) -> d) -> (a,(b,c)) -> d
appAssoc f p = f (assoc p)

Por pp de extencionalidad para todo f. appAssoc (uncurry (uncurry f)) = uncurry (compose uncurry f)
para todo (x,(y,z)). appAssoc (uncurry (uncurry f)) (x,(y,z)) = uncurry (compose uncurry f) (x,(y,z))

lado izq:
appAssoc (uncurry (uncurry f)) (x,(y,z))
----------------------------------------
                                        por def de appAssoc. f <- uncurry (uncurry f), p <- (x,(y,z))
uncurry (uncurry f) (assoc (x,(y,z)))
                    -----------------
                                        por def de assoc. (x,(y,z)) <- (x,(y,z))
uncurry (uncurry f) ((x,y),z)
-----------------------------                  
                                        por def de uncurry. f <- uncurry f, (x, y) <- ((x,y),z)
uncurry f (x, y) z
----------------
                                        por def de uncurry. f <- f, (x, y) <- (x, y)
f x y z
                                       
lado der:
uncurry (compose uncurry f) (x,(y,z))
-------------------------------------
                                        por def de uncurry. f <- compose uncurry f, (x, y) <- (x,(y,z))
compose uncurry f x (y,z)
-------------------
                                        por def de componse. f <- uncurry, g <- f, x <- x
uncurry (f x) (y,z)
-------------------
                                        por def de uncurry. f <- f x, (x, y) <- (y, z)
f x y z

        





        




            