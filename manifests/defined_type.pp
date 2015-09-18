
# Docstring
# @param notatype
# @param barname Float
# @param barval [String]
define foo::bar ( String $barname,  Float $barval )
{

   notify {'$barname':}

   notify {'$barval':}

}
