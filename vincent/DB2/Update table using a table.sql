update state st
	set st.population = (select ns.population from newstate ns where ns.id = st.id)
where st.id in (select ns.id from newstate ns)