package MyMeeting::Log;

use strict;
use warnings;
use Attribute::Protected;

use Log::Fast;

use constant {
    DEFAULT_LOGFILE => '/var/log/mymeeting/mymeeting.log',
    DEFAULT_LEVEL   => 'INFO',
};

use parent 'Exporter';

our @EXPORT = qw/ has_logger /;


sub new {
    my ( $class, %params ) = @_;

    my $logfile  = $params{logfile} || DEFAULT_LOGFILE;
    my $loglevel = $params{level} ? uc $params{level} : DEFAULT_LEVEL;

    my $self = bless {}, $class;
    $self->_init_logger( $logfile, $loglevel );

    return $self;
}

sub info {
    my ( $self, $message ) = @_;

    $self->_log( 'info', $message );
}

sub debug {
    my ( $self, $message ) = @_;

    $self->_log( 'debug', $message );
}

sub has_logger {
    my $class = (caller)[0];
    {
        no strict 'refs';
        my $logger = __PACKAGE__->new;
        *{"$class\::logger"} = sub { $logger };
    }
}

######## private methods #########

sub _init_logger : Private {
    my ( $self, $logfile, $loglevel ) = @_;

    open( my $fh, '>>', $logfile ) or warn "cannot open log file: $!";

    $self->{_logger} = Log::Fast->new( {
        level   => $loglevel,
        prefix  => '[%D %T] [%L] ',
        type => 'fh',
        fh => $fh ? $fh : \*STDERR,
    } );

    return 1;
}

sub _log : Private {
    my ( $self, $level, $message ) = @_;

    $level = uc $level;
    $self->_logger->level( $level );
    $self->_logger->$level( $message );

    return 1;
}

sub _logger : Private { shift->{_logger} }

1;