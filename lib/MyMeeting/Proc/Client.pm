package MyMeeting::Proc::Client;

use strict;
use warnings;
use Attribute::Protected;

use MyMeeting::JSON;
use MyMeeting::Error;

use parent 'MyMeeting::Proc';

# послать сообщения всем "живым" клиентам
sub send_data_to_clients {
    my ( $self, $data ) = @_;

    for my $session ( $self->_sessions->get_all ) {
        $self->send_data_to_client( $data, $session );
    }
}

sub send_data_to_client {
    my ( $self, $data, $client ) = @_;

    $data = MyMeeting::JSON::to_json( $data ) if ref $data eq 'HASH';
    AnyEvent::Handle->new( fh => $client )->push_write( $data );
}

sub read_client_data {
    my ( $self, $json ) = @_;

    unless ( MyMeeting::JSON::validate( $json ) ) {
        return MyMeeting::Error::new_error(
            error => 'WRONG_JSON',
            type => 'Action',
            note => 'Validate',
        );
    }

    my $data_hash = MyMeeting::JSON::from_json( $json );
}

1;