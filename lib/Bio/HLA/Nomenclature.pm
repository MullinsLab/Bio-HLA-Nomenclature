use 5.010;
use strict;
use warnings;
use utf8;

=encoding utf-8

=head1 NAME

Bio::HLA::Nomenclature - Programmatic handling of HLA allele names

=head1 DESCRIPTION

This library consists of three primary modules.

=head2 Bio::HLA::Nomenclature

Parse allele designations into their component parts

=head2 Bio::HLA::Nomenclature::Converter

Convert from 2009 and earlier names to the new 2010 nomenclature

=head2 Bio::HLA::Nomenclature::AmbiguousGroups

Lookup an allele's membership in groups of ambiguous alleles

=head1 METHODS

=cut

package Bio::HLA::Nomenclature;
use Moo 2;
use namespace::clean;

our $VERSION = '0.01';

=head2 parse_allele

Given a single HLA allele designation, returns a hashref of the component
parts.  If the string is unparseable, returns undef.  Both new (2010 and
onwards) and old (pre-2010) allele syntax is supported.

The following keys are always returned in the hashref, but some may be C<undef>
if not applicable or not provided:

=over

=item locus

=item workshop

=item type

=item subtype

=item synonymous_polymorphism

=item utr_polymorphism

=item expression_level

=item ambiguity_group

=back

Refer to L<http://hla.alleles.org/nomenclature/naming.html> for the meaning of
each part.

=cut

sub parse_allele {
    my ($self, $string) = @_;
    return unless $string;

    $string =~ s/^\s+|\s+$//g;

    # Refer to http://hla.alleles.org/nomenclature/naming.html
    #
    # Note that DRB1*121 is the new nomenclature for a set of alleles, but
    # doesn't have a distinguishing colon to give it away.  The old
    # nomenclature _should_ never have a 3-digit type + subtype
    # specification (of course, people do abbreviate, e.g. A*0401 as A*401).

    my %parsed;
    if ($string =~ /:/ or $string =~ /\*\d{3}$/) {
        # new nomenclature
        $string =~ m/^
            (?:HLA-)?
            (?<locus>[A-Z][A-Z0-9]*)(?<workshop>w)?
            \*?
            (?<type>\d+)
            (?: : (?<subtype>\d+)
                (?: : (?<syn_poly>\d+)
                    (?: : (?<utr_poly>\d+))? )? )?
            (?<expression>[NLSCAQ])?
            (?<ambiguity>[PG])?
        $/x;
        %parsed = %+;
    } else {
        $string =~ m/^
            (?:HLA-)?
            (?<locus>[A-Z][A-Z0-9]*)(?<workshop>w)?
            \*?
            (?<type>\d\d)
            (?: (?<subtype>\d\d)
                (?: (?<syn_poly>\d\d)
                        (?<utr_poly>\d\d)? )? )?
            (?<expression>[NLSCAQ])?
            (?<ambiguity>[PG])?
        $/x;
        %parsed = %+;
    }

    # Bad parse!
    return if not $parsed{locus};

    # Make sure all keys exist so we're explicit about missing values.
    $parsed{$_} //= undef
        for qw( locus workshop type subtype syn_poly utr_poly expression ambiguity );

    $parsed{workshop} = $parsed{workshop} ? 'W' : undef;
    $parsed{$_->[1]}  = delete $parsed{$_->[0]} for
        [ syn_poly      => 'synonymous_polymorphism' ],
        [ utr_poly      => 'utr_polymorphism' ],
        [ expression    => 'expression_level' ],
        [ ambiguity     => 'ambiguity_group' ];

    return \%parsed;
}

1;
__END__

=head1 AUTHOR

Thomas Sibley E<lt>trsibley@uw.eduE<gt>

=head1 COPYRIGHT

Copyright 2015-2018 University of Washington

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Bio::HLA::Nomenclature::Converter>,
L<Bio::HLA::Nomenclature::AmbiguousGroups>

=cut
