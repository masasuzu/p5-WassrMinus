#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Net::WassrMinus;

die 'Not defined comment' if not defined $ARGV[1];

my $config   = "$ENV{WASSR_MINUS}/etc/config.yml";
my $wassr    = Net::WassrMinus->new_with_config($config, $ARGV[0]);
$wassr->update(decode($wassr->{encode}, $ARGV[1]));

