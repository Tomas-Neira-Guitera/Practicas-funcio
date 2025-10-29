-- Ejercicio 1:
-- Reglas del conjunto que corresponde al tipo algebraico Pizza:

data Pizza = Prepizza | Capa Ingrediente Pizza
data Ingrediente = Aceitunas Int | Anchoas | Cebolla
                    | Jamon | Queso | Salsa

-- Regla 1: Prepizza pertenece al conjunto Pizza.
-- Regla 2: Si i pertenece al conjunto Ingrediente y p al conjunto Pizza entonces Capa i p pertenece al conjunto Pizza.


-- Reglas que definen al conjunto Ingrediente:
-- Regla 1: si n pertenece a Int entonces Aceitunas n pertenece a Ingrediente.
-- Regla 2: Anchoa pertenece al conjunto Ingrediente.
-- Regla 3: Cebolla pertenece al conjunto Ingrediente.
-- Regla 4: Jamon pertenece al conjunto Ingrediente.
-- Regla 5: Queso pertenece al conjunto Ingrediente.
-- Regla 6: Salsa pertenece al conjunto Ingrediente.

-- Ejercicio 2:
-- f :: Pizza -> a 
-- f    Prepizza   =  base
-- f    (Capa i p) = i ... (f p) 

-- Ejercicio 3: 

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas    Prepizza   = 0 
cantidadDeCapas    (Capa i p) = 1 + (cantidadDeCapas p)


cantidadDeAceitunas :: Pizza -> Int
cantidadDeAceitunas    Prepizza   = 0 
cantidadDeAceitunas    (Capa i ) = aceitunasDe i + (cantidadDeAceitunas p)

aceitunasDe :: Ingrediente -> Int
aceitunasDe    (Aceitunas n) = n 
aceitunasDe    _             = 0

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas    Prepizza   = Prepizza
duplicarAceitunas    (Capa i p) = Capa (duplicarAceitunasSub i) (duplicarAceitunas p)

duplicarAceitunasSub :: Ingrediente -> Ingrediente
duplicarAceitunasSub    (Aceitunas n) = (Aceitunas 2*n)
duplicarAceitunasSub    i             = i

sinLactosa :: Pizza -> Pizza
sinLactosa    Prepizza   = Prepizza
sinLactosa    (Capa i p) = case i of 
                    Queso     = sinLactosa p 
                    otherwise = Capa i (sinLactosa p)

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa    Prepizza   = Prepizza
aptaIntolerantesLactosa    (Capa i p) = noEsQueso i && (aptaIntolerantesLactosa p)

noEsQueso :: Ingrediente -> Bool
noEsQueso    Queso       = False
noEsQueso    _           = True

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada    Prepizza   = Prepizza
conDescripcionMejorada    (Capa i p) = case i of 
                                        Aceitunas n = sacarAceitunasSiSeRepitenEnONo n (conDescripcionMejorada p)
                                        otherwise   = Capa i (conDescripcionMejorada p)

sacarAceitunasSiSeRepitenEnONo :: Int -> Pizza -> Pizza
sacarAceitunasSiSeRepitenEnONo    n      Prepizza = Capa (Aceitunas n) Prepizza
sacarAceitunasSiSeRepitenEnONo    n      (Capa i p) = case i of
                                                        Aceitunas n = Capa i p 
                                                        otherwise   = Capa (Aceitunas n) (Capa i p) 

-- Ejercicio 4:
cantidadDeAceitunas Prepizza = cantidadDeAceitunas(conDescripcionMejorada Prepizza)

-- Lado izq:
cantidadDeAceitunas Prepizza
----------------------------
                                por def de cantidadDeAceitunas. con PM <- Prepizza.
0

-- Lado der:
cantidadDeAceitunas(conDescripcionMejorada Prepizza)
                    --------------------------------
                                                     por def de conDescripcionMejorada. con PM <- Prepizza.
cantidadDeAceitunas Prepizza
-------------------------------
                                                     por def de cantidadDeAceitunas. con PM <- Prepizza
0

-------------------------------------------------------------------------------------------------------------------------------------------
-- Seccion 2:
type Nombre = String
data Planilla = Fin
              | Registro Nombre Planilla
data Equipo = Becario Nombre
            | Investigador Nombre Equipo Equipo Equipo

-- Ejercicio 1:
-- Reglas que definen Planilla:
-- Regla 1: Fin pertenece al conjunto Planilla.
-- Regla 2: Si n es de tipo Nombre y p pertenece al conjunto Planilla entonces Registro n p pertenece al conjunto Planilla.

-- Reglas que definen Equipo:
-- Regla 1: si n es de tipo Nombre, entonces Becario n pertenece al conjunto Equipo.
-- Regla 2: si n es de tipo Nombre y e pertenece a Equipo y e2 pertenece a Equipo y e3 pertenece a Equipo, entonces (Investigador n e e2 e3) pertenece a Equipo.

-- Ejercicio 3:
largoDePlanilla :: Planilla -> Int
largoDePlanilla    Fin      = 0
largoDePlanilla    (Registro n p) = 1 + (largoDePlanilla p) 

esta :: Nombre -> Planilla -> Bool
esta    _         Fin            = False
esta    n         (Registro m p) = n == m || (esta n p)

