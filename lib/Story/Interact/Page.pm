use 5.010001;
use strict;
use warnings;

package Story::Interact::Page;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.001001';

use Moo;
use Types::Common -types;
use namespace::clean;

use overload (
	q[bool]  => sub { 1 },
	q[""]    => sub { shift->name },
	fallback => 1,
);

has 'id' => (
	is        => 'ro',
	isa       => Str,
	required  => 1,
);

has 'location' => (
	is        => 'rwp',
	isa       => Str,
	predicate => 1,
);

has 'text' => (
	is        => 'ro',
	isa       => ArrayRef->of( Str ),
	builder   => sub { [] },
);

has 'next_pages' => (
	is        => 'ro',
	isa       => ArrayRef->of(
		Tuple->of(
			NonEmptyStr,
			NonEmptyStr,
			Optional->of( HashRef ),
		),
	),
	builder   => sub { [] },
);

sub add_text {
	my ( $self, $text ) = @_;
	push @{ $self->text }, $text;
	return;
}

sub add_next_page {
	my ( $self, $page_id, $desc, %extra ) = @_;
	push @{ $self->next_pages }, [ $page_id, $desc, \%extra ];
	return;
}

1;
