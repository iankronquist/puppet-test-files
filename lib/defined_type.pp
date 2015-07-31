

define foo::bar ( String $barname,  Float $barval )
{

   notify {'$barname':}

   notify {'$barval':}

}
