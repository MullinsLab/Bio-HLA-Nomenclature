use strict;
use Test::More;
use Bio::HLA::Nomenclature::AmbiguousGroups;
use Bio::HLA::Nomenclature::Converter;

# XXX TODO: Test parse_allele on new and old nomenclatures, workshop and
# non-workshop, and ambiguous groups to exercise a broad range of cases.

subtest "Converter" => sub {
    my $converter = Bio::HLA::Nomenclature::Converter->new;
    my @converted = map { $converter->from_2009($_) }
        qw(Cw*0432 B*9502 B*1305);

    is_deeply \@converted, [qw[ C*04:32 B*15:102 ], undef];

    @converted = map { $converter->from_2009_group($_) }
        qw(Cw*07G1);
    is_deeply \@converted, [qw[ C*07:01:01G ]];
};

subtest "AmbiguousGroups" => sub {
    my $ambig = Bio::HLA::Nomenclature::AmbiguousGroups->new;
    my @g = map { $ambig->g_group($_) }
        qw(A*01:142 C*12:03:34:01 DQB1*;03:25);

    is_deeply \@g, [qw[ A*01:01:01G C*12:03:34G ], undef];
    
    my @p = map { $ambig->p_group($_) }
        qw(A*01:01:52 B*39:39:02 B*39:57);
    
    is_deeply \@p, [qw[ A*01:01P B*39:39P ], undef];
};

done_testing;
