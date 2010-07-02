#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Encode::Guess qw(euc-jp shiftjis utf8);
use Net::WassrMinus;

die 'Not defined comment' if not defined $ARGV[0];

Net::WassrMinus->new_with_config->update(decode('Guess', $ARGV[0]));

