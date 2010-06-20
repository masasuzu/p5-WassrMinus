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

our (
    $UPDATE_API,  $USER_TIMELINE_API,   $FRIENDS_TIMELINE_API,
    $REPLIES_API, $PUBLIC_TIMELINE_API, $SHOW_API, $BASE_URL,
);

BEGIN {
    Readonly $BASE_URL             => 'http://api.wassr.jp/statuses/';
    Readonly $UPDATE_API           => $BASE_URL . 'update.json';
    Readonly $USER_TIMELINE_API    => $BASE_URL . 'user_timeline.json';
    Readonly $FRIENDS_TIMELINE_API => $BASE_URL . 'friends_timeline.json';
    Readonly $PUBLIC_TIMELINE_API  => $BASE_URL . 'public_timeline.json';
    Readonly $REPLIES_API          => $BASE_URL . 'replies.json';
    Readonly $SHOW_API             => $BASE_URL . 'show.json';
}

1;

