module eprover.

accumulate lkf-kernel.
accumulate binary_res_fol_nosub.
accumulate paramodulation.
accumulate resolution_steps.

accumulate debug.

% gets a sequent |- A !-! B, C, D !-! E, etc.

%binary rules, use the right indices and the right resolution certificate
cut_ke (rsteps [PM | RS] estate) K C1 C2 :-
  print "!!!!!!1a\n",
  param_rule PM I1 I2 I,
  spy "binary " (cut_ke (rsteps [ resolv (pid (idx I1)) (pid (idx I2)) I | RS] estate) K C1 C2). % paramodulation step
cut_ke (rsteps [PM | RS] (varmaps S)) K C1 C2 :-
  print "!!!!!!1b\n",
  param_rule PM II1 II2 I,
  spy "mapped " (varmapped II1 I1 S),
  spy "mapped " (varmapped II2 I2 S),
  spy "binary " (cut_ke (rsteps [ resolv (pid (idx I1)) (pid (idx I2)) I | RS] (varmaps S)) K C1 C2). % paramodulation step

%unary rules, just track the indices
cut_ke (rsteps [ER | RS] estate) K C1 C2 :-
  print "!!!!!!2a\n",
  unary_rule ER I1 I2,
  spy "varmaps " (varmap I2 I1 [] S2), % manage the variable mappings
  spy "unary " (cut_ke (rsteps RS (varmaps S2)) K C1 C2). % map the new id to the above id and continue the processing of rsteps.
cut_ke (rsteps [ER | RS] (varmaps S)) K C1 C2 :-
  print "!!!!!!2b\n",
  unary_rule ER I1 I2,
  spy "varmaps " (varmap I2 I1 S S2), % manage the variable mappings
  spy "unary " (cut_ke (rsteps RS (varmaps S2)) K C1 C2). % map the new id to the above id and continue the processing of rsteps.

param_rule (pm (id (idx I1)) (id (idx I2)) I) I1 I2 I.
param_rule (rw (id (idx I1)) (id (idx I2)) I) I1 I2 I.
unary_rule (assume_negation (id (idx I1)) I2) I1 I2.
unary_rule (fof_simplification (id (idx I1)) I2) I1 I2.
unary_rule (split_conjunct (id (idx I1)) I2) I1 I2.
unary_rule (variable_rename (id (idx I1)) I2) I1 I2.
unary_rule (cn (id (idx I1)) I2) I1 I2.

varmap I1 I2 [] [[I2,I1]]. % adding a new list
varmap I1 I2 [[I2 | R] | R2] [[I2, I1 | R] | R2]. % list exists, add new index
varmap I1 I2 [[I3 | R] | R2] [[I3, I1 | R] | R2] :- % I2 is already mapped to I3 so map I1 to I3 as well.
  member I2 R.
varmap I1 I2 [A | LS1] [A | LS2] :- % otherwise, recurse on list
  varmap I1 I2 LS1 LS2.

varmapped I I []. % empty state, mapped to self
varmapped I1 I2 [[I2 | R] | _] :- % I1 is member of R, then I1 is mapped to I2
  member I1 R.
varmapped I1 I2 [_ | R] :- % recurse on list
  varmapped I1 I2 R.
