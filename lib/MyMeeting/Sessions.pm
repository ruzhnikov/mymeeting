package MyMeeting::Sessions;

use strict;
use warnings;
use vars qw/ $AUTOLOAD /;
use Attribute::Protected;

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

        $self->_sessions->{ $session } = time();
        return 1;
    }
}

sub get {
    my ( $self, $session ) = @_;

    return $self->_sessions->{ $session };
}

sub delete {
    my ( $self, $session ) = @_;

    return delete $self->_sessions->{ $session };
}

sub check_expr {
    my ( $self, $session, $timeout ) = @_;

    return unless $session;
    return unless $self->_sessions->{ $session };

    $timeout ||= DEFAULT_SESSION_TIMEOUT;

    my $session_time = $self->_sessions->{ $session };
    my $cur_time = time();

    return ( $cur_time - $session_time <= $timeout ) ? 1 : '';
}

sub _sessions : Private {
    my $self = shift;

    $self->{_sessions} ||= {};

    return $self->{_sessions};
}

1;