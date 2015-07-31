class foo( MyType $ident = "Bob" , MyInt $age = 10, )
{
	notify {'$ident':}
	notify {'$age':}
}
