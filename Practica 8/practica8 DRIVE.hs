
null [] = True
null (x:xs) = False

f [] = ...
f (x:xs) = ... f xs ...

length :: [a] -> Int
length [] = 0
length (x:xs) = 1 + length xs

sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs

product :: [Int] -> Int
product [] = 1
product (x:xs) = x * product xs

concat :: [[a]] -> [a]​
concat [] = []
concat (x:xs) = x ++ concat xs

elem :: Eq a => a -> [a] -> Bool
elem e [] = False
elem e (x:xs) = e == x || elem e xs

all :: (a -> Bool) -> [a] -> Bool
all p [] = True
all p (x:xs) = p x && all p xs

any :: (a -> Bool) -> [a] -> Boo
any p [] = False
any p (x:xs) = p x || any p xs

count :: (a -> Bool) -> [a] -> Int
count p [] = 0
count p (x:xs) = 
	if p x 
	   then 1 + count p xs
	   else count p xs

count' :: (a -> Bool) -> [a] -> Int
count' p [] = 0
count' p (x:xs) = contarSi p x + count' p xs

contarSi p x = if p x then 1 else 0

subset :: Eq a => [a] -> [a] -> Bool
subset [] ys = True
subset (x:xs) ys = elem x ys && subset xs ys

(++) :: [a] -> [a] -> [a]
(++) [] ys = ys
(++) (x:xs) ys = x : (++) xs ys

reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

zip :: [a] -> [b] -> [(a,b)]
zip []     []     = []
zip []     (x:xs) = []
zip (y:ys) []     = []
zip (y:ys) (x:xs) = (y,x) : zip ys xs

unzip :: [(a,b)] -> ([a],[b])
unzip []     = ([],[])
unzip (x:xs) = agregarComponentes x (unzip xs)

agregarComponentes :: (a,b) -> ([a],[b]) -> ([a],[b])
agregarComponentes (x,y) (xs,ys) = (x:xs, y:ys)

unzip' :: [(a,b)] -> ([a],[b])
unzip' []     = ([],[])
unzip' ((x,y):xs) = 
	case unzip' xs of
		(ys,zs) -> (x:ys, y:zs)

-----------------------------------------

para todo xs, para todo ys.
length (​xs​ ++ ​ys​) ​=​ length ​xs​ + length ​ys

voy a demostrar por inducción sobre xs

para todo ys.
length (​xs​ ++ ​ys​) ​=​ length ​xs​ + length ​ys

Caso base xs = []

lo que tengo que demostrar: length ([] ++ ​ys​) ​=​ length [] + length ​ys

-- lado izq
length ([] ++ ​ys​) 
= -- rescribo la expresión con ++ de forma prefija
length ((++) [] ​ys​) 
= -- def ++
length ys

-- lado der
length [] + length ​ys
= -- def length
0 + length ys
= -- neutro 0 con respecto a la suma
length ys

--------------------------

Caso inductivo xs = (z:zs)

HI) para todo ys.
length (zs ++ ​ys​) ​=​ length zs + length ​ys

TI) para todo ys.
length ((z:zs) ++ ​ys​) ​=​ length (z:zs) + length ​ys


-- lado izq
length ((z:zs) ++ ​ys​)
= -- def ++
length (z : zs ++ ys)
= -- def length
1 + length (zs ++ ys)
= -- HI)
1 + length zs + length ​ys

-- lado der
length (z:zs) + length ​ys
= -- def length
1 + length zs + length ys

----------------------------------------------------

count (const True) ​=​ length

ppio de ext

para todo xs.
count (const True) xs ​=​ length xs

Voy a demostrar por induccion sobre xs

Caso base xs = []

-- lado izq
count (const True) []
= -- def count
0

-- lado der
length []
= -- def length
0

Caso inductivo xs = (z:zs)

HI) count (const True) zs ​=​ length zs
TI) count (const True) (z:zs) ​=​ length (z:zs)

-- lado izq
count (const True) (z:zs) 
= -- def count
if const True z
   then 1 + count (const True) zs
   else count (const True) zs
= -- def const
if True 
   then 1 + count (const True) zs
   else count (const True) zs
= -- def if-then-else
1 + count (const True) zs
= -- HI)
1 + length zs

-- lado der
length (z:zs)
= -- def length
1 + length zs

---------------------------------------------------------

elem ​= ​any . (==)

ppio de ext

para todo e .
elem ​e = ​(any . (==)) e

por definición de .

para todo e.
elem ​e = ​any ((==) e)

ppio de ext

para todo xs, para todo e.
elem ​e xs = ​any ((==) e) xs

