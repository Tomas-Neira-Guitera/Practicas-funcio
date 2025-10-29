data SetExp a = EmptyS
              | Singleton a
              | Union (SetExp a) (SetExp a)
              | Intersect (SetExp a) (SetExp a)
              | Diff (SetExp a) (SetExp a) -- resta
                -- [1,2,3] - [2,3] = [1]

evalSL :: SetExp a -> [a]
evalSL    EmptyS            = []
evalSL    (Singleton x)     = x : []
evalSL    (Union s2 s3)     = juntarSinRepetidos (evalSL s2) (evalSL s3) 
evalSL    (Intersect s2 s3) = juntarIguales (evalSL s2) (evalSL s3) 
evalSL    (Diff s2 s3)      = juntarDiferencia (evalSL s2) (evalSL s3) 

juntarSinRepetidos :: [a] -> [a] -> [a]
juntarSinRepetidos    []       ys = ys 
juntarSinRepetidos    xs       [] = xs 
juntarSinRepetidos    (x : xs) ys = if elem x ys 
                                        then juntarSinRepetidos xs ys 
                                        else x : juntarSinRepetidos xs ys  

evalSF :: SetExp a -> (a -> Bool)
evalSF    EmptyS            = (\y -> False)
evalSF    (Singleton x)     = (\y -> x == y)
evalSF    (Union s2 s3)     = (\y -> (evalSF s2) y || (evalSF s3) y) 
evalSF    (Intersect s2 s3) = (\y -> (evalSF s2) y && (evalSF s3) y)
evalSF    (Diff s2 s3)      = (\y -> (evalSF s2) y && !((evalSF s3) y))   

simpSE :: SetExp a -> SetExp a
simpSE    EmptyS            = EmptyS 
simpSE    (Singleton x)     = (Singleton x)
simpSE    (Union s2 s3)     = simpSEU (simpSE s2) (simpSE s3)
simpSE    (Intersect s2 s3) = simpSEI (simpSE s2) (simpSE s3)
simpSE    (Diff s2 s3)      = simpSED (simpSE s2) (simpSE s3)

simpSEU :: SetExp a -> SetExp a -> SetExp a 
simpSEU    EmptyS      s2       = s2
simpSEU    s1          EmptyS   = s1 
simpSEU    s1          s2       = Union s1 s2 

simpSEI :: SetExp a -> SetExp a -> SetExp a 
simpSEI    EmptyS      s2       = EmptyS
simpSEI    s1          EmptyS   = EmptyS
simpSEI    s1          s2       = Intersect s1 s2

simpSED :: SetExp a -> SetExp a -> SetExp a 
simpSED    EmptyS      s2       = EmptyS
simpSED    s1          EmptyS   = s1 
simpSED    s1          s2       = Diff s1 s2

toSetExp :: [a] -> (a -> Bool) -> SetExp a
toSetExp    []       f         = EmptyS
toSetExp    (x : xs) f         = if f x
                                    then Union (Singleton x) (toSetExp f xs)
                                    else toSetExp f xs

elem :: Eq a => a -> [a] -> Bool
elem            x    []       = False
elem            x    (y : ys) = x == y || elem x ys
----------------------------------------------------------------------------------------
-- DEMOSTRACIONES: 
Para todo e :: a , s :: SetExp a. 
    elem e (evalSL s) = (evalSF s) e

voy a demostrar por induccion estructural sobre s.

Caso base 1: s = EmptyS
para todo x :: a
Caso base 2: s = (Singleton x)

para todo s2, s3 :: SetExp a
Caso recursivo 1: s = (Union s2 s3)
HI11 elem y (evalSL s2) = (evalSF s2) y
HI12 elem y (evalSL s3) = (evalSF s3) y
TI1  elem y (evalSL (Union s2 s3)) = (evalSF (Union s2 s3)) y

para todo s2, s3 :: SetExp a
Caso recursivo 2: s = (Intersect s2 s3)

