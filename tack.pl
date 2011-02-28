#!/usr/bin/env perl

package App::Tack;

use warnings;
use strict;

our $VERSION;
our $COPYRIGHT;
BEGIN {
    $VERSION = '0.1';
    $COPYRIGHT = 'Copyright 2011 Kim Ahlström.';
}

our @names = (
	App::Tack::Template->new('map', /\b (def|class|module|private|protected) \b/ix),
	App::Tack::Template->new('sub', /sub \s+ ___/ix),
);

sub run {
	my $command = shift;
	my @options = @_;
	
	foreach ( my $template, @names ) {
		if ( $command eq $template->name ) {
			
		}
	}
}

1; # End of App::Tack

package App::Tack::Template;

use warnings;
use strict;

sub new {
	my $class   = shift;
	my $name    = shift;
	my $pattern = shift;
	
	my $self = bless {
		name => $name,
		pattern => $pattern,
	}, $class;
	
	return $self;
}

sub name { return shift->{name}; }
sub pattern { return shift->{pattern}; }

1; # End of App::Tack::Template
