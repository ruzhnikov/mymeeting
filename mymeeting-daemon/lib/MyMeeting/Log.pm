package MyMeeting::Log;

use strict;
use warnings;

use Log::Log4perl qw/ :easy /;

use constant {
    DEFAULT_LOGFILE => '/var/log/mymeeting/mymeeting.log',
};

sub new {
    my ( $class, %params ) = @_;

    $class = ref $class || $class;

    my $logfile = $params{logfile} || DEFAULT_LOGFILE;

    my $self = bless {}, $class;
    $self->_init( $logfile );
}

sub _init {
    my ( $self, $logfile ) = @_;

    Log::Log4perl->easy_init( {
        level => $DEBUG,
        file => ">>$logfile",
    } );

    $self->{logger} = get_logger();

    return $self;
}

1;