data Color = Rojo | Verde

data Persona = ConsP String Int

-- enumerativo
data Gusto = Chocolate
           | DulceDeLeche
           | Frutilla
           | Sambayon
           deriving Show

data Helado = Vasito Gusto
            | Cucurucho Gusto Gusto
            | Pote Gusto Gusto Gusto
            deriving Show

chocoHelate :: (Gusto -> a) -> a
chocoHelate f = f Chocolate

-- chocoHelate id
-- -> -- def chocoHelate, f = id
-- id Chocolate
-- -> -- def id
-- Chocolate

id :: a -> a
id x = x

const :: a -> b -> a
const x y = x

-- chocoHelate const
-- -> -- def chocoHelate
-- const Chocolate


-- chocoHelate const 52
-- -> -- def chocoHelate
-- const Chocolate 52
-- -> -- def const
-- Chocolate

-- a. Vasito :: Gusto -> Helado
-- b. Chocolate :: Gusto
-- c. Cucurucho :: Gusto -> Gusto -> Helado
-- d. Sambayón :: Gusto
-- e. Pote :: Gusto -> Gusto -> Gusto -> Helado
-- f. chocoHelate :: (Gusto -> a) -> a
-- g. chocoHelate Vasito :: Helado
-- h. chocoHelate Cucurucho :: Gusto -> Helado
-- i. chocoHelate (Cucurucho Sambayon) :: Helado
-- j. chocoHelate (chocoHelate Cucurucho) :: Helado
-- k. Does not match : Gusto -> a
-- l. chocoHelate Pote :: Gusto -> Gusto -> Helado
-- m. chocoHelate (chocoHelate (Pote Frutilla)) :: Helado

data DigBin = O | I


dbAsInt O = 0
dbAsInt I = 1

dbAsBool :: DigBin -> Bool
dbAsBool O = False
dbAsBool I = True


boolAsDB False = O
boolAsDB True  = I


negDB O = I
negDB I = O

-- parcial
intAsDB :: Int -> DigBin
intAsDB 0 = O
intAsDB 1 = I

data Medida = Mm Float
            | Cm Float
            | Inch Float
            | Foot Float

asMm :: Medida -> Medida
asMm (Mm n) = Mm (n * 1)
asMm (Cm n) = Mm (n * 0.1)
asMm (Inch n) = Mm (n * 0.039)
asMm (Foot n) = Mm (n * 0.003)

---------------------------------------------

data Shape = Circle Float | Rect Float Float deriving Show

-- aplica 1.0 a c
construyeShNormal :: (Float -> Shape) -> Shape
construyeShNormal c = c 1.0

-- Pote :: Gusto -> Gusto -> Gusto -> Helado

uncurry :: (a -> b -> c) -> (a,b) -> c
uncurry f (x, y) = f x y

flip :: (a -> b -> c) -> b -> a -> c
flip f x y = f y x

-- a. uncurry Rect :: (Float,Float) -> Shape
-- b. construyeShNormal (flip Rect 5.0) :: Shape
-- c. compose (uncurry Rect) swap :: (Float,Float) -> Shape 
-- d. uncurry Cucurucho :: (Gusto,Gusto) -> Helado
-- e. uncurry Rect swap, Does not match : (a,b)
-- f. compose uncurry Pote :: Gusto -> (Gusto, Gusto) -> Helado

compose :: (a -> b) -> (c -> a) -> c -> b
compose f g x = f (g x)

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

-- data Maybe a = Nothing | Just a

-- g. compose Just :: (a -> b) -> a -> Maybe b
-- h. compose uncurry (Pote Chocolate), Does not match : a -> b -> c


---------------------------------------------------

-- ejercicio 6

-- a. uncurry Rect (4,3)
-- b. construyeShNormal (flip Rect 5.0)
-- c. compose (uncurry Rect) swap (4,3)
-- d. uncurry Cucurucho (Chocolate, Frutilla)
-- e. no tipa
-- f. compose uncurry Pote Chocolate (Frutilla, Sambayon)
-- g. compose Just (+1) 5

