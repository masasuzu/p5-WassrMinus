use strict;
use warnings;
use utf8;

use Test::More;
use Net::WassrMinus::Config;

use_ok 'Net::WassrMinus::Config';

diag('test overwittern value');
my $config = Net::WassrMinus::Config->new('../etc/config.yml', 'test');
is($config->user,     'wassr');
is($config->password, 'test');

my $raw_config = $config->get;
is($raw_config->{user},     'wassr');
is($raw_config->{password}, 'test');
is($raw_config->{encode},   'utf8');
is($raw_config->{source},   'Test::Agent');

$config     = undef;
$raw_config = undef;

diag('test default value');
$config = Net::WassrMinus::Config->new('../etc/config.yml', 'win');
is($config->user,     'USER');
is($config->password, 'PASSWORD');
is($config->encode,   'sjis');

$raw_config = $config->get;
is($raw_config->{user},     'USER');
is($raw_config->{password}, 'PASSWORD');
is($raw_config->{encode},   'sjis');
is($raw_config->{source},   '');

done_testing();

__DATA__


