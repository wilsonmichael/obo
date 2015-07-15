# obo

The OBO format is used to describe ontologies, commonly used in biology. The format is defined at {geneontology.org}[http://www.geneontology.org/GO.format.obo-1_2.shtml]. At the moment, the parser is pretty bare-bones and is enough for me to easily get ontologies into a db. 

The parser (over)uses Enumerators to ensure that you can parse arbitrarily large files. I'm very happy to have feedback about the merits (or lack of merit) of this approach.

## To use

```ruby

# To load an obo file
ontology = Obo::Parser.new "doid.obo"

# To get an enumerator of the elements
elements = ontology.elements

# Using the enumerator
header = elements.next
term   = elements.next

# Accessing attributes of an element
term.id 
#=> "DOID:0014667"

```

## Contributing to obo
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 robsyme. See LICENSE.txt for
further details.