Demostración por inducción sobre xs


Caso base xs = []

elem ​e []
= -- def elem
False

any ((==) e) []
= -- def any
False

Caso inductivo xs = (z:zs)

HI) elem ​e zs = ​any ((==) e) zs
TI) elem ​e (z:zs) = ​any ((==) e) (z:zs)

-- lado izq
elem ​e (z:zs)
= -- def elem
e == z || elem e zs
= -- HI)
e == z || any ((==) e) zs

-- lado der
any ((==) e) (z:zs)
= -- def any
(==) e z || any ((==) e) zs
= -- coloco el (==) como funcion prefija
e == z || any ((==) e) zs

----------------------------------------------------

para todo xs.
any (elem ​x​) xs ​=​ elem ​x​ (concat xs)


Dem. por ind. sobre xs

Caso base xs = []

trivial

Caso inductivo xs = (z:zs)

HI) any (elem ​x​) zs ​=​ elem ​x​ (concat zs)
TI) any (elem ​x​) (z:zs) ​=​ elem ​x​ (concat (z:zs))

any (elem ​x​) (z:zs)
= -- def any
elem x z || any (elem x) zs
= -- HI)
elem x z || elem ​x​ (concat zs)

elem ​x​ (concat (z:zs))
= -- def elem
elem x (z ++ concat zs)
= -- por lema elem-append

  -- por lema
	  -- para todo x, para todo xs, para todo ys
	  -- elem x (xs ++ ys) = elem x xs || elem x ys
	  -- donde xs = z, ys = concat zs
elem x z || elem x (concat zs)

-------------------------------

-- lema elem-append

para todo x, para todo xs, para todo ys
elem x (xs ++ ys) = elem x xs || elem x ys

dem. por ind. sobre xs

Caso base xs = []

Quiero demostrar:
para todo x, para todo ys
elem x ([] ++ ys) = elem x [] || elem x ys

elem x ([] ++ ys)
= -- def ++
elem x ys

elem x [] || elem x ys
= -- def elem
False || elem x ys
= -- False neutro ||
elem x ys

Caso inductivo xs = (z:zs)

HI) para todo x, para todo ys
elem x (zs ++ ys) = elem x zs || elem x ys

TI) para todo x, para todo ys
elem x ((z:zs) ++ ys) = elem x (z:zs) || elem x ys

elem x ((z:zs) ++ ys)
= -- def ++
elem x (z : zs ++ ys)
= -- def elem
x == z || elem x (zs ++ ys)
= -- HI)
x == z || elem x zs || elem x ys

elem x (z:zs) || elem x ys
= -- def elem
x == z || elem x zs || elem x ys

---------------------------------------------

para todo ​xs​. para todo ​ys​.
​reverse (​xs​ ++ ​ys​) ​=​ reverse ​ys​ ++ reverse ​xs

Dem. por ind. xs

Caso base xs = []

reverse ([] ++ ​ys​)
= -- def ++
reverse ys

reverse ​ys​ ++ reverse []
= -- def reverse
reverse ys ++ []
= -- lema []-neutro-derecha-append
reverse ys


Caso ind xs = (z:zs)

HI) para todo ys.
reverse (zs ++ ​ys​) ​=​ reverse ​ys​ ++ reverse zs 

TI) para todo ys.
reverse ((z:zs) ++ ​ys​) ​=​ reverse ​ys​ ++ reverse (z:zs)

reverse ((z:zs) ++ ​ys​)
= -- def ++
reverse (z : zs ++ ys)
= -- def reverse
reverse (zs ++ ys) ++ [z]
= -- HI)
reverse ys ++ reverse zs ++ [z]

reverse ​ys​ ++ reverse (z:zs)
= -- def reverse
reverse ys ++ reverse zs ++ [z]

------------------------------------

-- lema []-neutro-derecha-append

para todo ys.
reverse ys ++ [] = reverse ys

Dem. por ind. sobre ys

Caso base ys = []

reverse [] ++ []
= -- def reverse
[] ++ []
= -- def ++
[]

reverse []
= -- def reverse
[]

Caso ind. ys = (z:zs)

HI) reverse zs ++ [] = reverse zs
TI) reverse (z:zs) ++ [] = reverse (z:zs)

reverse (z:zs) ++ []
= -- def reverse
reverse zs ++ [z] ++ []
= -- ++ asociativo
reverse zs ++ ([z] ++ [])
= -- def ++
reverse zs ++ (z : [] ++ [])
= -- def ++
reverse zs ++ (z : [])
= -- reescribo (z : []) = [z]
reverse zs ++ [z]


reverse (z:zs)
= -- def reverse
reverse zs ++ [z]


