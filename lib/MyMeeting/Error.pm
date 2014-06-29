package MyMeeting::Error;

use strict;
use warnings;

use MyMeeting::Config;

use constant {
    DEFAULT_ERROR   => 'UNKNOWN_ERROR',
    DEFAULT_CODE    => 999,
    DEFAULT_TEXT    => 'Unknown Error',
};

sub new_error {
    my %params = @_;

    my $error  = $params{error} || DEFAULT_ERROR;
    my $action = $params{action} || '';
    my $action_id = $params{action_id} || '';
    my $note = $params{note} || '';

    my $get_errors = MyMeeting::Config::get( 'errors' );
    if ( scalar keys %{ $get_errors } == 0 || ! $get_errors->{ $error } ) {
        $get_errors = {
            error   => DEFAULT_ERROR,
            error_code  => DEFAULT_CODE,
            error_msg   => DEFAULT_TEXT,
        };
    }

    my $res = {
        error       => $error,
        error_code  => $get_errors->{ $error }->{code},
        error_msg   => $get_errors->{ $error }->{text},
        action_id   => $action_id,
        action      => $action,
        note        => $note,
    };

    return $res;
}


1;