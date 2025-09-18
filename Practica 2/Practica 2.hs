
first :: (a, b) -> a
first (x,y) = x

apply :: (a -> b) -> a -> b
apply f = g
    where g x = f x

twice :: (a -> a) -> a -> a
twice f = g
    where g x = f (f x)

doble :: n -> n
doble x = x + x

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

uflip :: ((b, a) -> c) -> (a,b) -> c   -- TIPO DE LA EXPRESIÓN QUE RETORNA DESPUES DE EJECUTAR.
uflip f = g
    where g p = f (swap p)
    -- COMO F (...) -> c entonces la función retorna c, no una funcion.

-- EJERCICIO 2:
apply :: (a -> b) -> a -> b
first :: (a, b) -> a

twice :: (a -> a) -> (a -> a)
twice :: (b -> b) -> (b -> b)
twice twice :: (b -> b) -> (b -> b)
      
-- EJERCICIO 3:
VII 7

x :: b
g :: (a -> b)
y :: a

const :: b -> (a -> b)
const x = g
    where g y = x

-----------------------------------------------------------
II 2

f :: (a, a) -> b
g :: a -> b
x :: a

appDup :: ((a, a) -> b) -> (a -> b)
appDup f = g
    where g x = f (x, x)

-----------------------------------------------------------
V 5

f :: (a -> b)
g :: (a -> c)
h :: a -> (b, c)
x :: a

appFork :: ((a -> b), (a -> c)) -> (a -> (b, c))
appFork (f, g) = h
    where h x = (f x, g x)

-----------------------------------------------------------
I 1

f :: (a -> c)
g :: (b -> d)
h :: (a, b) -> (c, d)
x :: a
y :: b

appPar :: ((a -> c), (b -> d)) -> ((a, b) -> (c, d))
appPar (f, g) = h
    where h (x, y) = (f x, g y)

-----------------------------------------------------------
IV 4

f :: (a -> c)    
g :: (a, a) -> (c, c) 
x :: a
y :: a

appDist :: (a -> c) -> ((a, a) -> (c, c) )
appDist f = g
    where g (x, y) = (f x, f y)

-----------------------------------------------------------


f :: (a -> (b -> c))
h :: b -> (a -> c)
x :: b
k :: a -> c
y :: a

flip :: (a -> (b -> c)) -> (b -> (a -> c))
flip f = h
    where h x = k
        where k y = (f y) x     -- como le das los tipos a la funcion a y b entonces el tipo de k y es c.

-----------------------------------------------------------
f :: (a -> (b -> c))
h :: (a -> b) -> (a -> c)
g :: (a -> b)
k :: a -> c     -- devuelve c porque x y (g x) ya los conozco.
x :: a

subst :: -> (a -> (b -> c)) -> ((a -> b) -> (a -> c))
subst f = h
    where h g = k
        where k x = (f x) (g x)


