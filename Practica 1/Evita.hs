doble x = x + x
cuadruple x = 4 * x
succ x = x + 1

twice f = g
  where g x = f (f x)

-- Escribir de 8 expresiones que denoten 4
-- 1. Al menos seis deben usar funciones
-- 2. Al menos dos deben usar una expresión lambda
-- 3. Tres deben usar ​doble
-- 4.  una debe usar ​cuadruple​.

-- 1

cuatro_1 = (\x -> x) 4
cuatro_2 = (\x -> (\y -> x + y)) 2 2
cuatro_3 = (\x -> 4) 10
cuatro_4 = (\f -> f 2) doble
cuatro_5 = (\f -> f (f 2)) succ
cuatro_6 = twice doble 1
cuatro_7 = doble (doble 1)
cuatro_8 = cuadruple 1
cuatro_9 = (\x -> cuadruple 2 - x) (doble 2)
cuatro_10 = cuadruple (succ 0)
cuatro_11 = (\f -> f 1) cuadruple

-- ¿ (\x -> (\y -> x + y)) 2 2 = 4 ?

-- (\x -> (\y -> x + y)) 2 2
-- = -- beta reducción (x = 2)
-- (\y -> 2 + y) 2
-- = -- beta reducción (y = 2)
-- 2 + 2
-- = -- aritmética
-- 4

twice_2 f = (\x -> f (f x))

-- ¿twice_2 doble 1 = 4?

-----------------
--|             |
   twice_2 doble  1
= -- def twice (f = doble)
(\x -> doble (doble x)) 1
= -- beta reducción (x = 1)
doble (doble 1)
= -- def doble (x = 1)
doble (1 + 1)

-- Opcion 1
= -- aritmetica
doble 2
= -- def doble (x = 2)
2 + 2
= -- aritmetica
4

-- Opcion 2
= -- def doble (x = 1 + 1)
(1 + 1) + (1 + 1)
= -- aritmetica
4

-----------------------------

-- Ejercicio 2

doble (doble 2)

-- Opcion 1
= -- def doble (x = 2)
doble (2 + 2)
= -- def doble (x = 2 + 2)
(2 + 2) + (2 + 2)

-- Opcion 2
= -- def doble (x = doble 2)
doble 2 + doble 2
= -- def doble (x = 2)
(2 + 2) + doble 2
= -- def doble (x = 2)
(2 + 2) + (2 + 2)

-----------------------------

-- Ejercicio 3

cuadruple x = 4 * x

cuadruple 2
= -- def cuadruple (x = 2)
4 * 2
=
8

cuadruple (cuadruple 2)

-- Opcion 1
= -- def cuadruple (x = 2)
cuadruple (4 * 2)
= -- def cuadruple (x = 4 * 2)
4 * (4 * 2)

-- Opcion 2
= -- def cuadruple (x = cuadruple 2)
4 * (cuadruple 2)
= -- def cuadruple (x = 2)
4 * (4 * 2)

-----------------------------

-- Ejercicio 4

​triple​ x = 3 * x
succ​ x = x + 1 
​sumarDos​ x = x + 2

-- Comprobar = mostrar un ejemplo
-- ¿ twice succ ​=​ sumarDos ?

¿ twice succ ​10 =​ sumarDos 10 ?

-- Reduzco
twice succ ​10

twice f = g
  where g x = f (f x)

= -- def twice (f = succ)
g 10
= -- def g (x = 10)
succ (succ 10)
= -- def succ (x = 10)
succ (10 + 1)
= -- def succ (x = 10 + 1)
10 + 1 + 1
= -- aritmetica
12

-- Reduzco
twice_2 succ ​10

twice_2 f = (\x -> f (f x))

= -- def twice_2 (f = succ)
(\x -> succ (succ x)) 10
= -- beta reduccion (x = 10)
succ (succ 10)
= -- ya demostrado anteriormente
12

-- Reduzco
sumarDos 10

= -- def sumarDos (x = 10)
10 + 2
=
12

-------------------------------

-- 1
cuadruple, (\x -> 4 * x​)

-- 2
twice succ, sumarDos

-- 3
twice_2 cuadruple, (twice_2 twice_2) doble

twice_2 f = (\x -> f (f x))

-----------------------------
twice_2 cuadruple
= -- def twice_2 (f = cuadruple)
(\x -> cuadruple (cuadruple x))
------------------------------

