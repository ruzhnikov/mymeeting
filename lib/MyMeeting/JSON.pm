package MyMeeting::JSON;

use strict;
use warnings;
use Attribute::Protected;

use JSON::XS ();
use JSON::Parse qw/ valid_json /;

my $json_obj;

sub validate {
    my $json = shift;

    return unless $json;
    return valid_json( $json );
}

sub to_json {
    my $data = shift;

    return unless $data or ref $data;
    return _get_json()->encode( $data );
}

sub from_json {
    my $json = shift;

    return {} unless $json;
    return _get_json()->decode( $json );
}

sub _get_json : Private {
    $json_obj ||= JSON::XS->new->utf8;

    return $json_obj;
}

1;