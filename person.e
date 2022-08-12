class
	PERSON

feature

	spouse: PERSON

	is_married: BOOLEAN

	marry (o: PERSON)
		require
			pre_1: o /= Current
			pre_2: ¬ is_married
			pre_3: ¬ o.is_married
		do
			set_spouse (o)
			set_married
			o.set_spouse (Current)
			o.set_married
		ensure
			post_1: o.spouse = Current
			post_2: spouse = o
		end

	divorce (o: PERSON)
		require
			pre_1: is_married
			pre_2: spouse.is_married
			pre_3: o = spouse
		do
			o.unset_married
			unset_married
			o.unset_spouse
			unset_spouse
		ensure
			post_1: ¬ is_married
			post_2: ¬ (old spouse).is_married
		end

feature {PERSON}

	set_married
		do
			is_married := True
		ensure
			post_1: is_married
		end

	unset_married
		do
			is_married := False
		ensure
			post_1: ¬ is_married
		end

	set_spouse (o: PERSON)
		require
			pre_1: o /= Current
			pre_2: ¬ o.is_married ⇒ (o.spouse = Void)
			pre_3: o.is_married ⇒ (o.spouse = Current)
		do
			spouse := o
		ensure
			post_1: spouse = o
		end

	unset_spouse
		do
			spouse := Void
		ensure
			post_1: spouse = Void
		end

invariant
	inv_1: spouse /= Current
	inv_2: is_married = (spouse /= Void)
	inv_3: is_married ⇒ (spouse.spouse = Current)

end
