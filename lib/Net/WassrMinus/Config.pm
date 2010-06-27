package Net::WassrMinus::Config;
use strict;
use warnings;
use utf8;

use YAML::Tiny;
use Data::Dumper;

my %config_of;
my $error_mode;

sub new {
    my ($class, $file_name, $environment, $error_mode) = (@_);

    my $self     = bless {}, $class;

    $file_name   ||= $ENV{WASSR_MINUS} . '/etc/config.yml';
    $environment ||= 'wassrm';
    $self->_load_file($file_name, $environment);

    return $self;
}

sub _load_file {
    my ($self, $file_name, $environment) = (@_);
    my $yaml = YAML::Tiny->read($file_name);

    %config_of = (
        user     => $yaml->[0]->{$environment}->{user}     || '',
        password => $yaml->[0]->{$environment}->{password} || '',
    );
}

sub to_hash_ref {
    my $self = shift;
    return \%config_of;
}

sub password {
    $config_of{password} = $_[1] if defined $_[1];
    return $config_of{password};
}

sub user {
    $config_of{user} = $_[1] if defined $_[1];
    $config_of{user};
}

1;
