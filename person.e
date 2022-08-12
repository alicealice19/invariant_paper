class PERSON feature spouse: PERSON; is_married: BOOLEAN
  marry (o: PERSON)
    require pre$_1$: o /= Current; pre$_2$: $\lnot$ is_married; pre$_3$: $\lnot$ o.is_married
         do set_spouse (o)
            set_married
            o.set_spouse (Current)
            o.set_married
     ensure post$_1$: o.spouse = Current; post$_2$: spouse = o end
  divorce (o: PERSON)
    require pre$_1$: is_married; pre$_2$: spouse.is_married; pre$_3$: o=spouse
         do o.unset_married
            unset_married
            o.unset_spouse
            unset_spouse
     ensure post$_1$: $\lnot$ is_married; post$_2$: $\lnot$ (old spouse).is_married end
feature {PERSON}
  set_married do is_married := True ensure post$_1$: is_married end
  unset_married do is_married := False ensure post$_1$: $\lnot$ is_married end
  set_spouse (o: PERSON)
    require pre$_1$: o /= Current; pre$_2$: $\lnot$ o.is_married $\Rightarrow$ (o.spouse = Void)
            pre$_3$: o.is_married $\Rightarrow$ (o.spouse = Current)
         do spouse := o
     ensure post$_1$: spouse = o end
  unset_spouse do spouse := Void ensure post$_1$: spouse = Void end
invariant inv$_1$: spouse /= Current; inv$_2$: is_married = (spouse /= Void)
          inv$_3$: is_married $\Rightarrow$ (spouse.spouse = Current) end