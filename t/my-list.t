package test::My::List;

use strict;
use warnings;
use base qw(Test::Class);
use Test::More;

use My::List;

sub init : Test(1) {
    new_ok 'My::List';
}

sub list : Tests {
    my $list = My::List->new;
    ok defined $list->root, 'root defined';
    ok defined $list->tail, 'tail defined';
    is_deeply $list->root, $list->tail;
    ok !$list->root->value ;
    ok !$list->root->prev;
    ok !$list->root->next ;

    $list->append("hoge");
    is $list->tail->value, 'hoge';
    is_deeply $list->tail->prev, $list->root;
    is_deeply $list->root->next, $list->tail;

    $list->append("fuga");
    $list->append("piyo");
    is $list->tail->value, 'piyo';
    is $list->tail->prev->value, 'fuga';
    is $list->root->next->next->value, 'fuga';

    my $itr = $list->iterator;
    ok $itr->has_next;
    is $itr->next->value, 'hoge';

    ok $itr->has_next;
    is $itr->next->value, 'fuga';

    ok$itr->has_next;
    is $itr->next->value, 'piyo';

    ok !$itr->has_next;

    $list->append('foo');
    ok $itr->has_next;
    is $itr->next->value, 'foo';

    ok !$itr->has_next;

    my $itr2 = $list->iterator;
    isnt $itr, $itr2;
}

__PACKAGE__->runtests;

1;


