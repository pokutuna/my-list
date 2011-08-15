package My::List::Iterator;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init(@_);
    return $self;
}

sub _init {
    my ($self, $node) = @_;
    $self->{node} = $node;
}

sub has_next {
    my $self = shift;
    defined($self->{node}->{next})
}

sub next {
    my $self = shift;
    $self->{node} = $self->{node}->{next};
    $self->{node};
}

1;
