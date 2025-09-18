-- Dar version de (*)(*)(*) en lambda que no use (*):

(*) :: (b -> c) -> (a -> b) -> a -> c
(*) f g x = f (g x)

\f g x y = (*)(*)(*) f g x
             f  g  x

\f g x y = (*)((*) f) g x y
               f    g x

\f g x y = (*) f (g x) y

/f g x y = f (g x y)