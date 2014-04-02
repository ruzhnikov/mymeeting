package MyMeeting::Server;

use strict;
use warnings;

use AnyEvent::Socket;

use constant {
    DEFAULT_ADDRESS => '127.0.0.1',
    DEFAULT_PORT    => 60020,
};

sub new {
    my ( $class, %params ) = shift;

    $params{server_address} ||= DEFAULT_ADDRESS;
    $params{server_port}    ||= DEFAULT_PORT;

    my $self = bless { %params }, $class;

    $self->_init;

    return $self;
}

sub _init {
    my ( $self ) = @_;

    # ...
}

1;