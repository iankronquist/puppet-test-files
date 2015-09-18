
# Docstring
# @param notatype
# @param barname Float
# @param barval [String]
define foo::bar ( String $alert,  Float $barval )
{

   notify {'$barname':}

   notify {'$barval':}

}
