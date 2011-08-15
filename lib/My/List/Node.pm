package My::List::Node;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init;
    return $self;
}

sub _init {
    my $self = shift;
    $self->{prev} = undef;
    $self->{value} = undef;
    $self->{next} = undef;
}

sub value {
    my $self = shift;
    return $self->{value};
}

sub remove{
    my $self = shift;
    $self->{prev}->{next} = $self->{next};
    $self->{next}->{prev} = $self->{prev};
}

1;

