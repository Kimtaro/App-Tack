App-Tack
========

Templates for Ack

Usage
-----

    - tack template_name [template interpolations] [ack files and options]
      Run ack with the named template
  
    - tack --h|he|hel|help
      Show this help
  
    - tack --templates
      Print available templates

Available templates
-------------------

    -> Map Ruby files
       Name: map
       Pattern: \b(def|class|module|private|protected)\b

    -> Find the named symbol. Takes one required argument
       Name: name
       Pattern: \b(ARG)\b

    -> Find subs/defs/functions. Takes one optional argument
       Name: (sub|def|func(t(i(o(n)?)?)?)?)
       Pattern: \b(sub|def|function)(?:\s*<ARG>)?\b

TODO
---------

- Let the user add templates
