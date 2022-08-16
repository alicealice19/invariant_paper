class CIRCULAR_NODE [G] create make, insert feature {CIRCULAR_NODE}
  make (v: G)
        do value := v
           left := Current
           right := Current
    ensure post$_1$: value = v; post$_2$: left = Current; post$_3$: right = Current end
  set_right (o: CIRCULAR_NODE[G])
    require pre$_1$: o.left.right = o; pre$_2$: o.right.left = o
         do right := o ensure post$_1$: right = o end
  set_left (o: CIRCULAR_NODE[G])
    require pre$_1$: o.left.right = o; pre$_2$: o.right.left = o
         do left := o ensure post$_1$: left = o end
  insert_between_two (v: G; l, r: CIRCULAR_NODE[G])
    require pre$_1$: l.right = r; pre$_2$: r.left = l
         do make (v)
            l.set_right (Current)
            r.set_left (Current)
            left := l
            right := r
     ensure post$_1$: value = v; post$_2$: left = l; post$_3$: right = r end
feature value: G; left, right: CIRCULAR_NODE[G]
  remove (l: CIRCULAR_NODE[G])
  	require pre$_1$: l = left;
            pre$_2$: l.left.left.right = l.left; pre$_3$: l.left.right.left = l.left;
            pre$_4$: right.left.right = right; pre$_5$: right.right.left = right; 
         do if l = right then l.make (value)
            else l.insert (l.value, l.left, right) end
            make (value)
     ensure post$_1$: left = Current; post$_2$: (old left).right = old right end
  insert_right (v: G; l: CIRCULAR_NODE[G])
     do insert_between_two (v, l, l.right) end
invariant inv$_1$: left.right = Current; inv$_2$: right.left = Current end
