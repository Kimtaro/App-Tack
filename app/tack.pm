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

# TODO: How to insert a constant into a regex?
# TODO: Handle flags for patterns
# TODO: Better handling of optional <TACK> interpolations
our @templates = (
  App::Tack::Template->new('map', '\b(def|class|module|private|protected)\b', 'Map Ruby files'),
  App::Tack::Template->new('(sub|def|func(t(i(o(n)?)?)?)?)', '\b(sub|def|function)(?:\s*<TACK>)?\b', 'Find subs/defs/functions, with optional name'),
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
      my $pattern = $template->pattern;
      
      # Check for interpolations
      while ( $pattern =~ m/<TACK>/ && scalar(@options) > 0 ) {
        my $replacement = shift @options;
        $pattern =~ s/<TACK>/$replacement/;
      }
      
      # Remaining @options are flags to ack and must come first
      # This includes the files ack should scan
      my $ack_opts = join(' ', @options);
      
      # Run
      my $ack = "ack $ack_opts --match '$pattern'";
      print $ack . "\n";
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
    print '- ' . $template->name . ' - ' . $template->comment .  "\n  " . $template->pattern . "\n";
  }
}

1; # End of App::Tack
