package A;
use Types::Standard -types;
use slot foo => Int, rw => 1, def => 42;
use slot bar => Str, req => 1;
use slot baz => req => 1, def => 'fnord';
1;


package main;

use strict;
use warnings;
use Test::More;

# Constructor
ok my $o = A->new(foo => 1, bar => 'slack', baz => 'bat'), 'ctor';

# Getters
is $o->foo, 1, 'get slot';
is $o->bar, 'slack', 'get slot';
is $o->baz, 'bat', 'get slot';

# Setters
is $o->foo(4), 4, 'set slot';
is $o->foo, 4, 'slot remains set';

# Validation
ok do{ eval{ A->new(foo => 1, baz => 2) }; $@ }, 'ctor dies w/o req arg';
ok do{ eval{ A->new(bar => 'bar', foo => 'not an int') }; $@ }, 'ctor dies on invalid type';

ok $o = A->new(bar => 'asdf'), 'ctor w/o def args';
is $o->foo, 42, 'get slot w/ def';
is $o->baz, 'fnord', 'get slot w/ def';
is $o->bar, 'asdf', 'get slot w/o def';

done_testing;
