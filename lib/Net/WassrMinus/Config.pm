package Net::WassrMinus::Config;
use strict;
use warnings;
use utf8;

use Carp;
use YAML::Tiny;

sub new {
    my ($class, $file_name, $environment) = (@_);

    my $self = bless {}, $class;

    $file_name   ||= defined $ENV{WASSR_MINUS} ?
                     $ENV{WASSR_MINUS} . '/etc/config.yml':
                     croak 'Not defined $WASSR_MINUS and not specified config file';
    $environment ||= 'default';
    $self->_load_file($file_name, $environment);

    return $self;
}

sub _load_file {
    my ($self, $file_name, $environment) = (@_);
    my $yaml = YAML::Tiny->read($file_name);

    $self->{config} = {
        user     => $yaml->[0]->{$environment}->{user}     ||
                    $yaml->[0]->{'default'   }->{user}     || '',
        password => $yaml->[0]->{$environment}->{password} ||
                    $yaml->[0]->{'default'   }->{password} || '',
        encode   => $yaml->[0]->{$environment}->{encode}   ||
                    $yaml->[0]->{'default'   }->{encode}   || '',
        source   => $yaml->[0]->{$environment}->{source}   ||
                    $yaml->[0]->{'default'   }->{source}   || '',
    };
}

sub password {
    $_[0]->{config}->{password} = $_[1] if defined $_[1];
    return $_[0]->{config}->{password};
}

sub user {
    $_[0]->{config}->{user} = $_[1] if defined $_[1];
    return $_[0]->{config}->{user};
}

sub encode {
    $_[0]->{config}->{encode} = $_[1] if defined $_[1];
    return $_[0]->{config}->{encode};
}

sub get {
    return $_[0]->{config};
}

1;
