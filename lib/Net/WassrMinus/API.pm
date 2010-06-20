package Net::WassrMinus::API;
use strict;
use warnings;
use utf8;

use Exporter;
use Readonly;

our @ISA = qw(Exporter);
our @EXPORT = qw(
    $UPDATE_API  $USER_TIMELINE_API   $FRIENDS_TIMELINE_API
    $REPLIES_API $PUBLIC_TIMELINE_API $SHOW_API
);

Readonly our $BASE_URL             => 'http://api.wassr.jp/statuses/';
Readonly our $UPDATE_API           => $BASE_URL . 'update.json';
Readonly our $USER_TIMELINE_API    => $BASE_URL . 'user_timeline.json';
Readonly our $FRIENDS_TIMELINE_API => $BASE_URL . 'friends_timeline.json';
Readonly our $PUBLIC_TIMELINE_API  => $BASE_URL . 'public_timeline.json';
Readonly our $REPLIES_API          => $BASE_URL . 'replies.json';
Readonly our $SHOW_API             => $BASE_URL . 'show.json';

1;

