package MyMeeting;

use strict;
use warnings;
use Carp;
use Config::Tiny;

use MyMeeting::Server;
use MyMeeting::PBX;
use MyMeeting::Cache;
use MyMeeting::JSON;

use constant {
    DEFAULT_CONFIG_PATH => '/etc/mymeeting',
    DEFAULT_CONFIG_FILE => 'mymeeting.conf',
};

sub new {
    my $class = shift;

    my $self = bless {}, $class;
    $self->_init;

    return $self;
}

sub _init {
    my ( $self ) = @_;

    $self->_init_pbx;
    # ...
}

sub _init_pbx {
    my ( $self ) = @_;

    my %config = get_config()->{pbx};
    my $backend = delete $config{backend};
    $backend = lc $backend;
    $backend = ucfirst $backend;
    $MyMeeting::PBX::BACKEND = $backend;
    $self->{pbx} = MyMeeting::PBX->new( %config );

    return 1;
}

sub get_config {
    my $file = shift;
    $file ||= DEFAULT_CONFIG_PATH . '/' . DEFAULT_CONFIG_FILE;

    my $data = Config::Tiny->read( $file );
    confess $Config::Tiny::errstr if ( Config::Tiny->errstr );

    return $data;
}

sub pbx {
    my ( $self ) = @_;

    unless ( $self->{pbx} ) {
        $self->_init_pbx;
    }

    return $self->{pbx};
}

1;