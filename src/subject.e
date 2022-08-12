class
	SUBJECT

create
	make

feature {NONE}

	make (v: INTEGER)
		require
			pre_1: v > 0
		do
			value := v
			create {ARRAYED_LIST [OBSERVER]} subscribers.make (0)
		ensure
			post_1: value = v
		end

	update_observer (o: OBSERVER)
		require
			pre_1: subscribers.has (o)
			pre_2: o.subject = Current
			pre_3: value > 0
		do
			o.update
		ensure
			post_1: o.cache = value
		end

feature {OBSERVER}

	register_observer (o: OBSERVER)
		require
			pre_1: o.subject = Current
			pre_2: value > 0
		do
			subscribers.extend (o)
			o.update
		ensure
			post_1: subscribers.has (o)
			post_2: old subscribers.count + 1 = subscribers.count
		end

feature

	value: INTEGER

	subscribers: LIST [OBSERVER]

	update_value (v: INTEGER)
		require
			pre_1: v > 0
			pre_2: ∀ o: subscribers ¦ o.subject = Current
		do
			value := v
			across
				subscribers as o
			loop
				update_observer (o)
			end
		ensure
			post_1: value = v
		end

invariant
	inv_1: value > 0
	inv_2: ∀ o: subscribers ¦ o.cache = value
	inv_3: ∀ o: subscribers ¦ o.subject = Current

end
