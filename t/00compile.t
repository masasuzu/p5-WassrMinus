use strict;
use warnings;
use utf8;


use Test::More;

use_ok 'Net::WassrMinus';
use_ok 'Net::WassrMinus::API';

TODO: {
    local $TODO = 'not implemented';
    use_ok 'Net::WassrMinus::Config';
}
use Data::Dumper;

diag $ENV{WASSR_MINUS};

done_testing();
