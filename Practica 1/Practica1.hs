
{-
Ejercicio 1:
    (\x -> 4) 1
    (\x -> x + x) 2
    (\x -> \y -> x + y) 2 2
    cuatro = 4
    acc (acc (acc (acc 1)))
-}

{-
Ejercicio 2:
reducción de doble (doble 2):
por definicion de doble = x + x:
entonces se remplaza la x:
(doble 2) + (doble 2)
(2 + 2) + (2 + 2)
4 + 4
8
-}

{-
Ejercicio 3
Reducir: cuadruple 2, y cuadruple (cuadruple 2):
por definición de cuadruple = 4*x
4 * 2
8

cuadruple (cuadruple 2)
4 * (cuadruple 2)
4 * (4 * 2)
32
-}

-- Ejercicio 4:
triple x = x * 3
-- (\x -> 3*x)
succ x = x + 1
-- (\x -> x + 1)
sumarDos x = x + 2
-- (\x -> x + 2)
{-

Ejercicio 5:
Comprobar que twice succ = sumarDos
por definicion de twice =
    twice f = g
        where g x = f (f x)

entonces:
twice succ = succ (succ x)
por definición de succ = x + 1
entonces
succ x + 1
x + 1 + 1 
x + 2 

entonces x + 2 == succ (succ x) 
-}

{-
Ejercicio 7:

recucir ((twice twice) doble) 3.      
por definicion de twice =
    twice f = g
        where g x = f (f x)
entonces con x = doble:
  twice twice = g
        where g doble = (twice (twice doble)) 3

(twice (twice doble)) 3

(twice (twice doble)) 3
con f = (twice doble) y x = 3
(twice doble) ((twice doble) 3)

con f = doble y x = 3
(twice doble) (doble (doble 3))

con f = doble y x = (doble (doble 3))
doble (doble (doble (doble 3)))

-}

{-
Ejercio 8:

\x -> x * 3 
\x -> x + 1
\x -> x + 2

twice = (\f -> (\x -> f (f x)))
-- de forma resumida: (\f x -> f (f x))

twice twice = (\f x -> (f (f (f (f x)))))


-}

------------------------------------------------------------------------------------
------------------------------------------------

-- let vs where

-- triple = let f x = x * 3 in f

-- triple = f
-- 	where f x = x * 3

-- cinco = x + y
-- 	where x = 3
-- 	      y = 2 

-- cinco = let x = 3
--             in let y = 2
--                    in x + y



-- f x = let (y,z) = (x,x) in y

-- f x = x


-- f (x, y) = let z = x + y
--               in g (z,y)
--          where g (a,b) = a - b

-- f (x, y) = x

-- case

-- f p = case p of
-- 		(0, y) -> y
-- 		(x, 0) -> x
-- 	    (x, y) -> x + y

-- f p = let (x, y) = p
--           in x + y

-- f p = x + y
-- 	where (x, y) = p


-- f p = case p of
-- 	     (x,y) -> x

-- f (x, y) = x


-- f = \p -> let (x,y) = p in y

-- f p = let (x, y) = p
--           in y

-- f (x, y) = y

-----------------------------------

maximo x = g
  where g y = if x > y
                 then x
                 else y


-- (maximo 5) 6
-- = -- def maximo, x = 5
-- g 6
-- = -- def g, y = 6
-- if 5 > 6
--    then 5
--    else 6
-- = -- def if-then-else, 5 > 6 = False
-- 6


-- maximo x = g
--   where g y = if x > y
--                  then x
--                  else y

-- maximo x = \y -> if x > y 
-- 	                then x
-- 	                else y

-- maximo = \x -> \y -> if x > y 
-- 	                    then x
-- 	                    else y

--------------------------------------

id x = x

apply f = (\x -> f x)

swap (x, y) = (y, x)

const x = g
  where g y = x

-- equivalencias con apply
-- 8 = apply id 8
-- 8 = apply doble 4

-- -- demostrar esto
-- 8 = apply twice doble 2 -- tarea reducción


-- apply doble 4
-- = -- def apply, f = doble
-- (\x -> doble x) 4
-- = -- beta reduccion, x = 4
-- doble 4

-- id doble 4
-- = -- def id, x = doble
-- doble 4

-- id f x
-- =
-- apply f x


-- (3, 2) = twice swap (3, 2)
--        = swap (swap (3, 2))
--        = id (3, 2)


-- 5 = (x * (-1)) * (-1)

const x = g
  where g y = x


-- const 3 4
-- = -- def const, x = 3
-- g 4
-- = -- def g, y = 4
-- 3


-- 8 = const 8 3
-- 8 = const (\x -> 8) "fruta" 4
-- 8 = const doble id 4

-- const id id = id


compose f = (\g -> (\x -> f (g x)))

-- cuadruple = compose doble doble
--           = twice doble

-- comprobar
-- compose doble doble 2
-- = -- def compose, f = doble
-- (\g -> (\x -> doble (g x))) doble 2
-- = -- beta reduccion, g = doble
-- (\x -> doble (doble x)) 2
-- = -- beta reduccion, x = 2
-- doble (doble 2)

-- twice doble 2
-- =
-- doble (doble 2)


-- twice f = compose f f

-- tarea, comprobar que son iguales
-- threeTimes f = (\x -> f (f (f x)))
-- threeTimes f = compose (compose f f) f


-- compose swap swap p = id p
-- twice swap p        = id p

-- twice twice twice twice doble
