-- Ejercicio 1:
data Gusto = Chocolate | DulceDeLeche | Frutilla | Sambayon
data Helado = Vasito Gusto
            | Cucurucho Gusto Gusto
            | Pote Gusto Gusto Gusto

chocoHelate :: (Gusto -> Helado) -> Helado
chocoHelate consH = consH Chocolate

a. Vasito :: Gusto -> Helado
b. Chocolate :: Gusto 
c. Cucurucho :: Gusto -> Gusto -> Helado
d. Sambayon :: Gusto
e. Pote :: Gusto -> Gusto -> Gusto -> Helado
f. chocoHelate :: (Gusto -> Helado) -> Helado
g. chocoHelate Vasito :: Helado
h. chocoHelate Cucurucho :: Gusto -> Helado
i. chocoHelate (Cucurucho Sambayon) :: Helado
j. chocoHelate (chocoHelate Cucurucho) :: Helado
k. chocoHelate (Vasito DulceDeLeche) :/:
l. chocoHelate Pote :: Gusto -> Gusto -> Helado
m. chocoHelate (chocoHelate (Pote Frutilla)) :: Helado

-- Ejercicio 2:

data DigBin = O | I

dbAsInt :: DigBin -> Int
dbAsInt    O = 0
dbAsInt    I = 1

dbAsBool :: DigBin -> Bool
dbAsBool    O = False
dbAsBool    I = True

dbOfBool :: Bool -> DigBin
dbOfBool    False = O
dbOfBool    True  = I 

negDB :: DigBin -> DigBin
negDB    O = I 
negDB    I = O

-- Ejercicio 3:

data DigDec = D0 | D1 | D2 | D3 | D4
            | D5 | D6 | D7 | D8 | D9

ddAsInt :: DigDec -> Int
ddAsInt    D0     = 0 
ddAsInt    D1     = 1          
ddAsInt    D2     = 2                
ddAsInt    D3     = 3               
ddAsInt    D4     = 4               
ddAsInt    D5     = 5          
ddAsInt    D6     = 6          
ddAsInt    D7     = 7          
ddAsInt    D8     = 8       
ddAsInt    D9     = 9          

ddOfInt :: Int -> DigDec
ddOfInt    0     = D0 
ddOfInt    1     = D1          
ddOfInt    2     = D2                
ddOfInt    3     = D3               
ddOfInt    4     = D4               
ddOfInt    5     = D5          
ddOfInt    6     = D6          
ddOfInt    7     = D7          
ddOfInt    8     = D8       
ddOfInt    9     = D9 

nextDD :: DigDec -> DigDec
nextDD    D0     = D1         
nextDD    D1     = D2                  
nextDD    D2     = D3                        
nextDD    D3     = D4                      
nextDD    D4     = D5                      
nextDD    D5     = D6                 
nextDD    D6     = D7                 
nextDD    D7     = D8                 
nextDD    D8     = D9              
nextDD    D9     = D0         

prevDD :: DigDec -> DigDec
prevDD    D0     = D9         
prevDD    D1     = D0                  
prevDD    D2     = D1                        
prevDD    D3     = D2                      
prevDD    D4     = D3                      
prevDD    D5     = D4                 
prevDD    D6     = D5                 
prevDD    D7     = D6                 
prevDD    D8     = D7              
prevDD    D9     = D8 

-- Ejercicio 4

data Medida = Mm Float | Cm Float | Inch Float | Foot Float

asMm :: Medida -> Medida
asMm    (Cm n)   = Mm (n * 0.1)
asMm    (Inch n) = Mmn (n * 0.039)
asMm    (Foot n) = Mm (n * 0.003)
asMm    (_ n)    = Mm n

-- Ejercicio 5

data Shape = Circle Float | Rect Float Float

construyeShNormal :: (Float -> Shape) -> Shape
construyeShNormal    c = c 1.0

Rect :: Float -> Float -> Shape
uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry Rect :: (Float , Float) -> Shape

flip Rect 5.0 :: (Float -> Shape)
construyeShNormal (flip Rect 5.0) :: Shape

uncurry Rect :: (Float , Float) -> Shape
compose (uncurry Rect) swap :: (Float, Float) -> Shape

uncurry Cucurucho :: (Gusto, Gusto) -> Helado

uncurry Rect swap :/:

compose uncurry Pote :: (Gusto, Gusto, Gusto) -> Helado

compose Just :: (a -> Maybe b) -> b

Pote Chocolate :: Gusto -> Gusto -> Helado
compose uncurry (Pote Chocolate) :: (Gusto, Gusto) -> Helado


-- Ejercicio 7:
-- La función que tiene el constructor S es la que describe a los elementos que se encuentran dentro del conjunto.
data Set a = S (a -> Bool)

pares = S (\n -> esPar n)       o       pares = S esPar
pares :: Set Int

belongs :: Set a -> a -> Bool
belongs    (S f)    a = f a 

empty :: Set a
empty = S (\x -> False)

singleton :: a -> Set a
singleton    x =  S (\y -> y == x)

union :: Set a -> Set a -> Set a
union    set1    set2     = S (\x -> belongs set1 x || belongs set2 x)

intersection :: Set a -> Set a -> Set a
intersection    set1    set2     = S (\x -> belongs set1 x && belongs set2 x)


-- Ejercicio 8:
data MayFail a = Raise Exception | Ok a
data Exception = DivByZero | NotFound | NullPointer | Other String
type ExHandler a = Exception -> a

-- Definir funcion: Que dada una computación que puede fallar, una función que indica cómo continuar si
-- no falla, y un manejador de los casos de falla, expresa la computación completa.

-- f: La computación de una funcion que puede fallar.
-- g: Funcion que indica como continuar si no falla f.
-- h: Manejador de los casos de falla de f.

--               f           g              h      
tryCatch :: MayFail a -> (a -> b) -> ExHandler b -> b
tryCatch    (Raise e)    _           h           = h e
tryCatch    (Ok x)       g           _           = g x   