-- appMaybe :: Maybe (a -> b) -> Maybe a -> Maybe b
-- appMaybe Nothing m2 = Nothing
-- appMaybe m1 Nothing = Nothing
-- appMaybe (Just f) (Just x) = Just (f x)


-- Main> applySafe (safeDiv 10 5) (*2)
-- Just 4
-- Main> applySafe (safeDiv 10 5) (+1)
-- Just 3
-- Main> applySafe (safeDiv 10 0) (+1)
-- Nothing
-- Main> safeDiv 10 0 `applySafe` (+1)
-- Nothing
-- Main> 10 `safeDiv` 0
-- Nothing
-- Main> 10 `safeDiv` 0 `applySafe` (+1) `applySafe` (*2)
-- Nothing
-- Main> 10 `safeDiv` 5 `applySafe` (+1) `applySafe` (*2)
-- Just 6

-- applySafe :: Maybe a -> (a -> b) -> Maybe b
-- applySafe Nothing   f = Nothing
-- applySafe (Just x ) f = Just (f x)

-- safeDiv :: Int -> Int -> Maybe Int
-- safeDiv x 0 = Nothing
-- safeDiv x y = Just (div x y)

esPar :: Int -> Bool
esPar x = x `mod` 2 == 0

-- hasM :: (Int -> Bool) -> Maybe Int -> Maybe Int
-- hasM p Nothing = Nothing
-- hasM p (Just x) =
-- 	if p x
-- 	   then Just x
-- 	   else Nothing

-- lookupM :: Eq k => k -> Maybe (k, v) -> Maybe v
-- lookupM k1 Nothing = Nothing
-- lookupM k1 (Just (k2,v)) =
-- 	if k1 == k2
-- 	   then Just v
-- 	   else Nothing

data Exception = DivByZero
               | NotFound
               | Other String
               deriving Show

data MayFail a = Raise Exception
               | Ok a deriving Show

safeDiv :: Int -> Int -> MayFail Int
safeDiv x 0 = Raise DivByZero
safeDiv x y = Ok (div x y)

safeMod :: Int -> Int -> MayFail Int
safeMod x 0 = Raise (Other "mod by zero")
safeMod x y = Ok (mod x y)

hasM :: MayFail Int -> (Int -> Bool) -> MayFail Int
hasM (Raise e) p = Raise e
hasM (Ok x) p =
	if p x
	   then Ok x
	   else Raise NotFound

-- Main> 10 `safeDiv` 5 `hasM` esPar
-- Ok 2
-- Main> 10 `safeDiv` 5 `hasM` esPar `applySafe` (+1)
-- Ok 3
-- Main> 10 `safeDiv` 5 `hasM` esPar `applySafe` (+1) `hasM` esPar
-- Raise NotFound
-- Main> 10 `safeDiv` 5 `hasM` esPar `applySafe` (+1) `hasM` (not . esPar)
-- Ok 3

type Predicado a = a -> Bool

cumpleAmbos :: Predicado a -> Predicado a -> a -> Bool
cumpleAmbos p1 p2 x = p1 x && p2 x

type ExHandler a = Exception -> a

applySafe :: MayFail a -> (a -> b) -> MayFail b
applySafe (Raise e) f = Raise e
applySafe (Ok x) f   = Ok (f x)

tryCatch :: MayFail a -> (a -> b) -> (ExHandler b) -> b
tryCatch (Ok x) f h = f x
tryCatch (Raise e) f h = h e

catch :: MayFail a -> ExHandler a -> a
catch (Ok x) h = x
catch (Raise e) h = h e

tryMaybe :: Maybe a -> (a -> b) -> b -> b
tryMaybe (Just x) f n = f x
tryMaybe Nothing  f n = n

-- data Either a b = Left b | Right a

-- safeDiv :: Int -> Int -> Either Int String
-- safeDiv x 0 = Left "dividi por cero"
-- safeDiv x y = Right (div x y)
