data ExpA = Cte Int
            | Suma ExpA ExpA
            | Prod ExpA ExpA

evalExpA :: ExpA -> Int
evalExpA    (Cte n)      = n
evalExpA    (Suma e1 e2) = (evalExpA e1) + (evalExpA e2) 
evalExpA    (Prod e1 e2) = (evalExpA e1) * (evalExpA e2) 

simplificarExpA :: ExpA -> ExpA
simplificarExpA    (Cte n)      = Cte n
simplificarExpA    (Suma e1 e2) = simplificarSuma (simplificarExpA e1) (simplificarExpA e2)  
simplificarExpA    (Prod e1 e2) = simplificarMultiplicacion (simplificarExpA e1) (simplificarExpA e2) 

simplificarSuma :: ExpA -> ExpA -> ExpA
simplificarSuma    (Cte 0) e2      = e2 
simplificarSuma    e1      (Cte 0) = e1 
simplificarSuma    e1      e2      = Suma e1 e2 

simplificarMultiplicacion :: ExpA -> ExpA -> ExpA
simplificarMultiplicacion    (Cte 1) e2      = e2 
simplificarMultiplicacion    e1      (Cte 1) = e1 
simplificarMultiplicacion    (Cte 0) e2      = Cte 0
simplificarMultiplicacion    e1      (Cte 0) = Cte 0
simplificarMultiplicacion    e1      e2      = Prod e1 e2 

cantidadDeSumaCero :: ExpA -> Int 
cantidadDeSumaCero    (Cte n)      = 0
cantidadDeSumaCero    (Suma e1 e2) = (unoSiSumaCero e1 e2) + (cantidadDeSumaCero e1) (cantidadDeSumaCero e2)  
cantidadDeSumaCero    (Prod e1 e2) = 0 +  (cantidadDeSumaCero e1) (cantidadDeSumaCero e2) 

unoSiSumaCero :: ExpA -> ExpA -> Int
unoSiSumaCero    (Cte 0) e2      = 1 
unoSiSumaCero    e1      (Cte 0) = 1 
unoSiSumaCero    _      _        = 0

---------------------------------------------------------------------------------------------------
-- DEMOSTRACIÓN:
evalExpA . simplificarExpA = evalExpA

por ppio de extencionalidad para todo e :: ExpA
(evalExpA . simplificarExpA) e = evalExpA e

por def de (.) es equivalente demostrar que:
evalExpA (simplificarExpA e) = evalExpA e

voy a demostrar por induccion estructural sobre e.
para todo n :: int 
Caso base: e = Cte n
TB) evalExpA (simplificarExpA (Cte n)) = evalExpA (Cte n)

para todo e1, e2 :: ExpA
Caso inductivo1: Suma e1 e2
HI1)  evalExpA (simplificarExpA e1) = evalExpA e1
HI12) evalExpA (simplificarExpA e2) = evalExpA e2
TI1)  evalExpA (simplificarExpA (Suma e1 e2)) = evalExpA (Suma e1 e2)

para todo e3, e4 :: ExpA
Caso inductivo1: Prod e3 e4
HI2)  evalExpA (simplificarExpA e3) = evalExpA e3
HI22) evalExpA (simplificarExpA e4) = evalExpA e4
TI2)  evalExpA (simplificarExpA (Prod e3 e4)) = evalExpA (Prod e3 e4)

Demostracion del caso base:
evalExpA (simplificarExpA (Cte n)) = evalExpA (Cte n)

lado izq:
evalExpA (simplificarExpA (Cte n))
         -------------------------
                                    def simplificarExpA 
= evalExpA (Cte n)
  ----------------
                                    def evalExpA
= n

lado der: 
evalExpA (Cte n)
----------------
                    def evalExpA
= n


Demostracion caso inductivo1:
evalExpA (simplificarExpA (Suma e1 e2)) = evalExpA (Suma e1 e2)

lado izq:
evalExpA (simplificarExpA (Suma e1 e2))
          ----------------------------
                                        def simplificarExpA.
= evalExpA (simplificarSuma (simplificarExpA e1) (simplificarExpA e2)) ----------------------------
  -------------------------------------------------------------------
                                                                      por uso de lema EvaluarSuma_EvaluacionDeSumaSimplificada.
= evalExpA (simplificarExpA e1) + evalExpA (simplificarExpA e2)
            

lado der:
evalExpA (Suma e1 e2)
---------------------
                                              def evalExpA
= evalExpA e1 + evalExpA e2
  -----------
                                              uso de HI1
= evalExpA (simplificarExpA e1) + evalExpA e2
                                  -----------
                                              uso de HI12
= evalExpA (simplificarExpA e1) + evalExpA (simplificarExpA e2) ---------------------------------


Como ya no se puede avanzar más con la demostracion por qué "simplificarSuma" y "simplificarExpA" evaluan casos. 
La solucion es crear un lema lo más general posible. Se deben identificar las partes que son iguales en ambos lados y se deben simplificar.
Por ejemplo simplificarExpA e1 se puede remplazar por e1.

Antes:
evalExpA (simplificarExpA e1) + evalExpA (simplificarExpA e2) = evalExpA (simplificarSuma (simplificarExpA e1) (simplificarExpA e2))

Despues:
evalExpA e1 + evalExpA e2 = evalExpA (simplificarSuma e1 e2)

LEMA: para todo e1, e2 :: ExpA  nombre del lema = EvaluarSuma_EvaluacionDeSumaSimplificada
evalExpA e1 + evalExpA e2 = evalExpA (simplificarSuma e1 e2)

Caso 1) e1 = Cte 0

Caso 2) e2 = Cte 0 

Caso 3) para todo e3, e4 :: ExpA
        e1 = e3  
        e2 = e4

Desmostracion Caso 1:
lado izq:
evalExpA (Cte 0) + evalExpA e2
----------------
                                def evalExpA
= 0 + evalExpA e2
  ---------------
                                aritmetica
= evalExpA e2

lado der:
evalExpA (simplificarSuma (Cte 0) e2)
         ----------------------------
                                        def simplificarSuma
= evalExpA e2

Desmostracion Caso 2:
lado izq:
evalExpA e1 + evalExpA (Cte 0)
              ----------------
                                def evalExpA
= evalExpA e1 + 0
  ---------------
                                aritmetica
= evalExpA e1

lado der:
evalExpA (simplificarSuma e1 (Cte 0))
         ----------------------------
                                        def simplificarSuma
= evalExpA e1

Desmostracion Caso 3:
lado izq:
evalExpA e1 + evalExpA e2


lado der:
evalExpA (simplificarSuma e1 e2)
          ----------------------
                                  def simplificarSuma
= evalExpA (Suma e1 e2)
  ---------------------
                                  def evalExpA
= evalExpA e1 + evalExpA e2 