data NExp = Var Variable
            | NCte Int
            | NBOp NBinOp NExp NExp
data NBinOp = Add | Sub | Mul | Div | Mod | Pow
type Variable = String

evalNExp :: NExp -> Memoria -> Int
evalNExp    (Var v)  m      = fromJust (cuantoVale v m) 
evalNExp    (NCte n) m      = n 
evalNExp    (NBOp op e2 e3) = realizarOp op (evalNExp e2) (evalNExp e3)

cfNExp :: NExp -> NExp
evalNExp    (Var v)         = (Var v)
evalNExp    (NCte n)        = (NCte n)
evalNExp    (NBOp op e2 e3) = simplificarOp op (cfNExp e3) (cfNExp e3) 

simplificarOp :: NBinOp -> NExp -> NExp -> NExp
simplificarOp    Add       e1      e2   = simplificarOpSuma e1 e2 
simplificarOp    Sub       e1      e2   = simplificarOpResta e1 e2 
simplificarOp    Mul       e1      e2   = simplificarOpMul e1 e2 
simplificarOp    Div       e1      e2   = simplificarOpDiv e1 e2
simplificarOp    Mod       e1      e2   = simplificarOpMod e1 e2
simplificarOp    Pow       e1      e2   = simplificarOpPow e1 e2

demostrar: 
evalNExp . cfNExp = evalNExp