class
	OBSERVER

feature {NONE}

	make (s: SUBJECT)
		do
			subject := s
			s.register_observer (Current)
		ensure
			post_1: subject = s
			post_2: s.subscribers.has (Current)
			post_3: old s.subscribers.count + 1 = s.subscribers.count
		end

feature {SUBJECT, OBSERVER}

	update
		do
			cache := subject.value
		ensure
			post_1: cache = subject.value
		end

feature

	cache: INTEGER

	subject: SUBJECT

	set_subject (s: SUBJECT)
		do
			subject.subscribers.search(Current)
			subject.subscribers.remove
			subject := s
			s.register_observer (Current)
		ensure
			post_1: subject = s
		end

invariant
	inv_1: cache > 0
	inv_2: cache = subject.value
	inv_3: subject.subscribers.has (Current)

end
