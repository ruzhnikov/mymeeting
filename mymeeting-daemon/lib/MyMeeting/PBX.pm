package MyMeeting::PBX;

use strict;
use warnings;
use Carp;
use Class::Load qw/ load_class /;

use constant {
    DEFAULT_BACKEND => 'Asterisk',
};

use constant NECESSARY_PARAMS => qw/ user secret addr port /;
use constant ALLOW_BACKENDS   => qw/ Asterisk /;

our $BACKEND ||= DEFAULT_BACKEND;

sub new {
    my ( $class, %params ) = @_;

    for my $param ( NECESSARY_PARAMS ) {
        confess "param $param needed!" unless ( $params{ $param } );
    }

    my $self = bless {}, $class;
    $self->_init( %params );

    return $self->{backend};
}

sub _init {
    my ( $self, %params ) = @_;

    my $res;
    for ( ALLOW_BACKENDS ) {
        $res = 1 if ( $BACKEND eq $_ );
    }

    unless ( $res ) {
        confess "backend $BACKEND is not allowed";
    }

    my $backend_class = __PACKAGE__ . '::' . $BACKEND;
    load_class $backend_class;

    $self->{backend} = $backend_class->new( %params );

    return 1;
}

1;