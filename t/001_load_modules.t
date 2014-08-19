#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 9;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

my @modules = qw/ MyMeeting::Sessions MyMeeting::JSON MyMeeting::Error
            MyMeeting::Log MyMeeting::Config MyMeeting::Parser MyMeeting::Parser::PBX
            MyMeeting::Parser::Client MyMeeting /;

require_ok( $_ ) for ( @modules );

done_testing();