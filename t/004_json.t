#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Data::Dumper;

use Test::More;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

require_ok( 'MyMeeting::JSON' );

my $good_json = q/
    {
        "Key1" : "value1",
        "Key2" : "value2",
        "Ключ3" : "Значение3",
        "Array" : [ "a", "5", "Д", "324" ]
    }
/;

my $bad_json = q/
    {
        "Key1" : "value1",
        "Ключ2" : "value2",
        "key"
    }
/;

my $good_structure = {
    key1    => 'value1',
    key2    => 'value2',
    'ключ'  => 'value3',
    array   => [ qw/ a b c / ],
    hash    => { mykey => 'myval' },
};

ok( MyMeeting::JSON::validate( $good_json ), 'validate correct json' );
ok( !MyMeeting::JSON::validate( $bad_json ), 'validate incorrect json' );

utf8::encode $_ for ( $good_json, $bad_json, $good_structure );

my $data = MyMeeting::JSON::from_json( $good_json );
ok( $data, 'convert to data from json' );
is( $data->{Key1}, 'value1', 'get value from data' );
is( ref $data->{Array}, 'ARRAY', 'get array from data' );
is( scalar keys %{ $data }, 4, 'count of keys in data' );

eval { MyMeeting::JSON::from_json( $bad_json ) };
ok( $@, 'try convert to data bad json' );

my $json = MyMeeting::JSON::to_json( $good_structure );
ok( $json, 'convert to json from data' );

done_testing();