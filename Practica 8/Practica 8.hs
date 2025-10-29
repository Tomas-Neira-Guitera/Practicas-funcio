-- Seccion 1:

length :: [a] -> Int
length    []      = 0
length    (x : xs) = 1 + length xs 

sum :: [Int] -> Int
sum    []       = 0
sum    (n : ns) = n + sum ns 

product :: [Int] -> Int
product    []       = 1
product    (n : ns) = n * product ns 

concat :: [[a]] -> [a]
concat    []         = []
concat    (ls : lss) = ls ++ concat lss 

elem :: Eq a => a -> [a] -> Bool
elem            x    []       = False
elem            x    (y : ys) = x == y || elem x ys

all :: (a -> Bool) -> [a] -> Bool
all    f              []       = True    
all    f              (x : xs) = f x && all f xs 

any :: (a -> Bool) -> [a] -> Bool
any    f              []       = False    
any    f              (x : xs) = f x || any f xs 

count :: (a -> Bool) -> [a] -> Int
count    f              []       = 0    
count    f              (x : xs) = if f x 
                                    then 1 + count f xs 
                                    else count f xs 

subset :: Eq a => [a] -> [a] -> Bool
subset            []       ys = True
subset            (x : xs) ys = elem x ys && subset xs ys 

(++) :: [a] -> [a] -> [a]
(++)    []       ys = ys 
(++)    (x : xs) ys = x : (++) xs ys 

reverse :: [a] -> [a]
reverse    []       = []
reverse    (x : xs) = reverse xs ++ [x]

zip :: [a] -> [b] -> [(a,b)]
zip    []     []         = []
zip    []     ys         = []
zip    xs     []         = []
zip    (x : xs) (y : ys) = (x , y) : zip xs ys 

unzip :: [(a,b)] -> ([a],[b])
unzip    []             = ([], [])
unzip    ((x, y) : xys) = addTupla (x, y) (unzip xys)

addTupla :: (a, b) -> ([a], [b]) -> ([a], [b])
addTupla    (x, y)    (xs, ys)   = (x : xs, y : ys)

----------------------------------------------------------------------------------------------------------
-- Ejercicio 2: Desmostaciones:

por pp de extencionalidad para todo xs. para todo ys.
length (xs ++ ys) = length xs + length ys

voy a demostrar por induccion sobre xs.

para todo ys.
length (xs ++ ys) = length xs + length ys

Caso base xs = []                                       -- 1) Se deben demostrar para todos lo casos de la est recursiva.
length ([] ++ ys) = length [] + length ys               --    arranco por el/los caso/regla base.

-- lado izq:
length ([] ++ ys)
       ----------
                    por def de (++). con xs <- [], ys <- ys 
= length ys  

-- lado der:
length [] + length ys
---------
                    por def length. con xs <- []
= 0 + length ys
                    por aritmetica.
= length ys 

Caso inductivo xs = (z : zs)                            -- 2) Se debe desmostrar por el/los casos inductivos.
                                                        --    Se plantea la hipotesis que es la propiedad.
HI) para todo ys.
length (zs ++ ys) = length zs + length ys

TI) para todo ys.
length ((z : zs) ++ ys) = length (z : zs) + length ys

-- lado izq:
length ((z : zs) ++ ys)
        ---------------
                        por def de (++). con xs <- (z : zs), ys <- ys
= length (z : (++) zs ys )
                        por def de length. con xs <- (z : (++) zs ys )
= 1 + length ((++) zs ys)
      -------------------
                        uso la hipotesis inductiva me permite remplazar un lado x el otro de la hipotesis.
= 1 + length zs + length ys                   

-- lado der: 
length (z : zs) + length ys
---------------
                            por def de length. con xs <- (z : zs)
1 + length zs + length ys 
                  
-- las expresiones de los dos lados son iguales. QED.

----------------------------------------------------------------------------------------------------------
count (const True) = length

por pp de extencionalidad. para todo xs :: [a].
count (const True) xs = length xs 

voy a demostrar por induccion sobre xs.

