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

sub size : Tests {
    my $list = My::List->new;
    cmp_ok $list->size, '==', 0;
    $list->append("hoge");
    cmp_ok $list->size, '==', 1;
    $list->append("hoge");
    cmp_ok $list->size, '==', 2;

    $list->clear;
    cmp_ok $list->size, '==', 0;

    my $rand = int(rand() * 100);
    $list->append($_) for 1..$rand;
    cmp_ok $list->size, '==', $rand;
}

sub node_at : Tests {
    my $list = My::List->new;
    $list->append('hoge');
    $list->append('fuga');
    $list->append('piyo');
    cmp_ok $list->node_at(1)->value, 'eq', 'fuga';
    cmp_ok $list->node_at(2)->value, 'eq', 'piyo';
    cmp_ok $list->node_at(0)->value, 'eq', 'hoge';
    ok !$list->node_at(-1);
    ok !$list->node_at;
    $list->clear;
    ok !$list->node_at(0);
}

sub clear : Tests {
    my $list = My::List->new;
    $list->append("hoge");
    $list->append([1,2,3]);
    ok $list->root->next;
    $list->clear;
    ok !$list->root->next;
}

sub remove : Tests {
    my $list = My::List->new;
    $list->append($_) for 0..10;

    my $itr = $list->iterator;
    cmp_ok $itr->next->value, '==', 0;

    my $node1 = $itr->next;
    my $node2 = $itr->next;
    my $node3 = $itr->next;
    cmp_ok $node1->value, '==', 1;
    cmp_ok $node2->value, '==', 2;
    cmp_ok $node3->value, '==', 3;
    $node2->remove;
    cmp_ok $node1->next->value, '==', 3;
    cmp_ok $node3->prev->value, '==', 1;
    cmp_ok $node3->next->value, '==', 4;
}


__PACKAGE__->runtests;

1;


