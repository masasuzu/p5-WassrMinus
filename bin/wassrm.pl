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
        $wassr = Net::WassrMinus::new_with_config;
    }

    # コマンド取得
    while (my $command = get_command()) {
        if ($command ne '' and $command =~ /^[eq]|(exit)|(quit)$/){
            exit 1;
        }
        elsif ($command =~ /^(up)|(user)|[fprs]$/) {
            complete(\$command);
        }
        elsif (not defined $command or $command =~ /^(help)|(--help)$/ or
            not $command =~ /^(update)|(user)|(friends)|(replies)|(public)|(show)$/ ) {
            help();
            next;
        }

        $command = $command . '_timeline' if $command =~ /^(friends)|(public)|(user)$/;
        $command eq 'update' ? update($wassr) : print_comment($wassr, $command);
        $command = undef;
    }

}

sub help {
    #TODO: write help message
    print "\ncommands : show update friends public user\n\n";
}

sub get_command {
    print "\ncommand? : ";
    chomp (my $command = <STDIN>);
    return $command eq '' ? 'help' : $command ;
}

sub complete {
    my ($command) = (@_);
    $$command = 'update'   if ($$command eq 'up');
    $$command = 'user'     if ($$command eq 'user');
    $$command = 'friends'  if ($$command eq 'f');
    $$command = 'public'   if ($$command eq 'p');
    $$command = 'replies ' if ($$command eq 'r');
    $$command = 'show'     if ($$command eq 's');
}

sub print_comment {
    my ($wassr, $command) = (@_);

    my $comments = $wassr->$command;
    for my $comment (@{$comments}) {
        print $comment->{user_login_id}, "\n";
        print encode('sjis', $comment->{text}), "\n";
    }
}
# TODO: Implement update function
sub update {
    my ($wassr) = (@_);

    print "\ncomment? > ";
    chomp (my $comment = <STDIN>);
    $wassr->update(decode('sjis', $comment));
}

main if not caller(0);

