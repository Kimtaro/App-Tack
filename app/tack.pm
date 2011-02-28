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
use constant REPLACE => '<TACK>';

our @templates = (
  App::Tack::Template->new(qr{map}, qr{\b (def|class|module|private|protected) \b}),
  App::Tack::Template->new(qr{sub}, qr{sub \s+ <TACK>}),
);

sub run {
  my $command = shift;
  my @options = @_;
  
  if ( $command =~ /h (e (l (p)?)?)?/ix) {
    print_help();
    exit;
  }
  
  foreach my $template ( @templates ) {
    if ( $command =~ $template->name ) {
      # Check for interpolations
      my $interpolations = 0;
      if ( $template->pattern =~ REPLACE ) {
        
      }
      
      # Remaining @options are flags to ack and must come first
      
      # Execute
      system("ack");
    }
  }
}

sub print_help {
  print <<END;
usage: - tack template_name [template interpolations] [ack options]
         Run ack with the template
       - tack h|he|hel|help
         Show this help
END
}

1; # End of App::Tack
