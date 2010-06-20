package Net::WassrMinus;
use strict;
use warnings;
use utf8;

use Carp;
use JSON;
use LWP::UserAgent;
use Readonly;

use Net::WassrMinus::API;

Readonly my $NET_LOCATON => 'api.wassr.jp:80';
Readonly my $REALM       => 'API Authentication';

my $post = sub {
    my ($ua, $url, $options) = (@_);
    my $response = $ua->post($url, $options);

    croak 'Bad Request: ', $response->as_string if not $response->is_success;

    my $status = decode_json($response->decoded_content);
    croak 'Bad Response: ', $status->{error} if $status->{error};

    return $status;
};

my $get = sub {
    my ($ua, $url, $options) = (@_);
    my $response = $ua->post($url, $options);

    croak 'Bad Request: ', $response->as_string if not $response->is_success;

    return decode_json($response->decoded_content);
};

sub new {
    my ($class, $options) = (@_);

    $options->{user}     ||= '';
    $options->{password} ||= '';

    my $ua = LWP::UserAgent->new;
    $ua->credentials($NET_LOCATON, $REALM, $options->{user}, $options->{password});

    my $self = {
        ua     => $ua,
        source => $options->{source} || __PACKAGE__,
    };

    return bless $self, $class;
}

sub update {
    my ($self, $tweet, $rid, $image) = (@_);
    return $post->(
        $self->{ua}, $UPDATE_API,
        {
            source           => $self->{source},
            status           => $tweet,
            reply_status_rid => $rid   || '',
            image            => $image || '',
        },
    );
}

sub user_timeline {
    my ($self, $user) = (@_);
    return $get->( $self->{ua}, $USER_TIMELINE_API, { id => $user } );
}

sub friends_timeline {
    my ($self, $user, $page) = (@_);
    return $get->(
        $self->{ua}, $FRIENDS_TIMELINE_API,
        {
            id   => $user,
            page => $page || 1,
        },
    );
}

#FIXME: for some resones, status code 500 returns
sub public_timeline {
    my ($self) = (@_);
    return $get->( $self->{ua}, $PUBLIC_TIMELINE_API);
}

#FIXME: for some resones, status code 500 returns
sub replies {
    my ($self) = (@_);
    return $get->( $self->{ua}, $REPLIES_API);
}

sub show {
    my ($self, $user) = (@_);
    return $get->( $self->{ua}, $SHOW_API, { id => $user });
}

1;
