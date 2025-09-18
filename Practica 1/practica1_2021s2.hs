doble x = x + x
cuadruple x = x * 4

-- ejercicio 1.
-- (\x y -> x + y) 2 2
-- (\x -> 4 + x) 0
-- (\x -> 4) 2
-- doble (doble 1)
-- cuadruple 1
-- (twice doble) 1
-- (\f -> f (f 1)) doble
-- (\f -> \g -> f (g 1)) doble doble

-- (\f -> (\g -> f (g 1))) doble doble
-- = -- beta reduccion, f = doble
-- (\g -> doble (g 1)) doble
-- = -- beta reduccion, g = doble
-- doble (doble 1)

------------------------------------

-- ejercicio 2

-- |
-- v
-- doble (doble 2)
-- = -- def doble
-- doble 2 + doble 2
-- = -- def doble
-- (2 + 2) + doble 2
-- = -- def doble
-- (2 + 2) + (2 + 2)
-- = -- aritmetica
-- 8

--         |
--         v
-- doble (doble 2)
-- = -- def doble
-- doble (2 + 2)
-- = -- def doble
-- (2 + 2) + (2 + 2)
-- = -- aritmetica
-- 8

-----------------------------------------

-- ejercicio 3

-- cuadruple 2
-- = -- def cuadruple
-- 2 * 4
-- = -- aritmetica
-- 8

-- cuadruple (cuadruple 2)
-- =
-- cuadruple 2 * 4
-- =
-- (2 * 4) * 4
-- =
-- 32

-- cuadruple (cuadruple 2)
-- =
-- cuadruple (2 * 4)
-- =
-- (2 * 4) * 4
-- =
-- 32

-----------------------------------------

triple x = x * 3
-- triple' x = x + x + x

succ x = x + 1
-- succ' = (\x -> x + 1)

sumarDos x = x + 2
-- sumarDos = (\x -> x + 2)

------------------------------------------

-- twice f = (\x -> f (f x))
-- twice = (\f -> (\x -> (f (f x))))

twice f = g
	where g x = f (f x)

-- ​twice succ ​=​ sumarDos

-- twice succ 2 = sumarDos 2


-- sumarDos 2
-- = -- def sumarDos
-- 2 + 2
-- = -- arit.
-- 4

-- (twice succ) 2
-- = -- def twice, f = succ
-- g 2
-- = -- def g, x = 2
-- succ (succ 2)
-- = -- def succ
-- succ (2 + 1)
-- = -- def succ
-- (2 + 1) + 1
-- = -- arit.
-- 4

------------------------------------------


-- cuadruple = twice doble
-- doble = twice succ
-- doble = (\x -> 2 * x)
-- (\x -> x + x) = (\x -> 2 * x)
-- (\x -> doble x) = twice succ

-------------------------------------------


twice f = g
	where g x = f (f x)

-- ((twice twice) doble) 3​
-- = -- def twice, f = twice
-- (g doble) 3
-- = -- def g, x = doble
-- (twice (twice doble)) 3
-- = -- def twice, f = twice doble
-- g 3
-- = -- def g, x = 3
-- twice doble (twice doble 3)
-- = -- def twice, f = doble
-- g (twice doble 3)
-- = -- def g, x = twice doble 3
-- doble (doble (twice doble 3))
-- = -- def twice, f = doble
-- doble (doble (g 3))
-- = -- def g, x = 3
-- doble (doble (doble (doble 3)))
-- = -- def doble
-- doble (doble (doble (3 + 3)))
-- = -- arit.
-- doble (doble (doble 6))
-- = -- def doble
-- doble (doble (6 + 6))
-- = -- arit.
-- doble (doble 12)
-- = -- def doble
-- doble (12 + 12)
-- = -- arit.
-- doble 24
-- = -- def doble
-- 24 + 24
-- = -- arit.
-- 48

----------------------------------------------

-- triple = \x -> x * 3

-- sumarDos = \x -> x + 2

-- twice = (\f -> (\x -> f (f x)))

-- twice twice = (\f -> (\x -> (f (f (f (f x))))))

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