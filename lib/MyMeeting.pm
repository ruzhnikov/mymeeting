package MyMeeting;

use strict;
use warnings;
use Attribute::Protected;

use MyMeeting::Config;
use MyMeeting::Log;
use MyMeeting::Error;
use MyMeeting::JSON;
use MyMeeting::Sessions;
use MyMeeting::Proc::PBX;
use MyMeeting::Proc::Client;

use constant {
    ASTERISK_BACKEND_CLASS => 'MyMeeting::Proc::PBX::Asterisk',
};

sub new {
    my $class = shift;

    my $self = bless {}, $class;
    $self->_init;

    return $self;
}

sub config {
    my $self = shift;

    $self->{_config} ||= MyMeeting::Config->new;

    return $self->{_config};
}

sub log {
    my $self = shift;

    $self->_init_log unless $self->{_logger};
    return $self->{_logger};
}

sub sessions {
    my $self = shift;

    $self->{_sessions} ||= MyMeeting::Sessions->new;

    return $self->{_sessions}
}

sub proc_pbx {
    my $self = shift;

    unless ( $self->{_proc_pbx} ) {
        my $pbx_backend = $self->config->pbx->{name};
        if ( $pbx_backend eq 'asterisk' ) {
            $self->{_proc_pbx} = ASTERISK_BACKEND_CLASS->new;
        }
    }

    return $self->{_proc_pbx};
}

sub proc_client {
    my $self = shift;

    $self->{_proc_client} ||= MyMeeting::Proc::Client->new;

    return $self->{_proc_client};
}

######## private methods #########

sub _init : Private {
    my ( $self ) = @_;

    $self->_init_config;
    $self->_init_log;
    $self->_init_sessions;
    $self->_init_proc_pbx;
    $self->_init_proc_client;
}

sub _init_config : Private {
    my $self = shift;

    $self->{_config} = MyMeeting::Config->new;
}

sub _init_log : Private {
    my $self = shift;

    my $logfile = $self->config->data->{logger}->{fh}->{file};
    my $loglevel = $self->config->data->{logger}->{fh}->{level};

    $self->{_logger} = MyMeeting::Log->new(
        logfile => $logfile,
        level   => $loglevel,
    );
}

sub _init_sessions : Private {
    my $self = shift;

    $self->{_sessions} = MyMeeting::Sessions->new;
}

sub _init_proc_pbx : Private {
    my $self = shift;

    $self->{_proc_pbx} = MyMeeting::Proc::PBX->new;
}

sub _init_proc_client : Private {
    my $self = shift;

    $self->{_proc_client} = MyMeeting::Proc::Client->new;
}

1;