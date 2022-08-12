class SUBJECT create make feature {NONE}
  make (v: INTEGER)
    require pre$_1$: v > 0
         do value := v
            create {ARRAYED_LIST [OBSERVER]} subscribers.make(0)
     ensure post$_1$: value = v end
  update_observer (o: OBSERVER)
    require pre$_1$: subscribers.has(o); pre$_2$: o.subject = Current; pre$_3$: value > 0
         do o.update
     ensure post$_1$: o.cache = value end
feature {OBSERVER}
  register_observer (o: OBSERVER)
    require pre$_1$: o.subject = Current; pre$_2$: value > 0
         do subscribers.extend(o)
            o.update 
     ensure post$_1$: subscribers.has(o)
            post$_2$: old subscribers.count + 1 = subscribers.count end
feature value: INTEGER; subscribers: LIST [OBSERVER]
  update_value (v: INTEGER)
    require pre$_1$: v > 0; pre$_2$: $\forall$o: subscribers | o.subject = Current
         do value := v
            across subscribers as o loop update_observer(o) end
     ensure post$_1$: value = v end
invariant   inv$_1$: value > 0; inv$_2$: $\forall$o: subscribers | o.cache = value;
            inv$_3$: $\forall$o: subscribers | o.subject = Current end