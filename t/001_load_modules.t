#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 6;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

my @modules = qw/ MyMeeting::Sessions MyMeeting::JSON MyMeeting::Error
            MyMeeting::Log MyMeeting::Config MyMeeting /;

for my $module ( @modules ) {
    require_ok( $module );
}

done_testing();