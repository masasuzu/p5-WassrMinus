#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode;
use English;
use Getopt::Long;
use Net::WassrMinus;

sub main {
    # オプション取得
    my ($file, $environment, $user, $password);

    GetOptions(
        'file=s'        => \$file,
        'environment=s' => \$environment,
        'userd=s'       => \$user,
        'password=s'    => \$password,
    );

    my $wassr;
    if (defined $user and defined $password) {
        $wassr = Net::WassrMinus->new({
            user     => $user,
            password => $password,
        });
    }
    else {
        warn 'Config file does not exist and use default config file'
            if (not defined $file or not -f $file);
        $wassr = Net::WassrMinus->new_with_config($file, $environment);
    }

    # コマンド取得
    while (my $command = get_command()) {
        if ($command =~ /^[eq]|(exit)|(quit)$/){
            exit 1;
        }
        elsif ($command =~ /^(up)|(user)|[fprs]$/) {
            complete(\$command);
        }
        elsif ($command !~ /^(update)|(user)|(friends)|(replies)|(public)|(show)$/) {
            help();
            $command = undef;
            next;
        }
        else {
            # Unexpected
            die 'unexpected command';
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
    return $command ? $command : 'help' ;
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

    $OSNAME eq 'MSWin32'? system('cls') : system('clear');
    my $comments = $wassr->$command;
    for my $comment (@{$comments}) {
        print $comment->{user_login_id}, "\n";
        print encode($wassr->{encode}, $comment->{text}), "\n";
    }
}
# TODO: Implement update function
sub update {
    my ($wassr) = (@_);

    print "\ncomment? > ";
    chomp (my $comment = <STDIN>);
    $wassr->update(decode($wassr->{encode}, $comment));
}

main if not caller(0);

