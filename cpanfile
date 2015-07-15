requires 'perl', '5.010';

requires 'Moo', '2';
requires 'MooX::ClassAttribute';
requires 'Types::Standard';
requires 'namespace::clean';

on test => sub {
    requires 'Test::More', '0.96';
};
