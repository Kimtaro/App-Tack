package App::Tack::Template;

use warnings;
use strict;
use Data::Dumper;

sub new {
	my $class   = shift;
	my $name    = shift;
	my $pattern = shift;
	my $comment = shift;

	my $self = bless {
		name => $name,
		pattern => $pattern,
		comment => ($comment || ''),
	}, $class;

	return $self;
}

sub name { return shift->{name}; }
sub pattern { return shift->{pattern}; }
sub comment { return shift->{comment}; }

1; # End of App::Tack::Template
