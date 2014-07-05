#!/usr/bin/env perl

use strict;
use warnings;

use Test::More  tests => 10;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

require_ok( 'MyMeeting::Sessions' );

my $sessions = MyMeeting::Sessions->new;

ok( $sessions, 'create object' );
ok( $sessions->{_sessions}, 'found _sessions' );

ok( $sessions->add( 'test321' ), 'added value' );

my $session_value = $sessions->get( 'test321' );
ok( $session_value, 'get value for session' );
like( $sessions->get( 'test321' ), qr/\d+/, 'value of session is integer' );

ok( $sessions->check_expr( 'test321' ), 'check session timeout' );
ok( $sessions->update( 'test321' ), 'update session' );
ok( $sessions->delete( 'test321' ), 'delete session' );
ok( !$sessions->get( 'test321' ), 'session not found' );

done_testing();