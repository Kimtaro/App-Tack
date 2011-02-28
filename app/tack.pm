package App::Tack;

use warnings;
use strict;
use Data::Dumper;

our $VERSION;
our $COPYRIGHT;
BEGIN {
    $VERSION = '0.1';
    $COPYRIGHT = 'Copyright 2011 Kim Ahlström.';
}

use App::Tack::Template;

our @templates = (
	App::Tack::Template->new(qr{map}, qr{\b (def|class|module|private|protected) \b}),
	App::Tack::Template->new(qr{sub}, qr{sub \s+ <TACK>}),
);

sub run {
	my $command = shift;
	my @options = @_;
	
	foreach my $template ( @templates ) {
		if ( $command =~ $template->name ) {
			print "hej\n";
		}
	}
}

1; # End of App::Tack