(twice_2 twice_2) doble
= -- def twice_2 (f = twice_2)
(\x -> twice_2 (twice_2 x)) doble
= -- beta reducción (x = doble)
twice_2 (twice_2 doble)
= -- def twice_2 (f = twice_2 doble)
(\x -> (twice_2 doble) ((twice_2 doble) x))

-- No son equivalentes por reducción
devuelvo4_1 x = 2 + 2
devuelvo4_2 x = 4

-- No son equivalentes por reducción
(\x -> 2 + 2)
(\x -> 4)

-- 4
(\x -> 2 + 2), (\x -> 4)

-- 5
devuelvo4_1, devuelvo4_2

------------------------------------

-- Ejercicio 8

triple = (\x -> x * 3)
succ = (\x -> x + 1)
sumarDos = (\x -> x + 2)
twice = (\f -> (\x -> f (f x)))
twice twice =
	(\f -> (\x -> f (f (f (f x)))))
twice twice twice =
	-- aplica 8 veces f
twice twice twice twice =
	-- aplica 16 veces f

-- ejemplo de expansión
twice twice doble 2
twice doble (twice doble 2)
doble (doble (doble (doble 2)))
-------------------------------

---------------
if-then-else​

if b
  then x
  else y

Si b = True
entonces x
sino y

case b of
	True  -> x
	False -> y

Analiza casos
---------------

where​

dos = x
  where x = 2

tres = f 1
   where f x = x + 2

cuatro = x
   where x = y + y
         y = 2

let

dos = let x = 2
          in x

tres = let f x = x + 2
           in f 1

cuatro = let x = y + y
             y = 2
             in x

cuatro = let y = 2
             in let x = y + y
                    in x
​
cinco = let y = 2
            x = 3
            in x + y

-----------------------------

f x = let (y,z) = (x,x) in y
->
f x = x

f (x,y) = let z = x + y 
              in g (z,y)
        where g (a,b) = a - b

->

f (x,y) = g (x + y, y)
        where g (a,b) = a - b

->

f (x, y) = x

--------------------------------

f p = case p of (x,y) -> x

f p = fst p

f p = (\(x,y) -> x) p

f (x, y) = x

---------------------------------

f = (\p -> let (x,y) = p in y)

f = (\p -> snd p)

f = (\p -> (\(x,y) -> y) p)

---------------------------------

-- Ejercicio 7

twice f = g
  where g x = f (f x)

-- twice   f
  ------------
((twice twice) doble) 3
= -- def twice (f = twice)
(g doble) 3
= -- def g (x = doble)
(twice (twice doble)) 3
= -- def twice (f' = doble)
(twice g') 3
= -- def twice (f'' = g')
g'' 3
= -- def g'' (x = 3)
g' (g' 3)
=
g' (doble (doble 3))
=
(doble (doble (doble (doble 3))))

----------------------------------

twice_2 f = (\x -> f (f x))

((twice_2 twice_2) doble) 3
= -- def twice_2 (f = twice_2)
((\x -> twice_2 (twice_2 x)) doble) 3
= -- beta reducción (x = doble)
(twice_2 (twice_2 doble)) 3
= -- def twice_2 (f = doble)
(twice_2 (\x -> doble (doble x))) 3
= -- def twice_2 (f = (\x -> doble (doble x)))
(\x ->
  (\x -> doble (doble x))
    ((\x -> doble (doble x)) x)) 3
= -- beta reducción (x = 3)
(\x -> doble (doble x))
  ((\x -> doble (doble x)) 3)
= -- beta reduccion (x = 3)
(\x -> doble (doble x))
  (doble (doble 3))
= -- beta reducción (x = (doble (doble 3))
doble (doble (doble (doble 3)))

--------------------------------------

compose = (\f -> (\g -> (\x -> f (g x))))

-- Un ejemplo de uso:
compose succ succ 2
= -- def compose
(\f -> (\g -> (\x -> f (g x)))) succ succ 2
= -- beta reduccion (f = succ)
(\g -> (\x -> succ (g x))) succ 2
= -- beta reduccion (g = succ)
(\x -> succ (succ x)) 2
= -- beta reduccion (x = 2)
succ (succ 2)
--------------------------------------

-- Tarea:
-- Usando compose dar expresiones equivalentes a:
-- a. cuadruple
-- b. twice
-- c. (\x -> x)
-- d. twice twice (desafío)