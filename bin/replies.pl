#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Net::WassrMinus;

my $config   = "$ENV{WASSR_MINUS}/etc/config.yml";
my $wassr    = Net::WassrMinus->new_with_config($config, $ARGV[0]);
my $comments = $wassr->replies;

for my $comment (@{$comments}) {
    print $comment->{user_login_id}, "\n";
    print encode($wassr->{encode}, $comment->{text}), "\n";
}

