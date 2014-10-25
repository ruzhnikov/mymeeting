package MyMeeting::Proc::PBX;

use strict;
use warnings;
use Attribute::Protected;

# use MyMeeting::JSON;
# use MyMeeting::Error;

use base 'MyMeeting::Proc';

sub read_pbx_data {
    my ( $self, $data ) = @_;

    my $struct_data = $self->_parse_pbx_data( $data );

    # TODO: идём дальше
}

1;