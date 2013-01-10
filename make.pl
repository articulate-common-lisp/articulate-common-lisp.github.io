use strict;
use warnings;
use 5.010;
use File::Basename;

foreach my $FN (split(/\n/, `ls *.md`)) {
    $FN =~ s/^(.+)\.md/$1/g;
    say $FN;
    `pandoc --ascii --smart --normalize --highlight-style=haddock -f markdown -t html5 $FN.md -o output/$FN.html`;
}
