package t::TestApp::Simple;
use strictures 1;
# ABSTRACT: Test application for unit tests.
# COPYRIGHT

BEGIN {
  our $VERSION = '0.001';  # fixed version - NOT handled via DZP::OurPkgVersion.
}

use Dancer2;
use Plack::Builder;
use Dancer2::Plugin::Redis;

############################################################################

get q{/} => sub { 'Hello World' };

get q{/set} => sub {
  no warnings 'uninitialized';
  redis_set param('key'), param('value');
  sprintf 'set %s: %s', param('key'), param('value');
};

get q{/get} => sub {
  no warnings 'uninitialized';
  sprintf 'get %s: %s', param('key'), redis_get param('key');
};

get q{/expire} => sub {
  no warnings 'uninitialized';
  redis_expire param('key'), param('expire');
  sprintf 'expire %s: %s', param('key'), param('expire');
};

############################################################################
builder { psgi_app };
