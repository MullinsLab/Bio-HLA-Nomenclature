# NAME

Bio::HLA::Nomenclature - Programmatic handling of HLA allele names

# DESCRIPTION

This library consists of three primary modules.

## Bio::HLA::Nomenclature

Parse allele designations into their component parts

## Bio::HLA::Nomenclature::Converter

Convert from 2009 and earlier names to the new 2010 nomenclature

## Bio::HLA::Nomenclature::AmbiguousGroups

Lookup an allele's membership in groups of ambiguous alleles

# METHODS

## parse\_allele

Given a single HLA allele designation, returns a hashref of the component
parts.  If the string is unparseable, returns undef.  Both new (2010 and
onwards) and old (pre-2010) allele syntax is supported.

The following keys are always returned in the hashref, but some may be `undef`
if not applicable or not provided:

- locus
- workshop
- type
- subtype
- synonymous\_polymorphism
- utr\_polymorphism
- expression\_level
- ambiguity\_group

Refer to [http://hla.alleles.org/nomenclature/naming.html](http://hla.alleles.org/nomenclature/naming.html) for the meaning of
each part.

# AUTHOR

Thomas Sibley <trsibley@uw.edu>

# COPYRIGHT

Copyright 2015-2018 University of Washington

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Bio::HLA::Nomenclature::Converter](https://metacpan.org/pod/Bio::HLA::Nomenclature::Converter),
[Bio::HLA::Nomenclature::AmbiguousGroups](https://metacpan.org/pod/Bio::HLA::Nomenclature::AmbiguousGroups)
