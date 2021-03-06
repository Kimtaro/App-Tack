package App::Tack::Template;

use warnings;
use strict;
use Data::Dumper;

sub new {
	my $class   = shift;
	my $name    = shift;
	my $pattern = shift;
	my $comment = shift;
	my $sub;

  if ( ref $pattern eq '' ) {
    $sub = sub { [$pattern, ''] };
  }
  else {
    # ref CODE
    $sub = $pattern;
  }

	my $self = bless {
		name => $name,
		pattern => $sub,
		comment => ($comment || ''),
	}, $class;

	return $self;
}

sub name { return shift->{name}; }
sub pattern { return shift->{pattern}; }
sub comment { return shift->{comment}; }

1; # End of App::Tack::Template
