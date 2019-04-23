# Purpose: create, read, and update a node with charset => UTF-8

use strict;
use Wiki::Toolkit::TestLib;
use Test::More;

if ( scalar @Wiki::Toolkit::TestLib::wiki_info == 0 ) {
    plan skip_all => "no backends configured";
} else {
    plan tests => scalar @Wiki::Toolkit::TestLib::wiki_info;
}

my $node_name = "\x{3a3}";
my $content   = 'Irrelevant';

my $iterator = Wiki::Toolkit::TestLib->new_wiki_maker;

while ( my $wiki = $iterator->new_wiki ) {
    my $store = $wiki->store;
    my ($db_engine) = ref($store) =~/([^:]+$)/;
    $store->{_charset} = 'UTF-8';

    # Test a simple write
    ok (eval { $wiki->write_node($node_name, $content) },
        "$db_engine: write_node with non-ASCII name" );
    if ($@) { diag "Died with error message:\n$@"; }
}
