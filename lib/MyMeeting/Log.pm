package MyMeeting::Log;

use strict;
use warnings;

use Log::Fast;

use constant {
    DEFAULT_LOGFILE => '/var/log/mymeeting/mymeeting.log',
    DEFAULT_LEVEL   => 'INFO',
};

sub init {
    my %params = @_;

    my $logfile  = $params{logfile} || DEFAULT_LOGFILE;
    my $loglevel = $params{level} || DEFAULT_LEVEL;
    open( my $fh, '>>', $logfile ) or warn "cannot open log file: $!";

    my $logger = Log::Fast->new({
        level   => $loglevel,
        prefix  => '%D %T [%L] ',
        type    => 'fh',
        fh      => $fh ? $fh : \*STDERR,
    });

    return $logger;
}

1;