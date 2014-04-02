package MyMeeting::Error;

use strict;
use warnings;

use YAML::Tiny;

use constant {
    DEFAULT_ERROR => 'UNKNOWN_ERROR',
    ERRORS_FILE   => 'Error/errors.yml',
};

sub new_error {
    my ( $error, $action_id, $action ) = shift, shift;

    $error ||= DEFAULT_ERROR;

    my $get_errors = get_errors();
    $error = DEFAULT_ERROR unless ( $get_errors->{ $error } );

    my $res = {
        error       => $error,
        error_code  => $get_errors->{ $error }->{code},
        error_msg   => $get_errors->{ $error }->{text},
        action_id   => $action_id || '',
        action      => $action || '',
    };

    return $res;
}

sub get_errors {
    return YAML::Tiny->read( ERRORS_FILE );
}

1;