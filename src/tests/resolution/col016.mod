module col016.

accumulate lkf-kernel.
accumulate eprover.
accumulate resolution_steps.

resProblem "col016" [(pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
(pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))) ),
(pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))) ),
(pr 1 (n (X1 == ( apply combinator X1 ))) )] 
(rsteps [pm (id (idx 5)) (id (idx 6)) 4, pm (id (idx 6)) (id (idx 4)) 2, pm (id (idx 1)) (id (idx 2)) 0] estate )
 (map [
pr 2 (p (( apply X1 ( apply m ( apply l X1 ) ) ) == ( apply m ( apply l X1 ) ))),
pr 0 f-,
pr 3 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 6 (p (( apply m X1 ) == ( apply X1 X1 ))),
pr 5 (p (( apply ( apply l X1 ) X2 ) == ( apply X1 ( apply X2 X2 ) ))),
pr 4 (p (( apply X1 ( apply m X2 ) ) == ( apply ( apply l X1 ) X2 ))),
pr 1 (n (X1 == ( apply combinator X1 )))
]).

inSig apply.

