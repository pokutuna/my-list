package My::List::Node;

use strict;
use warnings;
use base qw(Class::Accessor);

__PACKAGE__->mk_accessors(qw/prev value next/);

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_init;
    return $self;
}

sub _init {
    my $self = shift;
    $self->prev(undef);
    $self->value(undef);
    $self->next(undef);
}

sub remove{
    my $self = shift;
    $self->prev->next($self->next);
    $self->next->prev($self->prev);
}

1;

