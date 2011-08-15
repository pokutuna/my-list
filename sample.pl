use strict;
use warnings;

BEGIN {
    unshift @INC, "lib";
}
use My::List;

my $list = My::List->new;

$list->append("Hello");
$list->append("World");
$list->append(2011);

my $iter = $list->iterator;
while ($iter->has_next) {
    print $iter->next->value;
}
