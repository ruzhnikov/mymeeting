package MyMeeting;

use Modern::Perl;
use Carp;
use Config::Tiny;

use MyMeeting::JSON;
use MyMeeting::Server;
use MyMeeting::PBX;
use MyMeeting::Cache;

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

    # ...
}

sub get_config {
    my $file = shift;
    $file ||= DEFAULT_CONFIG_PATH . '/' . DEFAULT_CONFIG_FILE;

    my $data = Config::Tiny->read( $file );
    confess $Config::Tiny::errstr if ( Config::Tiny->errstr );

    return $data;
}

1;