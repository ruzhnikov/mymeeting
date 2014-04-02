#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 7;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

my @modules = qw/ MyMeeting MyMeeting::Server MyMeeting::PBX 
            MyMeeting::Cache MyMeeting::JSON MyMeeting::Error
            MyMeeting::Log /;

for my $module ( @modules ) {
    require_ok( $module );
}

done_testing();