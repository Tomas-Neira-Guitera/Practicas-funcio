data DigBin = O | I deriving Show

type NBin = [DigBin]

-- f [] = ...
-- f (b:bs) = ... f bs ...

-- succNB :: NBin -> NBin
-- succNB [] = [I]
-- succNB (b:bs) = 
-- 	succB b bs

-- -- muy mala idea tener recursión mutua
-- succB O bs = I : bs
-- succB I bs = O : succNB bs

-- opcion 1: no está mal
-- succNB :: NBin -> NBin
-- succNB [] = [I]
-- succNB (b:bs) = 
-- 	case b of
-- 		O -> I : bs
-- 		I -> O : succNB bs

-- opcion 2: 
succNB :: NBin -> NBin
succNB [] = [I]
succNB (O:bs) = I : bs
succNB (I:bs) = O : succNB bs

-- este sería el planteo para una demostración sobre succNB
-- Caso base nb = []

-- Caso inductivo nb = (b:bs)

-- Subcaso b = O

-- no voy a usar esta HI porque en este caso succNB no es
-- recursiva
-- HI) ... succNB bs = ...
-- TI) ... succNB (O:bs) = ...

-- Subcaso b = I

-- HI) ... succNB bs = ...
-- TI) ... succNB (I:bs) = ...

addNB :: NBin -> NBin -> NBin
addNB []     [] = []
addNB (b:bs) [] = b:bs
addNB [] (b:bs) = b:bs
addNB (b1:bs1) (b2:bs2) = 
	addBS b1 b2 (addNB bs1 bs2)

addBS I I bs = O : succNB bs
addBS O O bs = O : bs
addBS O I bs = I : bs
addBS I O bs = I : bs

int2NB :: Int -> NBin
int2NB 0 = []
int2NB n = succNB (int2NB (n-1))

normalizarNB :: NBin -> NBin
normalizarNB []     = []
normalizarNB (b:bs) = 
	normB b (normalizarNB bs)

normB O [] = []
normB b bs = b : bs

evalNB :: NBin -> Int
evalNB []     = 0
evalNB (b:bs) = 
	addB b (2 * (evalNB bs))

addB O n = n
addB I n = 1 + n


-- para todo nb
evalNB (normalizarNB nb) ​=​ evalNB nb

-- voy a demostrar por induccion sobre nb

Caso base nb = []

-- trivial
evalNB (normalizarNB []) ​=​ evalNB []

Caso inductivo nb = (b:bs)

Subcaso b = O

HI) evalNB (normalizarNB bs) ​=​ evalNB bs
TI) ¿ evalNB (normalizarNB (O:bs)) ​=​ evalNB (O:bs) ?

evalNB (normalizarNB (O:bs))
= -- def normalizarNB
evalNB (normB O (normalizarNB bs))
= -- lema evalNB-normB-O
2 * evalNB (normalizarNB bs)

evalNB (O:bs)
= -- def evalNB
addB O (2 * (evalNB bs))
= -- HI
addB O (2 * (evalNB (normalizarNB bs)))
= -- def addB
2 * evalNB (normalizarNB bs)

-----------------------------------------

-- lema evalNB-normB-O

-- para todo nb
evalNB (normB O nb) = 2 * evalNB nb

Caso nb = []

evalNB (normB O []) 
= -- def normB
evalNB []
= -- def evalNB
0

2 * evalNB []
= -- def evalNB
2 * 0
= -- arit.
0

Caso nb = (b:bs)

evalNB (normB O (b:bs)) 
= -- def normB
evalNB (O : (b:bs))
= -- def evalNB
addB O (2 * (evalNB (b:bs)))
= -- def addB
2 * (evalNB (b:bs))

-------------------------------

Subcaso b = I

HI) evalNB (normalizarNB bs) ​=​ evalNB bs
TI) ¿ evalNB (normalizarNB (I:bs)) ​=​ evalNB (I:bs) ?

-- lado izq
evalNB (normalizarNB (I:bs))
= -- def normalizarNB
evalNB (normB I (normalizarNB bs))
= -- def normB
evalNB (I : normalizarNB bs)
= -- def evalNB
addB I (2 * (evalNB (normalizarNB bs)))

-- lado der
evalNB (I:bs)
= -- def evalNB
addB I (2 * (evalNB bs))
= -- HI
addB I (2 * (evalNB (normalizarNB bs)))

------------------------------------------------------

-- para todo n1, n2
evalNB (addNB ​n1​ ​n2​) ​=​ evalNB ​n1​ + evalNB ​n2

-- voy a demostrar por induccion sobre n1

Caso base n1 = []

Subcaso n2 = []

evalNB (addNB [] []) ​
=​ -- def addNB
evalNB []

evalNB [] + evalNB []
= -- def evalNB
0 + evalNB []
=
evalNB []

Subcaso n2 = (b2:bs2)

evalNB (addNB [] (b2:bs2)) ​
=​ -- def addNB
evalNB (b2:bs2)

evalNB [] + evalNB (b2:bs2)
= -- def evalNB
0 + evalNB (b2:bs2)
=
evalNB (b2:bs2)

----------------------------------------------------

Caso ind. n1 = (b1:bs1)

-- voy a hacer inducción sobre n2

Caso base n2 = []

HI) evalNB (addNB (b1:bs1) []) ​=​ evalNB (b1:bs1) + evalNB []
TI) ¿ evalNB (addNB (b1:bs1) []) ​=​ evalNB (b1:bs1) + evalNB [] ?

evalNB (addNB (b1:bs1) [])
= -- def addNB
evalNB (b1:bs1)

