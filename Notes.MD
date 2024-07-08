As an invariant test it would be a test that checks the delta of balances
Since the Guage cannot emit the flow token except for that path

All we have to do is assert that we never receive that token no matter the gas we set
A path that gives us the token is a path that abuses the OOG attack (or something else I haven't thought about)