-- Tarea:
-- propiedad asoc. ++
-- xs ++ (ys ++ zs) = (xs ++ ys) ++ zs

-----------------------------------------

data N = Z | S N

f Z = ...
f (S n) = ... f n

evalN :: N -> Int
evalN Z = 0
evalN (S n) = 1 + evalN n

int2N :: Int -> N
int2N 0 = Z
int2N n = S (int2N (n-1))

addN :: N -> N -> N​
addN Z m = m
addN (S n) m = S (addN n m)

prodN :: N -> N -> N​
prodN Z m = Z
prodN (S n) m = addN m (prodN n m)

-- 3 * 4

-- 4 + (2 * 4)
-- 4 + 4 + (1 * 4)
-- 4 + 4 + 4 + (0 * 4)
-- 4 + 4 + 4 + 0
-- 4 + 4 + 4

-----------------------------------

-- propiedad evalN-addN-+

para todo n1, para todo n2.
evalN (addN ​n1​ ​n2​) ​=​ evalN ​n1​ + evalN ​n2

Dem. por ind. sobre n1

Caso base n1 = Z

para todo n2.
evalN (addN Z ​n2​)
= -- def addN
evalN n2

para todo n2.
evalN Z + evalN ​n2
= -- def evalN
0 + evalN n2
= -- def evalN
evalN n2

Caso ind. n1 = S n

HI)
para todo n2.
​evalN (prodN n ​n2​) ​=​ evalN n * evalN ​n2

TI)
para todo n2.
​evalN (prodN (S n) ​n2​) ​=​ evalN (S n) * evalN ​n2

evalN (prodN (S n) ​n2​)
= -- def prodN
evalN (addN n2 (prodN n n2))
= -- por demostración en ejercicio b.i.
evalN n2 + evalN (prodN n n2)

evalN (S n) * evalN ​n2
= -- def evalN
(1 + evalN n) * evalN n2
= -- def dist. *
evalN n2 + evalN n * evalN n2
= -- HI)
evalN n2 + evalN (prodN n ​n2​)

---------------------------------------------------

-- Consejos para NBin

-- Respetar a rajatabla el esquema de recursión sobre NBin
-- Cuando hay que combinar un elemento con el resultado de la recursión y no existe una tarea que haga eso todavía, hacer una subtarea
-- Si hay que recorrer uno de los parámetros, preferir recorrer el primero

-- -- ahora
-- 2^0  2^1   2^2
-- 1    0     0
-- =
-- 1

-- -- orga
-- 2^2  2^1  2^0
-- 1    0    0
-- =
-- 4

-- -- ahora
-- 2^0  2^1   2^2
-- 0    0     1
-- =
-- 4

---------------------------------------------

-- Sección I, 2f

all null ​=​ null . concat

-- ppio de ext

-- para todo xs
all null xs ​=​ (null . concat) xs

-- que es equivalente a, por definición de (.)

-- para todo xs
all null xs ​=​ null (concat xs)

-- voy a demostrar por inducción sobre xs

Caso base xs = []

-- lado izq
all null []
= -- def all
True

-- lado der
null (concat [])
= -- def concat
null []
= -- def null
True


Caso ind. xs = (z:zs)

HI) all null zs ​=​ null (concat zs)
TI) ¿ all null (z:zs) ​=​ null (concat (z:zs)) ?

-- lado izq
all null (z:zs)
= -- def all
null z && all null zs
= -- HI
null z && null (concat zs)

-- lado der
null (concat (z:zs))
= -- def concat
null (z ++ concat zs)
= -- por lema null-++-&&
null z && null (concat zs)

-----------------------

-- lema null-++-&&

-- para todo xs
-- para todo ys
null xs && null ys = null (xs ++ ys)

-- voy a dem. por casos sobre xs

Caso xs = []

null [] && null ys
=
True && null ys
=
null ys

null ([] ++ ys)
=
null ys

Caso xs = (z:zs)

null (z:zs) && null ys
= -- def null
False && null ys
= -- def &&
False

null ((z:zs) ++ ys)
= -- def ++
null (z : (zs ++ ys))
= -- def null
False

----------------------------------

-- para todo xs
-- para todo ys
​unzip (zip ​xs​ ​ys​) ​=​ (​xs​, ​ys​)

Elijo

xs = [1,2,3]
ys = [4,5,6,7]

unzip (zip [1,2,3] [4,5,6,7])
=
([1,2,3],[4,5,6])

que no es equivalente a

([1,2,3], [4,5,6,7])

por lo tanto la propiedad no se cumple para todo xs e ys

-----------------------------------------------


