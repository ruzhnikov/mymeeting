package MyMeeting::Sessions;

use strict;
use warnings;
use vars qw/ $AUTOLOAD /;

use constant DEFAULT_SESSION_TIMEOUT => 180;

sub new {
    my $class = shift;

    my $self = bless { _sessions => {} }, $class;

    return $self;
}

# for the methods 'add' and 'update'
sub AUTOLOAD {
    my $method = $AUTOLOAD;

    $method =~ s/.*:://;
    if ( $method eq 'add' || $method eq 'update' ) {
        my ( $self, $session ) = @_;

        return unless $session;

        $self->sessions->{ $session } = time();
        return 1;
    }
}

sub sessions {
    my $self = shift;

    $self->{_sessions} ||= {};

    return $self->{_sessions};
}

sub get {
    my ( $self, $session ) = @_;

    return $self->sessions->{ $session };
}

sub delete {
    my ( $self, $session );

    return delete $self->sessions->{ $session };
}

sub check_expr {
    my ( $self, $session, $timeout ) = @_;

    return unless $session;
    return unless $self->sessions->{ $session };

    $timeout ||= DEFAULT_SESSION_TIMEOUT;

    my $session_time = $self->sessions->{ $session };
    my $cur_time = time();

    return ( $cur_time - $session_time <= $timeout ) ? 1 : '';
}

1;