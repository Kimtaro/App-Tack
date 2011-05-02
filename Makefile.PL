use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'tack',
  AUTHOR       => 'Kim Ahlström <kim.ahlstrom@gmail.com>',
  ABSTRACT     => 'Templates for Ack',
  VERSION_FROM => 'lib/App/Tack.pm',
  EXE_FILES    => [ 'tack' ],
);