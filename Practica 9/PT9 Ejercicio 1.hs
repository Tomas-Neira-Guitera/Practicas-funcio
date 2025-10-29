data EA = Const Int | BOp BinOp EA EA

data BinOp = Sum | Mul

data ExpA = Cte Int
            | Suma ExpA ExpA
            | Prod ExpA ExpA


evalEA :: EA -> Int  
evalEA    (Const n)         = n
evalEA    (BOp op ea1 ea2) = realizarOp op (evalEA ea1) (evalEA ea2)

realizarOp :: BinOp -> Int -> Int -> Int
realizarOp    Sum      n1     n2  = n1 + n2 
realizarOp    Mul      n1     n2  = n1 * n2

ea2ExpA :: EA -> ExpA
ea2ExpA    (Const n)         = Cte n
ea2ExpA    (BOp op ea1 ea2) = ea2ExpOp op (ea2ExpA ea1) (ea2ExpA ea2)

ea2ExpOp :: BinOp -> ExpA -> ExpA -> ExpA
ea2ExpOp    Sum      e1     e2  = Suma e1 e2
ea2ExpOp    Mul      e1     e2  = Prod e1 e2

expA2ea :: ExpA -> EA
expA2ea    (Cte n)      = Const n 
expA2ea    (Suma e1 e2) = BOp Sum (expA2ea e1) (expA2ea e2)
expA2ea    (Prod e1 e2) = BOp Mul (expA2ea e1) (expA2ea e2)

-- Demostraciones:

ea2ExpA . expA2ea = id

por ppio de extencionalidad, para todo e :: ExpA
(ea2ExpA . expA2ea) e = id e

por def de (.) es equivalente demostrar:
ea2ExpA (expA2ea e) = id e

Voy a demostrar por induccion estructural sobre e.

Caso base: para todo n :: Int 
e = Cte n

TB: ea2ExpA (expA2ea (Cte n)) = id (Cte n)

Caso inductivo 1: para todo e1, e2 :: ExpA
e = Suma e1 e2

HI1:  ea2ExpA (expA2ea e1) = id e1
HI12: ea2ExpA (expA2ea e2) = id e2
TI1:  ea2ExpA (expA2ea (Suma e1 e2)) = id (Suma e1 e2)

Caso inductivo 2: para todo e1, e2 :: ExpA
e = Prod e1 e2

HI2:  ea2ExpA (expA2ea e1) = id e1
HI22: ea2ExpA (expA2ea e2) = id e2
TI2:  ea2ExpA (expA2ea (Prod e1 e2)) = id (Prod e1 e2)

-------------------------------------------------------------
-- CASO BASE:
TB: ea2ExpA (expA2ea (Cte n)) = id (Cte n)

-- lado izq:
ea2ExpA (expA2ea (Cte n))
        -----------------
                            def expA2ea
= ea2ExpA (Const n)
  -----------------
                            def ea2ExpA
Cte n                      

-- lado der:
id (Cte n)
----------
                def id 
= Cte n
-------------------------------------------------------------
-- CASO INDUCTIVO 1:
ea2ExpA (expA2ea (Suma e1 e2)) = id (Suma e1 e2)

-- lado izq:
ea2ExpA (expA2ea (Suma e1 e2))
        ----------------------
                                                    def expA2ea
= ea2ExpA (BOp Sum (expA2ea e1) (expA2ea e2))
 -------------------------------------------
                                                    def ea2ExpA
= Suma (ea2ExpA (expA2ea e1)) (ea2ExpA (expA2ea e2))
      -----------------------
                                                    uso de HI1 
= Suma (id e1) (ea2ExpA (expA2ea e2))
               ----------------------
                                                    uso de HI2 
= Suma (id e1) (id e2)
       -------
                                                    def id 
= Suma e1 (id e2)
          -------
                                                    def id 
= Suma e1 e2

-- lado der:
id (Suma e1 e2)
---------------
                                                    def id 
= Suma e1 e2
-------------------------------------------------------------
-- CASO INDUCTIVO 2:
...
--------------------------------------------------------------------------------------------------------------------------
evalExpA . ea2ExpA = evalEA





