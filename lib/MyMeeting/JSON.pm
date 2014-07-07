package MyMeeting::JSON;

use strict;
use warnings;

use JSON::XS  qw/ decode_json encode_json /;
use JSON::Parse qw/ valid_json /;

sub validate {
    my $json = shift;

    return unless $json;
    return valid_json( $json );
}

sub to_json {
    my $data = shift;

    return unless $data or ref $data;
    return JSON::XS->new->utf8->encode( $data );
}

sub from_json {
    my $json = shift;

    return {} unless $json;
    return JSON::XS->new->utf8->decode( $json );
}

1;