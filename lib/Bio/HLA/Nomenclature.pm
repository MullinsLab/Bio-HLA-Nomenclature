use 5.010;
use strict;
use warnings;
use utf8;

package Bio::HLA::Nomenclature;
use Moo 2;
use namespace::clean;

our $VERSION = '0.01';


1;
__END__

=encoding utf-8

=head1 NAME

Bio::HLA::Nomenclature - Programmatic handling of HLA allele names

=head1 DESCRIPTION

This library consists of two primary modules.

=head2 Bio::HLA::Nomenclature::Converter

Convert from 2009 and earlier names to the new 2010 nomenclature

=head2 Bio::HLA::Nomenclature::AmbiguousGroups

Lookup an allele's membership in groups of ambiguous alleles

=head1 AUTHOR

Thomas Sibley E<lt>trsibley@uw.eduE<gt>

=head1 COPYRIGHT

Copyright 2015- Thomas Sibley

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Bio::HLA::Nomenclature::Converter>,
L<Bio::HLA::Nomenclature::AmbiguousGroups>

=cut
