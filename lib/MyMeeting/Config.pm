package MyMeeting::Config;

=encoding utf8

=head1 NAME

MyMeeting::Config

=head1 DESCRIPTION

Класс для получения данных из конфигурационных файлов

=cut

use strict;
use warnings;
use YAML::Syck ();
use File::Spec;

use constant {
    CONF_DIR    => '/etc/mymeeting',
    CONF_FILE   => 'config.yaml',
};

=head1 METHODS

=over

=item B<new>

Конструктор

=cut

sub new {
    my $class = shift;

    my $self = bless {}, $class;
    $self->_get_config;

    return $self;
}

sub _get_config {
    my $self = shift;

    my $data;
    my $confg_file = CONF_DIR . '/' . CONF_FILE;

    if ( -e $confg_file ) {
        $data = YAML::Syck::LoadFile( $confg_file );
    }
    else {
        $data = get( CONF_FILE );
    }

    $self->{_data} = $data;
}

=item B<general>

Секция "general" из конфиграционного файла configs.yaml

=cut

sub general {
    my $self = shift;

    $self->{_data} ||= $self->_get_config;

    if ( $self->{_data} && $self->{_data}->{general} ) {
        return $self->{_data}->{general};
    }

    return {};
}

=item B<pbx>

Секция "pbx" из конфиграционного файла configs.yaml

=cut

sub pbx {
    my $self = shift;

    $self->{_data} ||= $self->_get_config;

    if ( $self->{_data} && $self->{_data}->{pbx} ) {
        return $self->{_data}->{pbx};
    }

    return {};
}

=item B<get>

Получить данные из указанного yaml-файла
Имя файла передаётся без расширения

=cut

sub get {
    my $filename = shift;

    return {} unless $filename;

    $filename .= '.yaml' unless $filename =~ m/(\.yaml|\.yml)$/;

    my $conf_dir = _get_conf_dir();
    my $abs_path = $conf_dir . $filename;

    return {} unless -e $abs_path;

    return YAML::Syck::LoadFile( $abs_path );
}

sub _get_conf_dir {
    my $cur_dir = (File::Spec->splitpath( __FILE__ ))[1];
    return $cur_dir . '../../configs/';
}

=back

=head1 AUTHOR

Alexander Ruzhnikov, C<< ruzhnikov85@gmail.com >>

=cut

1;