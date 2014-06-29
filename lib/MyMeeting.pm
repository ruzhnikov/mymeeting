package MyMeeting;

use strict;
use warnings;

use MyMeeting::Config;
use MyMeeting::Log;
use MyMeeting::Error;
use MyMeeting::JSON;
use MyMeeting::XML;

sub new {
    my $class = shift;

    my $self = bless {}, $class;
    $self->_init;

    return $self;
}

sub _init {
    my ( $self ) = @_;

    $self->_init_config;
    $self->_init_log;
    $self->_init_errors;
}

sub _init_config {
    my $self = shift;

    $self->{_config} = MyMeeting::Config->new;
}

sub _init_log {
    my $self = shift;

    $self->{_logger} = MyMeeting::Log::init;
}

sub _init_errors {
    my $self = shift;

    # ...
}

sub config {
    my $self = shift;

    $self->{_config} ||= MyMeeting::Config->new;

    return $self->{_config};
}

sub log {
    my $self = shift;

    $self->{_logger} ||= MyMeeting::Log::init;

    return $self->{_logger};
}

1;