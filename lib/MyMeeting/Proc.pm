package MyMeeting::Proc;

=encoding utf8

=head1 NAME

MyMeeting::Proc

=head1 DESCRIPTION

Базовый класс для работы с сообщениями клиентов и pbx

=cut

use strict;
use warnings;
use Attribute::Protected;

use AnyEvent::Handle;

use MyMeeting::JSON;
use MyMeeting::Sessions;

sub new {
    my $class = shift;

    my $self = bless { _sessions => MyMeeting::Sessions->new }, $class;
    return $self;
}

sub _sessions : Protected {
    my $self = shift;

    $self->{_sessions} ||= MyMeeting::Sessions->new;
    return $self->{_sessions};
}

1;