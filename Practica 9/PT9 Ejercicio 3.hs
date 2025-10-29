data Tree a = EmptyT | NodeT a (Tree a) (Tree a)


sumarT :: Tree Int -> Int
sumarT    EmptyT          = 0
sumarT    (NodeT n tI tD) = n + (sumarT tI) + (sumarT tD)

sizeT :: Tree a -> Int
sizeT    EmptyT          = 0
sizeT    (NodeT n tI tD) = 1 + (sizeT tI) + (sizeT tD)

anyT :: (a -> Bool) -> Tree a -> Bool
anyT    f              EmptyT          = False
anyT    f              (NodeT n tI tD) = f n || (anyT tI) (anyT tD)

countT :: (a -> Bool) -> Tree a -> Int
countT    f              EmptyT          = False
countT    f              (NodeT n tI tD) = if (f n)
                                            then 1 + (countT tI) + (countT tD)
                                            else (countT tI) + (countT tD)

countLeaves :: Tree a -> Int 
countLeaves    EmptyT          = 0
countLeaves    (NodeT n tI tD) = if (esHoja tI tD)
                                    then 1
                                    else (countLeaves tI) + (countLeaves tD)

esHoja :: Tree a -> Tree a -> Int
esHoja    EmptyT    EmptyT = True
esHoja    _         _      = False

heightT :: Tree a -> Int
heightT    EmptyT          = 0
heightT    (NodeT n tI tD) = 1 + max (heightT tI) (heightT tD)

inOrder :: Tree a -> [a]
inOrder    EmptyT          = []
inOrder    (NodeT n tI tD) = (inOrder tI) ++ [n] ++ (inOrder tD)

listPerLevel :: Tree a -> [[a]]
listPerLevel    EmptyT          = [[]]
listPerLevel    (NodeT n tI tD) = [n] : (juntarListas (listPerLevel tI) (listPerLevel tD))

juntarListas :: [[a]] -> [[a]] -> [[a]]
juntarListas    xss      []           = xss 
juntarListas    []       yss          = yss 
juntarListas    (xs : xss) (ys : yss) = (xs ++ ys) : (juntarListas xss yss)

mirrorT :: Tree a -> Tree a
mirrorT    EmptyT          = EmptyT
mirrorT    (NodeT n tI tD) = NodeT n (mirrorT tD) (mirrorT tI)

levelN :: Int -> Tree a -> [a]
levelN    _      EmptyT          = []
levelN    0      (NodeT x tI tD) = [x]
levelN    n      (NodeT n tI tD) = (levelN (n-1) tI) ++ (levelN (n-1) tD)

ramaMasLarga :: Tree a -> [a]
ramaMasLarga    EmptyT          = []
ramaMasLarga    (NodeT n tI tD) =  n : (masLarga (ramaMasLarga tI) (ramaMasLarga tD))

masLarga :: [a] -> [a] -> [a]
masLarga    xs     ys  = if lenght xs > lenght ys
                            then xs 
                            else ys  

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos    EmptyT          = [[]]
todosLosCaminos    (NodeT n tI tD) = appendACadaUno [n] ((todosLosCaminos tI) ++ (todosLosCaminos tD))

appendACadaUno :: [a] -> [[a]] -> [[a]]
appendACadaUno    xs     []         = [xs]
appendACadaUno    xs     (ys : yss) = (xs ++ ys) : (appendACadaUno xs yss) 

-----------------------------------------------------------------------------------------------------------------------
-- DEMOSTRAR:
heightT = length . ramaMasLarga

reverse . inOrder = inOrder . mirrorT