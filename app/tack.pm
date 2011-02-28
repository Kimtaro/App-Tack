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

# TODO: How to insert a constant into a regex?
# TODO: Handle flags for patterns
our @templates = (
  App::Tack::Template->new('map', '\b(def|class|module|private|protected)\b'),
  App::Tack::Template->new('sub', 'sub\s+<TACK>'),
);

sub run {
  my $command = shift;
  my @options = @_;
  
  # TODO: Use Getopts::Long
  if ( $command =~ /--? h (e (l (p)?)?)?/ix) {
    print_help();
    exit;
  }
  elsif ( $command =~ /--templates/ix ) {
    print_templates();
    exit;
  }
  
  foreach my $template ( @templates ) {
    if ( $command =~ $template->name ) {
      # Check for interpolations
      my $interpolations = 0;
      if ( $template->pattern =~ REPLACE ) {
        
      }
      
      # Remaining @options are flags to ack and must come first
      # This includes the files ack should scan
      my $ack_opts = join(' ', @options);
      
      # Run
      # TODO: How to insert code into a string? Need sprintf or can interpolate?
      my $pattern = $template->pattern;
         $pattern =~ s/^\(\?\w*-?\w*://;
         $pattern =~ s/\)$//;
      my $ack = "ack $ack_opts --match '$pattern'";
      system($ack);
    }
  }
}

sub print_help {
  print <<END;
usage: - tack template_name [template interpolations] [ack files and options]
         Run ack with the template
       - tack --h|he|hel|help
         Show this help
       - tack --templates
         Print available templates
END
}

sub print_templates {
  foreach my $template ( @templates ) {
    print '- ' . $template->name . "\n  " . $template->pattern;
  }
}

1; # End of App::Tack
