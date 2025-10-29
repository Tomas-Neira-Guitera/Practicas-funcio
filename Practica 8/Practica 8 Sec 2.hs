-- Seccion 2:
data N = Z | S N

evalN :: N -> Int 
evalN    Z     = 0
evalN    (S n) = 1 + evalN n 

addN :: N -> N -> N
addN    Z     n2 = n2 
addN    (S n) n2 = S (addN n n2)

prodN :: N -> N -> N
prodN    Z     n2 = Z 
prodN    (S n) n2 = addN n2 (prodN n n2) 

int2N :: Int -> N
int2N    0   = Z 
int2N    n   = S (int2N (n-1))

----------------------------------------------------------------------------------------------------------
-- DEMOSTRACIONES:
para todo n1. para todo n2.
    evalN (addN n1 n2) = evalN n1 + evalN n2

por induccion estructural sobre n1.

caso base: n1 = Z
para todo n2.
    evalN (addN Z n2) = evalN Z + evalN n2

-- lado izq:
evalN (addN Z n2)
      -----------
                    def de addN
evalN n2 

-- lado der:
evalN Z + evalN n2
-------
                def de evalN
0 + evalN n2 
                aritmetica
evalN n2

------------------------------------------------------------
caso inductivo: n1 = S n 
para todo n2 :: N.
    
HI) para todo n2 :: N.
    evalN (addN n n2) = evalN n + evalN n2                      -- En la hipotesis va la parte recursiva. "n"

TI) para todo n2 :: N.
    evalN (addN (S n) n2) = evalN (S n) + evalN n2              -- En la tesis va el caso inductivo completo. "S n"

-- lado izq:
evalN (addN (S n) n2)
      ---------------
                        def addN
= evalN (S (addN n n2))
  ---------------------
                        def evalN
= 1 + evalN (addN n n2)
      -----------------
                        por uso de la HI 
= 1 + evalN n + evalN n2


-- lado der:
evalN (S n) + evalN n2
-----------
                        def evalN
= 1 + evalN n + evalN n2



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO 2:

type NU = [()]

data Unit = Unit

evalNU :: NU -> Int
evalN     n  = size n 

succNU :: NU -> NU 
succNU    n  = () : n 

addNU :: NU -> NU -> NU 
addN     n     n2 = n ++ n2 

nu2n :: NU -> N
nu2n    n  = if 

n2nu :: N -> NU




