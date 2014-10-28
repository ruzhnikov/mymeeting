#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

my @modules = qw/ MyMeeting::Sessions MyMeeting::JSON MyMeeting::Error
            MyMeeting::Log MyMeeting::Config MyMeeting::Proc MyMeeting::Proc::Client
            MyMeeting::Proc::PBX MyMeeting::Proc::PBX::Asterisk MyMeeting /;

require_ok( $_ ) for ( @modules );

done_testing();