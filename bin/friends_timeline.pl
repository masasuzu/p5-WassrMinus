#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Net::WassrMinus;

my $comments = Net::WassrMinus->new_with_config->friends_timeline($ARGV[0]);

for my $comment (@{$comments}) {
    print $comment->{user_login_id}, "\n";
    print encode('sjis', $comment->{text}), "\n";
}

