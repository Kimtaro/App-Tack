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
# TODO: Better handling of optional <ARG> interpolations
our @templates = (
  App::Tack::Template->new('map', '\b(def|class|module|private|protected)\b', 'Map Ruby files'),
  App::Tack::Template->new('name', sub {
    my $options = shift;
    my $name = shift @$options;
    
    $name =~ s/_/_\?/;
    
    return(["\\b($name)\\b", '-i']);
  }, 'Find the named symbol. Takes one required argument'),
  App::Tack::Template->new('(sub|def|func(t(i(o(n)?)?)?)?)', '\b(sub|def|function)(?:\s*<ARG>)?\b', 'Find subs/defs/functions. Takes one optional argument'),
);

sub run {
  my $command = shift || '';
  my @options = @_;
  
  # TODO: Use Getopts::Long
  if ( $command eq '' ) {
    print_help();
    print "\n";
    print_templates();
    exit;
  }
  elsif ( $command =~ /--templates/ix ) {
    print_templates();
    exit;
  }
  elsif ( $command =~ /--? h (e (l (p)?)?)?/ix) {
    print_help();
    exit;
  }
  
  foreach my $template ( @templates ) {
    if ( $command =~ $template->name ) {
      my($pattern, $ack_opts) = @{&{$template->pattern}(\@options)};
      
      # Check for interpolations
      while ( $pattern =~ m/<ARG>/ && scalar(@options) > 0 ) {
        my $replacement = shift @options;
        $pattern =~ s/<ARG>/$replacement/;
      }
      
      # Remaining @options are flags to ack and must come first
      # This includes the files ack should scan
      $ack_opts .= ' ' . join(' ', @options);
      
      # Run
      my $ack = "ack $ack_opts --match '$pattern'";
      print "Running: " . $ack . "\n";
      system($ack);
    }
  }
}

sub print_help {
  print <<END;
== Usage

- tack template_name [template interpolations] [ack files and options]
  Run ack with the named template
- tack --h|he|hel|help
  Show this help
- tack --templates
  Print available templates
END
}

sub print_templates {
  print "== Available templates\n\n";
  foreach my $template ( @templates ) {
    print '-> ' . $template->comment . "\n";
    print '   Name: ' . $template->name . "\n";
    print '   Pattern: ' . @{&{$template->pattern}(['ARG', 'ARG', 'ARG', 'ARG'])}[0] . "\n\n";
  }
}

1; # End of App::Tack
