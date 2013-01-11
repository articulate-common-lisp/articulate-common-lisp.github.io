#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use File::Basename;

sub build_banner {
    my ($active, @members) = @_;
    my $html='
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">articulate-lisp.com</a>
          <div class="nav-collapse collapse">
    <ul class="nav">
    ';
    foreach my $fn (@members) {
        my $active_str = '';
        if ($fn eq $active) {
            $active_str = ' class="active" ';
        }
        $html .= "<li $active_str><a href=\"$fn.html\">" . $fn . "</a></li>\n";
    }
    $html .= '</ul>
</div><!--/.nav-collapse -->
        </div>
      </div>
    </div>';

    return $html;
}


my @FNs = map { $_ =~ s/^(.+)\.md/$1/g; $_} split(/\n/, `ls *.md`);
my $fh;

foreach my $FN (@FNs) {
    open( $fh, ">", "banner.html");
    print $fh build_banner($FN, @FNs);
    close $fh;
    my $cmd ="pandoc -B banner.html -A quantcast.html -T 'Articulate Common Lisp' --template=pandoc-data/templates/default.html5 --ascii --smart --normalize --highlight-style=haddock -f markdown -t html5 $FN.md -o site/$FN.html";

    say $cmd;
    `$cmd`;
}

`cp -r src site/`;
