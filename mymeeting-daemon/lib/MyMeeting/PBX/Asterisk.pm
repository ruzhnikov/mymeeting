package MyMeeting::PBX::Asterisk;

use strict;
use warnings;
use Asterisk::AMI;
use Carp;


sub new {
    my ( $class, %params ) = @_;

    my $self = bless { %params }, $class;
    $self->connect;

    return $self;
}

sub connect {
    my ( $self ) = @_;

    my $pbx = Asterisk::AMI->new(
            PeerAddr => $self->{addr},
            PeerPort => $self->{port},
            Username => $self->{user},
            Secret 	 => $self->{secret}
    );

    confess "can't connect to Asterisk" unless ( $pbx );

    $self->{pbx} = $pbx;

    return 1; 
}

sub pbx {
    my ( $self ) = @_;

    unless ( $self->{pbx} ) {
    	$self->connect;
    }

    return $self->{pbx};
}

1;