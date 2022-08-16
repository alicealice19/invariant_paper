class
	CIRCULAR_NODE [G]

create
	make, insert
	

feature {CIRCULAR_NODE}

	make (v: G)
		do
			value := v
			left := Current
			right := Current
		ensure
			post_1: value = v
			post_2: left = Current
			post_3: right = Current
		end

	set_right (o: CIRCULAR_NODE [G])
		require
			pre_1: o.left.right = o
			pre_2: o.right.left = o
		do
			right := o
		ensure
			post_1: right = o
		end

	set_left (o: CIRCULAR_NODE [G])
		require
			pre_1: o.left.right = o
			pre_2: o.right.left = o
		do
			left := o
		ensure
			post_1: left = o
		end
		
	insert_between_two (v: G; l, r: CIRCULAR_NODE [G])
		require
			pre_1: l.right = r
			pre_2: r.left = l
		do
			make (v)
			l.set_right (Current)
			r.set_left (Current)
			left := l
			right := r
		ensure
			post_1: value = v
			post_2: left = l
			post_3: right = r
		end

feature

	value: G

	left, right: CIRCULAR_NODE [G]

	remove (l: CIRCULAR_NODE [G])
		require
			pre_1: l = left
			pre_2: l.left.left.right = l.left
			pre_3: l.left.right.left = l.left
			pre_4: right.left.right = right
			pre_5: right.right.left = right
		do
			if l = right then
				l.make (value)
			else
				l.insert (l.value, l.left, right)
			end
			make (value)
		ensure
			post_1: left = Current
			post_2: (old left).right = old right
		end
		
	insert_right(v: G; l: CIRCULAR_NODE [G])
		do 
			insert_between_two(v, l, l.right)
		end

invariant
	inv_1: left.right = Current
	inv_2: right.left = Current

end
