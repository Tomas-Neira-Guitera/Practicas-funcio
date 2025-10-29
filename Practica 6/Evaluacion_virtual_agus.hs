compose12  ::  (     d           -> c)   -> (a          ->   b ->      d) ->  a -> b -> c
twice      ::  (a' -> a') -> a' -> a'
compose    ::                               (b' -> c') -> (a'' -> b') -> a'' -> c'
--------------------------------------------------------------------------------
compose12 twice compose ::   (b' -> a') -> (a' -> b') -> a' -> a'



Una funcion anonima que sea equivalente a compose12 twice compose es: (\f -> \g -> \x -> f (g (f (g x))))

PROP: ¿compose12 twice compose  =  \f -> \g -> \x -> f (g (f (g x)))?
DEM : Por principio de extensionalidad, es equivalente demostrar que

¿Para todo f, (compose12 twice compose) f  =  (\f -> \g -> \x -> f (g (f (g x)))) f?
¿Para todo f, para todo g (compose12 twice compose) f g =  (\f -> \g -> \x -> f (g (f (g x)))) f g?
¿Para todo f, para todo g, para todo x (compose12 twice compose) f g x =  (\f -> \g -> \x -> f (g (f (g x)))) f g x?