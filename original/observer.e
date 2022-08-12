class OBSERVER feature {NONE}
  make (s: SUBJECT)
         do subject := s;
            s.register_observer(Current)
     ensure post$_1$: subject = s; post$_2$: s.subscribers.has(Current)
            post$_3$: old s.subscribers.count + 1 = s.subscribers.count end
feature {SUBJECT, OBSERVER}
  update
        do cache := subject.value
    ensure post$_1$: cache = subject.value end
feature cache: INTEGER; subject: SUBJECT
  set_subject (s: SUBJECT)
        do subject := s
           s.register_observer(Current)
    ensure post$_1$: subject = s end
invariant inv$_1$: cache > 0; inv$_2$: cache = subject.value;
          inv$_3$: subject.subscribers.has (Current) end