evalNB (b1:bs1) + evalNB []
= -- def evalNB
evalNB (b1:bs1) + 0
= -- arit.
evalNB (b1:bs1)

Caso ind. n2 = (b2:bs2)

Subsubcaso b1 = I
           b2 = I

HI) evalNB (addNB bs1 bs2) ​=​ evalNB bs1 + evalNB bs2
TI) ¿ evalNB (addNB (I:bs1) (I:bs2)) ​=​ evalNB (I:bs1) + evalNB (I:bs2) ?

evalNB (addNB (I:bs1) (I:bs2))
= -- def addNB
evalNB (addBS I I (addNB bs1 bs2))
= -- def addBS
evalNB (O : succNB (addNB bs1 bs2))
= -- def evalNB
addB O (2 * evalNB (succNB (addNB bs1 bs2)))
= -- def addB
2 * evalNB (succNB (addNB bs1 bs2))

evalNB (I:bs1) + evalNB (I:bs2)
= -- def evalNB
evalNB (I:bs1) + addB I (2 * evalNB bs2)
= -- def addB
evalNB (I:bs1) + 1 + 2 * evalNB bs2
= -- def evalNB
1 + 2 * evalNB bs1 + 1 + 2 * evalNB bs2
= -- factor comun 2
1 + 1 + 2 * (evalNB bs1 + evalNB bs2)
= -- HI)
1 + 1 + 2 * (evalNB (addNB bs1 bs2))
= -- arit.
2 + 2 * (evalNB (addNB bs1 bs2))
= -- factor comun 2
2 * (1 + (evalNB (addNB bs1 bs2))
= -- demostracion anterior que ni en pedo hicimos
2 * evalNB (succNB (addNB bs1 bs2))

Subsubcaso b1 = O
           b2 = O

HI) evalNB (addNB bs1 bs2) ​=​ evalNB bs1 + evalNB bs2
TI) ¿ evalNB (addNB (O:bs1) (O:bs2)) ​=​ evalNB (O:bs1) + evalNB (O:bs2) ?

evalNB (addNB (O:bs1) (O:bs2))
= -- def addNB
evalNB (addBS O O (addNB bs1 bs2))
= -- def addBS
evalNB (O : addNB bs1 bs2)
= -- def evalNB
addB O (2 * evalNB (addNB bs1 bs2))
= -- def addB
2 * evalNB (addNB bs1 bs2)
= -- HI)
2 * (evalNB bs1 + evalNB bs2)

evalNB (O:bs1) + evalNB (O:bs2)
=  -- def evalNB x 2
2 * (evalNB bs1 + evalNB bs2)

Subsubcaso b1 = O
           b2 = I

HI) evalNB (addNB bs1 bs2) ​=​ evalNB bs1 + evalNB bs2
TI) ¿ evalNB (addNB (O:bs1) (I:bs2)) ​=​ evalNB (O:bs1) + evalNB (I:bs2) ?

evalNB (addNB (O:bs1) (I:bs2))
= -- def addNB
evalNB (addBS O I (addNB bs1 bs2))
= -- def addBS
evalNB (I : (addNB bs1 bs2))
= -- def evalNB
addB I (2 * evalNB (addNB bs1 bs2))
= -- HI) 
addB I (2 * (evalNB bs1 + evalNB bs2))
= -- def addB
1 + 2 * (evalNB bs1 + evalNB bs2)

evalNB (O:bs1) + evalNB (I:bs2)
=  -- def evalNB x 2
addB O (2 * evalNB bs1) + addB I (2 * evalNB bs2)
= -- def addB
2 * evalNB bs1 + 1 + 2 * evalNB bs2
= -- factor comun 2, comn.
1 + 2 * (evalNB bs1 + evalNB bs2)


Subsubcaso b1 = I
           b2 = O

HI) evalNB (addNB bs1 bs2) ​=​ evalNB bs1 + evalNB bs2
TI) ¿ evalNB (addNB (I:bs1) (O:bs2)) ​=​ evalNB (I:bs1) + evalNB (O:bs2) ?

evalNB (addNB (I:bs1) (O:bs2))
= -- def addNB
evalNB (addBS I O (addNB bs1 bs2))
= -- def addBS
evalNB (I : (addNB bs1 bs2))
= -- def evalNB
addB I (2 * evalNB (addNB bs1 bs2))
= -- HI) 
addB I (2 * (evalNB bs1 + evalNB bs2))
= -- def addB
1 + 2 * (evalNB bs1 + evalNB bs2)

evalNB (I:bs1) + evalNB (O:bs2)
=  -- def evalNB x 2
addB I (2 * evalNB bs1) + addB O (2 * evalNB bs2)
= -- def addB
1 + 2 * evalNB bs1 + 2 * evalNB bs2
= -- factor comun 2
1 + 2 * (evalNB bs1 + evalNB bs2)













--  1*2^0  + 1*2^1
-- [I,       I]    = 3

--  1  + 2 * (0 + 2 *    (1 + 2 * 1))
-- [I,       O,      I,      I]           = 15


--  1*2^1  + 1*2^0
-- [I,       I]    = 3

data N = Z | S N

evalN :: N -> Int
evalN Z = 0
evalN (S n) = 1 + evalN n

int2N :: Int -> N
int2N 0 = Z
int2N n = S (int2N (n-1))

addN Z m = m
addN (S n) m = S (addN n m)

prodN Z m = Z
prodN (S n) m = addN m (prodN n m)

nb2n = undefined

n2nb = undefined
