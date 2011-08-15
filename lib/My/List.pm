package My::List;

use strict;
use warnings;

use My::List::Node;
use My::List::Iterator;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init;
    return $self;
}

sub _init {
    my $self = shift;
    my $node = My::List::Node->new;
    $self->{root} = $node;
    $self->{tail} = $node;
}

sub append {
    my ($self, $data) = @_;
    my $node = My::List::Node->new;

    $node->{value} = $data;
    $node->{prev} = $self->{tail};
    $self->{tail}->{next} = $node;
    $self->{tail} = $node;
}

sub iterator {
    my $self = shift;
    my $itr = My::List::Iterator->new($self->{root});
    return $itr;
}

1;