para todo s2, s3 :: SetExp a
Caso recursivo 3: s = (Diff s2 s3) 

Demostracion caso base 1: para todo x :: a,
 elem x (evalSL EmptyS) = (evalSF EmptyS) x

lado izq:
elem x (evalSL EmptyS)
        --------------
elem x []
---------
False

lado der: 
evalSF EmptyS x
-------------
(\y -> False) x 
---------------
False

-- CUMPLE ESTE CASO.
---------------------------------------------

Demostracion caso base 2: para todo y :: a,
 elem y (evalSL (Singleton x)) = (evalSF (Singleton x)) y

lado izq:
elem y (evalSL (Singleton x)
        --------------------
elem y (x : [])
---------------
x == y || elem y []
-------
False || elem y []
        ----------
False || False
--------------
False

lado der: 
(evalSF (Singleton x)) y
----------------------
(\y -> x == y) y 
----------------
x == y 
------
False

-- CUMPLE ESTE CASO.
---------------------------------------------
para todo s2, s3 :: SetExp a
Caso recursivo 1: s = (Union s2 s3)

Demostracion caso inductivo 1: para todo y :: a,
 elem y (evalSL (Union s2 s3)) = (evalSF (Union s2 s3)) y

lado izq:
elem y (evalSL (Union s2 s3))
        --------------------
elem y (juntarSinRepetidos (evalSL s2) (evalSL s3))
-----------------------------------------------------

lado der: 
(evalSF (Union s2 s3)) y
----------------------
(\y -> (evalSF s2) y || (evalSF s3) y) y
---------------------------------------- USO HI 11 Y 12.
elem y (evalSL s2) || elem y (evalSL s3)

LEMA: elem y (juntarSinRepetidos l2 l3) = elem y l2 || elem y l3

Demostración del lema:
para todo xs, ys :: [a], y :: a.
    elem y (juntarSinRepetidos xs ys) = elem y xs || elem y ys

voy a demostrar por induccion sobre xs:

Caso base: xs = []
elem y (juntarSinRepetidos [] ys) = elem y [] || elem y ys

Caso inductivo xs = (x : xs)
HI elem y (juntarSinRepetidos xs ys) = elem y xs || elem y ys
TI  elem y (juntarSinRepetidos (x : xs) ys) = elem y (x : xs) || elem y ys

Demostracion caso base:
    elem y (juntarSinRepetidos [] ys) = elem y [] || elem y ys

lado izq:
elem y (juntarSinRepetidos [] ys)
        ------------------------
elem y ys 

lado der:
elem y [] || elem y ys
---------
False || elem y ys 
------------------
elem y ys 

-- ESTE CASO VALE

Demostracion caso inductivo:
lado der:
elem y (juntarSinRepetidos (x : xs) zs)
        ------------------------------
elem y (if elem y zs 
            then juntarSinRepetidos xs zs 
            else z : juntarSinRepetidos xs zs )
-------------------------------------------------
if elem y zs 
    then elem y (juntarSinRepetidos xs zs)
    else elem y (z : juntarSinRepetidos xs zs)
    ------------------------------------------
if elem y zs 
    then elem y (juntarSinRepetidos xs zs)
    else y == z || elem y (juntarSinRepetidos xs zs)
    -----------
if elem y zs 
    then elem y (juntarSinRepetidos xs zs)
    else False || elem y (juntarSinRepetidos xs zs) ---- Se que es False pq entro al else evaluando elem y zs.
         -----------------------------------------
if elem y zs 
    then elem y (juntarSinRepetidos xs zs)
    else elem y (juntarSinRepetidos xs zs)

lado izq:
elem y (x : xs) || elem y zs
---------------
x == y || elem y xs || elem y zs
-------
False  || elem y xs || elem y zs
---------------------------------
elem y xs || elem y zs
---------------------- HI
elem y (juntarSinRepetidos xs zs)
