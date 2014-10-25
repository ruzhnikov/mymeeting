package MyMeeting::Proc::PBX::Asterisk;

use strict;
use warnings;

use Attribute::Protected;

use base 'MyMeeting::Proc::PBX';

# отправляем запрос авторизации на PBX
sub send_auth {
    my ( $self, $auth_data ) = @_;

    # TODO: описать процесс авторизации на PBX

    return 1;
}

# парсим полученные данные от PBX
sub _parse_pbx_data : Private {
    my ( $self, $data ) = @_;
}

# sub _parse : Private {
#     my ( $self, $data ) = @_;

#     my @result = ();
#     my @data_array = split( /\n\n/, $data );

#     for my $struct ( @data_array ) {
#         if ( $struct =~ m/^{/ ) { # json
#             push @result, MyMeeting::JSON::from_json( $struct );
#         }
#         else {  # simple text
#             my $hash;
#             for ( split( /\n/, $struct ) ) {
#                 my ( $key, $value ) = split( /\:/, $_ );
#                 $hash->{ $key } = $value;
#             }
#             push @result, $hash;
#         }
#     }
# }

1;