Caso base: xs = []
count (const True) [] = length []

-- lado izq:
count (const True) [] 
----------------------
                        def count. con f <- const True, xs <- []
0

-- lado der:
length []
---------
            def length. con xs <- []
0 

Caso inductivo: xs = (z : zs)

Hipotesis Inductiva) count (const True) zs = length zs 
Tesis Inductiva) count (const True) (z : zs) = length (z : zs) 

-- lado izq:
count (const True) (z : zs)
----------------------------
                            def de count. con f <- const True, xs <- (z : zs)
= if (const True)  z 
   --------------- 
    then 1 + count (const True) zs 
    else count (const True) zs
                                def de const True. y <- z 
= if True 
    then 1 + count (const True) zs 
    else count (const True) zs

= 1 + count (const True) zs
                            por uso de la hipotesis inductiva.
= 1 + length zs

-- lado der: 
length (z : zs)  
                def length. xs <- (z : zs)
= 1 + length zs

-- las expresiones de los dos lados son iguales.

----------------------------------------------------------------------------------------------------------
elem = any . (==)

por ppio de extencionalidad. para todo x :: a, para todo xs :: [a]
elem x xs = any . (==) x xs 

voy a demostrar por induccion en xs.

Caso base: xs = []
elem x [] = any . (==) x [] 

-- lado izq:
elem x []
---------
            def de elem. x <- x, xs <- []
False

-- lado der:
any . (==) x []
------------
                def de (.). f <- any, g <- (==), x <- x
any ((==) x) []
---------------
                def any. f <- (==) x, xs <- []
False

Caso inducctivo: xs = (z : zs)

HI) elem x zs = any . (==) x zs 
TI) elem x (z : zs) = any . (==) x (z : zs)                 -- A PARTIR DE LA TESIS PLANTEO LA DEMOSTRACIÓN.
                                                            -- USO LA HI PARA DEMOSTRAR.

-- lado izq:
elem x (z : zs)
----------------
                def de elem. x <- x, xs <- (z : zs)
= x == z || elem x zs


-- lado der:
any . (==) x (z : zs)
------------
                        def de (.). f <- any, g <- (==), x <- x
= any ((==) x) (z : zs)
----------------------
                        def any. f <- (==) x, xs <- (z : zs)
= ((==) x) z || any ((==) x) zs 

= ((==) x) z || any . (==) x zs
  ----------
                        def (==). x <- x, y <- z
= x == z || any . (==) x zs
            --------------- 
                            por uso de la HI.
= x == z || elem x zs

-- las expresiones de los dos lados son iguales. QED.

----------------------------------------------------------------------------------------------------------
para todo x. any (elem x) = elem x . concat
por pp de extencionalidad para todo xs. any (elem x) xs = elem x . concat xs
por def de . :
any (elem x) xs = elem x (concat xs)

voy a desmostrarpor induccion estructural sobre xs.

Caso base: xs = []
any (elem x) [] = elem x . concat []

-- lado izq:
any (elem x) []
---------------
                def any.
False


-- lado der:
elem x (concat [])
        ---------
                    def concat.
elem x []
                    def elem.
False

Caso inductivo: xs = (z : zs)

HI) any (elem x) zs = elem x (concat zs)
TI) any (elem x) (z : zs) = elem x (concat (z : zs))

-- lado izq:
any (elem x) (z : zs)
----------------------
                        def any.
= (elem x) z || any (elem x) zs
                --------------- 
                                por HI 
= (elem x) z || elem x (concat zs)                          
------------------------------------ COMO NO SE PUEDE AVANZAR MÁS SE DEBE HACER UN LEMA.
                                por el lema elem-append
= elem x (z ++ (concat zs))
                            -- SON EQUIVALENTES.

-- lado der:
elem x (concat (z : zs))
        ---------------
                        def concat
= elem x (z ++ concat zs)
-------------------------- NO SE PUEDE AVANZAR CON elem.

-- LEMA:
para todo x :: a. para todo xs :: [a]. para todo ys :: [a] : 
elem x (xs ++ ys) = elem x xs || elem x ys

