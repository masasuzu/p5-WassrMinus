#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Encode::Guess qw(euc-jp shiftjis utf8);
use Net::WassrMinus;

my $comments = Net::WassrMinus->new_with_config->user_timeline;
for my $comment (@{$comments}) {
    print $comment->{user_login_id}, "\n";
    print encode('Guess', $comment->{text}), "\n";
}

