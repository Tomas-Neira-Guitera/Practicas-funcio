Tarea: 25/10/2025

data DigBin = O | I
type NBin = [DigBin]

evalNB :: NBin -> Int
evalNB    []       = 0
evalNB    (d : ds) = case d of
                            O -> 2 * evalNB ds 
                            I -> 1 + 2 * evalNB resto

addNB :: NBin -> NBin -> NBin
addNB    []      nb   = nb 
addNB    (d, ds) nb   =   (addNB ds nb)


addNBConCarry :: NBin -> NBin -> DigBin -> NBin,
addDBConCarry :: DigBin -> DigBin -> DigBin -> (DigBin, DigBin)


evalNB (addNB n1 n2) = evalNB n1 + evalNB n2