voy a demostrar por induccion estructural sobre xs:

caso base: xs = []


-- lado izq:
elem x ([] ++ ys)
        ---------
                    def (++)
elem x ys 

-- lado der:
elem x [] || elem x ys
---------
                        def elem
False || elem x ys
                        False neutro de ||
elem x ys

Caso inducctivo xs = (z : zs)

HI) elem x (zs ++ ys) = elem x zs || elem x ys
TI) elem x ((z : zs) ++ ys) = elem x (z : zs) || elem x ys

-- lado izq:
elem x ((z : zs) ++ ys)
        ---------------
                        def (++)
= elem x (z : zs ++ ys)
                        def elem            -- como me quedo la z : la puedo comparar.
= x == z || elem x (zs ++ ys)

-- lado der:
elem x (z : zs) || elem x ys
---------------
                        def elem
= x == z || elem x zs || elem x ys
          ----------------------
                        por uso de la HI.
= x == z || elem x (zs ++ ys)

-- las expresiones de los dos lados son iguales. QED.           EL LEMA ES VERDADERO. lema elem-append

-----------------------------------------------------------------------------------------------------------------------
para todo xs. para todo ys.
 reverse (xs ++ ys) = reverse ys ++ reverse xs

demostracion por induccion estructural sobre xs.

caso base: xs = []
para todo ys.
reverse ([] ++ ys) = reverse ys ++ reverse []

-- lado izq:
reverse ([] ++ ys)
        ----------
                    def (++)
reverse ys

-- lado der:
reverse ys ++ reverse []
              ----------
                    def reverse
reverse ys ++ []
----------------
                  hay que hacer un LEMA xq por la def de ++ no sale.
                  por uso de LEMA append-null.
reverse ys
--------------------------------- SON EQUIVALENTES.


para todo xs :: [a].
    xs ++ [] = xs 

por induccion estructural sobre xs.

caso base: xs = []
[] ++ [] = []

-- lado izq:
[] ++ []
        def ++
[]

-- lado der:
[]


caso inducctivo: xs = (z : zs)
HI) zs ++ [] = zs 
TI) (z : zs) ++ [] = (z : zs) 

-- lado izq:
(z : zs) ++ []
---------------
                def (++)
z : zs ++ []
    --------
            por uso de la HI 
z : zs

-- lado der:
z : zs

-- SON EQUIVALENTES. lema append-null
------------------------------------------------------------

PASOS PARA REALIZAR UNA DEMOSTRACIÓN INDUCTIVA:
- POR PPIO DE EXTENCIONALIDAD HAY QUE COMPLETAR LAS EXPRESIONES.
- HAY QUE ACLARAR QUE SE VA A USAR INDUCCION ESTRUCTURAL Y SOBRE QUE ESTRUCTURA.
- SE DEBE COMENZAR CON EL CASO BASE DE LA ESTRUCTURA RECURSIVA.
- EN CADA PASO DE LA DEMOSTRACION HAY QUE USAR UN "=" DEL LADO IZQ DE LA EXPRESION.
- DESPUES DE DEMOSTRAR EL CASO BASE HAY QUE DEMOSTRAR EL RECURSIVO.
- SE DEBE PLANTEAR LA HIPOSTESIS Y LA TESIS.
- EN LA HIPOSTESIS SE PLANTEA CON LA PARTE INDUCTIVA SIN EN EL ELEMENTO ACTUAL. XS 
- EN LA TESIS SE PLANTEA CON EL ELEMENTO ACTUAL. X:XS 
- SE COMIENZA A DEMOSTRAR DESDE LA TESIS.
- CUANDO NO SE PUEDE AVANZAR MÁS SE DEBE CREAR UN LEMA.
- CUANDO SE LLEGA A LA HIPOTESIS HAY QUE REMPLAZARLA PARA PODER COMPLETAR LA IGUALDAD.
- SI HAY MAS DE UNA PARTE RECURSIVA DEBE HABER UNA HI Y TI POR CADA CASO RESCURSIVO.


