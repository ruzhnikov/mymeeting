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
    return encode_json( $data );
}

sub from_json {
    my $json = shift;

    return {} unless $json;
    return decode_json( $json );
}

1;