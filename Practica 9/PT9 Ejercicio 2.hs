data EA = Const Int | BOp BinOp EA EA

data BinOp = Sum | Mul

data Arbol a b = Hoja b | Nodo a (Arbol a b) (Arbol a b)

cantidadDeHojas :: Arbol a b -> Int
cantidadDeHojas    (Hoja x)       = 1
cantidadDeHojas    (Nodo y aI aD) = cantidadDeHojas aI + cantidadDeHojas aD

cantidadDeNodos :: Arbol a b -> Int
cantidadDeNodos    (Hoja x)       = 0
cantidadDeNodos    (Nodo y aI aD) = 1 + (cantidadDeNodos aI) + (cantidadDeNodos aD)

cantidadDeConstructores :: Arbol a b -> Int
cantidadDeConstructores    (Hoja x)       = 1
cantidadDeConstructores    (Nodo y aI aD) = 1 + (cantidadDeConstructores aI) + (cantidadDeConstructores aD)

ea2Arbol :: EA -> Arbol BinOp Int
ea2Arbol    (Const n)        = Hoja n
ea2Arbol    (BOp op ea2 ea3) = Nodo op (ea2Arbol ea2) (ea2Arbol ea3)

-------------------------------------------------------------------------------------------------------------------------
-- DEMOSTRAR:
para todo t :: Arbol a b
cantidadDeHojas t + cantidadDeNodos t = cantidadDeConstructores t

