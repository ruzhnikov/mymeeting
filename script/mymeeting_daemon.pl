#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use AnyEvent;
use AnyEvent::Socket;
use AnyEvent::Handle;

use MyMeeting;

our $VERSION = '0.0.1';

my $data = MyMeeting->new;
my $config = $data->config;

if ( scalar keys %{ $config->pbx } == 0 || scalar keys %{ $config->general } == 0 ) {
    die "Cannot get config file";
}

my $pbx_host = $config->pbx->{pbx_host};
my $pbx_port = $config->pbx->{pbx_port};
my $pbx_user = $config->pbx->{pbx_user};
my $pbx_pass = $config->pbx->{pbx_pass};

my $bind_addr = $config->general->{bind_addr};
my $bind_port = $config->general->{bind_port};

my $cv = AnyEvent->condvar;

tcp_connect $pbx_host, $pbx_port, sub {
    my ( $fh_pbx ) = @_ or die "Cannot connect to PBX: $!";
};

$cv->recv;
