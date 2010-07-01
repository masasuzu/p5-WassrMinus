#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use Getopt::Long;
use Net::WassrMinus;

sub main {
    # オプション取得
    my ($file, $user, $password);

    GetOptions(
        'file=s'     => \$file,
        'userd=s'    => \$user,
        'password=s' => \$password,
    );

    my $wassr;
    if (defined $file) {
        die 'config is not exist' if (not -f $file);
        $wassr = Net::WassrMinus::new_with_config($file);
    }
    elsif (defined $user and defined $password) {
        $wassr = Net::WassrMinus->new({
            user     => $user,
            password => $password,
        });
    }
    else {
        $wassr = Net::WassrMinus::new_with_config($file);
    }

    # コマンド取得
    while (my $command = get_command()) {
        if ($command ne '' and $command =~ /^q|(quit)$/){
            exit 1;
        }
        elsif (not defined $command or $command =~ /^(help)|(--help)$/ or
            not $command =~ /^(update)|(user)|(friends)|(replies)|(public)|(show)$/ ) {
            help();
            next;
        }
        $command = $command . '_timeline' if $command =~ /^(friends)|(public)|(user)$/;

        my $comments = $wassr->$command;
        for my $comment (@{$comments}) {
            print $comment->{user_login_id}, "\n";
            print encode('sjis', $comment->{text}), "\n";
        }
        $command = undef;
    }

}

sub help {
    #TODO: write help message
    print "commands ; show update friends public user\n";
}

sub get_command {
    print 'command? : ';
    chomp (my $command = <STDIN>);
    return $command eq '' ? 'help' : $command ;
}


main if not caller(0);
