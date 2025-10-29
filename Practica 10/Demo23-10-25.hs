data NExp = Var Variable
                    | NCte Int
                    | NBOp NBinOp NExp NExp
data NBinOp = Add | Sub | Mul | Div | Mod | Pow

type Variable = String

cfNE :: NExp -> NExp
cfNE (Var v) = Var v
cfNE (NCte c) = NCte c
cfNE (NBOp nbo e1 e2) = cfNBOp nbo (cfNE e1) (cfNE e2)

cfNBOp :: NBinOp -> NExp -> NExp -> NExp
cfNBOp bop (NCte c1) (NCte c2) = NCte (evalNBOp bop c1 c2)
cfNBOp bop e1 e2 = NBOp bop e1 e2

evalNBOp :: NBinOp -> Int -> Int -> Int
evalNBOp Add = (+)
evalNBOp Sub = (-)
evalNBOp Mul = (*)
evalNBOp Div = (div)
evalNBOp Mod = (mod)
evalNBOp Pow = (^)

cantExtra :: NExp -> Int
cantExtra (Var v) = 0
cantExtra (NCte c) = 0
cantExtra (NBOp nbo e1 e2) = cantExtraBo nbo e1 e2 + cantExtra e1 + cantExtra e2

cantExtraBo :: NBinOp -> NExp -> NExp -> Int
cantExtraBo bo (NCte c1) (NCte c2) = 1
cantExtraBo bo c1 c2 = 0

Prop: ¿cantExtra . cfNE = const 0?

    prop: cantExtra . cfNE = const 0?

    demo: 
    Por principio de extensionalidad, es equivalente demostrar que
        ¿Para todo ne. (cantExtra . cfNE) ne = const 0 ne?
    
    Por def de (.) es equivalente demostrar
        ¿Para todo ne. cantExtra (cfNE ne) = const 0 ne?

    Por def de (const) es equivalente demostrar
        ¿Para todo ne. cantExtra (cfNE ne) = 0?

    Sea ne' :: NExp, (finito y totalmente definido)

    Aplicamos principio de induccion sobre la estructura de ne'

    Caso base 1: ne' = Var v)
        ¿cantExtra (cfNE (Var v)) = 0?

    Caso base 2: ne' = NCte c)
        ¿cantExtra (cfNE (NCte c)) = 0?

    Caso base ind: ne' = NBOp nbo e1 e2)
        HI.1) ¿cantExtra (cfNE e1) = 0?
        HI.2) ¿cantExtra (cfNE e2) = 0?
        TI) ¿cantExtra (cfNE (NBOp nbo e1 e2)) = 0?

    Desarrollo

    Caso base 1: ne' = Var v)
    
    Lado Izq
        cantExtra (cfNE (Var v))
    =                               (cfNE.1)
        cantExtra (Var v)
    =                               (cantExtra.1)
        0

    Este caso cumple

    Caso base 2: ne' = NCte c)
    
    Lado Izq
        cantExtra (cfNE (NCte c))
    =                               (cfNE.2)
        cantExtra (NCte v)
    =                               (cantExtra.2)
        0

    Este caso cumple

    Caso base ind: ne' = NBOp nbo e1 e2)
    
    Lado Izq
        cantExtra (cfNE (NBOp nbo e1 e2))
    =                                               (cfNE.3)
        cantExtra (cfNBOp nbo (cfNE e1) (cfNE e2))
    =
        cantExtra (cfNBOp nbo (cfNE e1) (cfNE e2))
    =                                               (LEMA.1)
        cantExtra (cfNE e1) + cantExtra (cfNE e2)
    =                                               (HI.1)
        0 + cantExtra (cfNE e2)
    =                                               (HI.2)
        0 + 0
    =                                               (aritm)
        0


    Lado der
        0


    Este caso cumple

    LEMA 1)
    prop: ¿para todo nbo :: NBinOp. para todo e1 :: NExp. para todo e2 :: NExp. 
        cantExtra (cfNBOp nbo e1 e2) = cantExtra e1 + cantExtra e2?

    demo: Sea un nbo' :: NBinOp, sea e1' :: NExp, sea e2' :: NExp.

    Planteo de casos sobre nbo'

    cfNBOp :: NBinOp -> NExp -> NExp -> NExp
    cfNBOp bop (NCte c1) (NCte c2) = NCte (evalNBOp bop c1 c2)
    cfNBOp bop e1 e2 = NBOp bop e1 e2

    Caso 1: e1' = NCte c1, e2' = NCte c2)
        ¿cantExtra (cfNBOp bop e1' e2') = cantExtra (NCte c1) + cantExtra (NCte c2)?

    Caso 2: e1' distinto de NCte c1, e2' distinto de NCte c2)
        ¿cantExtra (cfNBOp bop e1' e2') = cantExtra e1' + cantExtra e2'?
    
    Desarrollo

    Caso 1: e1' = NCte c1, e2' = NCte c2)

    Lado izq

        cantExtra (cfNBOp bop (NCte c1) (NCte c2))
    =                                               (cfNBOp.1)
        cantExtra (NCte (evalNBOp bop c1 c2))
    =                                               (cantExtra.2)
        0

    Lado der

        cantExtra (NCte c1) + cantExtra (NCte c2)
    =                                               (cantExtra.1)
        0 + cantExtra (NCte c2)
    =                                               (cantExtra.1)
        0 + 0
    =                                               (aritm)
        0

    Este caso cumple

    Caso 2: e1' distinto de NCte c1, e2' distinto de NCte c2)
    
    Lado Izq
    
        cantExtra (cfNBOp bop e1' e2')
    =                                                           (cfNBOp.2)
        cantExtra (NBOp bop e1' e2')
    =                                                           (cantExtra.3)
        cantExtraBo bop e1' e2' + cantExtra e1' + cantExtra e2'
    =
        0 + cantExtra e1' + cantExtra e2'
    =                                                           (aritm)
        cantExtra e1' + cantExtra e2'

    Este caso cumple

    Ambos casos cumplen

    El lema vale

    Como el lema vale la propiedad, cantExtra (cfNE (NBOp nbo e1 e2)) = 0