juntarPlanillas :: Planilla -> Planilla -> Planilla
juntarPlanillas    Fin              p2   = p2 
juntarPlanillas    p                Fin  = p 
juntarPlanillas    (Registro n p)   p2   = Registro n (juntarPlanillas p p2) 

nivelesJerarquicos :: Equipo -> Int
nivelesJerarquicos    (Becario n)              = 0
nivelesJerarquicos    (Investigador n e e2 e3) = 1 + (nivelesJerarquicosSub (nivelesJerarquicos e) (nivelesJerarquicos e2) (nivelesJerarquicos e3))  

nivelesJerarquicosSub :: Int -> Int -> Int -> Int
nivelesJerarquicosSub    1      _      _   =  1
nivelesJerarquicosSub    _      1      _   =  1
nivelesJerarquicosSub    _      _      1   =  1
nivelesJerarquicosSub    _      _      _   =  0

cantidadDeIntegrantes :: Equipo -> Int
cantidadDeIntegrantes    (Becario n)              = 1
cantidadDeIntegrantes    (Investigador n e e2 e3) = 1 + (cantidadDeIntegrantes e) + (cantidadDeIntegrantes e2) + (cantidadDeIntegrantes e3)

planillaDeIntegrantes :: Equipo -> Planilla
planillaDeIntegrantes    (Becario n)              = Registro n Fin
planillaDeIntegrantes    (Investigador n e e2 e3) = Registro n (juntarPlanillas (planillaDeIntegrantes e) (juntarPlanillas (planillaDeIntegrantes e2) (planillaDeIntegrantes e3)))

-------------------------------------------------------------------------------------------------------------------------------------------
-- Seccion 3:

data Dungeon a =  Habitacion a
                | Pasaje (Maybe a) (Dungeon a)
                | Bifurcacion (Maybe a) (Dungeon a) (Dungeon a)

Regla 1: Si x pertenece al conjunto a, entonces Habitacion x pertenece al conjunto Dungeon a.
Regla 2: Si m pertenece al conjunto Maybe a y d pertenece al conjunto Dungeon a, entonces Pasaje m d pertenece al conjunto Dungeon a.
Regla 3: Si m pertenece al conjunto Maybe a y d y d2 pertenece al conjunto Dungeon a, entonces Bifurcacion m d d2 pertenece al conjunto Dungeon a.

cantidadDeBifurcaciones :: Dungeon a -> Int
cantidadDeBifurcaciones    (Habitacion x) = 0 
cantidadDeBifurcaciones    (Pasaje m d)   = 0 + cantidadDeBifurcaciones d 
cantidadDeBifurcaciones    (Bifurcacion m d d2) = 1 + (cantidadDeBifurcaciones d) + (cantidadDeBifurcaciones d2)

cantidadDePuntosInteresantes :: Dungeon a -> Int
cantidadDePuntosInteresantes    (Habitacion x) = 0
cantidadDePuntosInteresantes    (Pasaje m d)   = 1 + cantidadDePuntosInteresantes d 
cantidadDePuntosInteresantes    (Bifurcacion m d d2) = 1 + (cantidadDePuntosInteresantes d) + (cantidadDePuntosInteresantes d2)

cantidadDePuntosVacios :: Dungeon a -> Int
cantidadDePuntosVacios    (Habitacion x) = 0
cantidadDePuntosVacios    (Pasaje m d)   = unoSiEsVacio m + (cantidadDePuntosVacios d) 
cantidadDePuntosVacios    (Bifurcacion m d d2) = unoSiEsVacio m + (cantidadDePuntosVacios d) + (cantidadDePuntosVacios d2)

unoSiEsVacio :: Maybe a -> Int
unoSiEsVacio    Nothing = 1
unoSiEsVacio    _       = 0

cantidadDePuntosCon :: a -> Dungeon a -> Int
cantidadDePuntosCon    x    (Habitacion y) = unoSiEsElElemento x (Just y)
cantidadDePuntosCon    x    (Pasaje m d)   = unoSiEsElElemento x m + (cantidadDePuntosCon d) 
cantidadDePuntosCon    x    (Bifurcacion m d d2) = unoSiEsElElemento x m + (cantidadDePuntosCon d) + (cantidadDePuntosCon d2)

unoSiEsElElemento :: a -> Maybe a -> Int
unoSiEsElElemento    x    (Just y) = if x == y then 1 else 0 
unoSiEsElElemento    _    Nothing  = 0

esLineal :: Dungeon a -> Bool
esLineal    (Habitacion _)    = True    
esLineal    (Pasaje _ d)      = True && esLineal d
esLineal    (Bifurcacion _ _) = False

llenoDe :: a -> Dungeon a -> Bool
llenoDe    x    (Habitacion y) = esElElemento x (Just y)
llenoDe    x    (Pasaje m d)   = esElElemento x m && (llenoDe d) 
llenoDe    x    (Bifurcacion m d d2) = esElElemento x m && (llenoDe d) && (llenoDe d2)

esElElemento :: a -> Maybe a -> Bool
esElElemento    x    (Just y) = if x == y
esElElemento    _    Nothing  = False
