data NExp = Var Variable
                    | NCte Int
                    | NBOp NBinOp NExp NExp

data NBinOp = Add | Sub | Mul | Div | Mod | Pow

type Variable = String

cantExtra :: NExp -> Int
cantExtra    (Var v)         = 0
cantExtra    (NCte n)        = 0
cantExtra    (NBOp op e1 e2) = (cantExtraBo op e1 e2) + (cantExtra e1) + (cantExtra e2) 

cantExtraBo :: NBinOp -> NExp -> NExp -> Int
cantExtraBo    op        (NBOp c1) (NBOp c2) = 1
cantExtraBo    op         c1        c2       = 0

NExp1 = NCte 5
NExp2 = NBOp Add (NCte 5) (NCte 6) 
NExp3 = Var "x"

NExp4 = NBOp Add (NCte 5) (NBOp Add (NCte 5) (NCte 6)) 
cantExtra NExp4 = 2.       


cfNE :: NExp -> NExp 
cfNE    (Var v)         = (Var v)
cfNE    (NCte n)        = (NCte n)
cfNE    (NBOp op e1 e2) = cfNEOp op (cfNE e1) (cfNE e2)

cfNEOp :: NBinOp -> NExp -> NExp -> NExp
cfNEOp    op        (NBOp c1) (NBOp c2) = NCte (realizarOp op c1 c2) 
cfNEOp    op        nex1      nex2      = NExp op nex1 nex2


0. Hacer 3 ejemplos de NExp
Prop: ¿cantExtra . cfNE = const 0?