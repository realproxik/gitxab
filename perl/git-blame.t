#!/usr/bin/perl
# git-blame.pl

use strict;
use warnings;

if (@ARGV < 1) {
    print "Usage: git-blame <file>\n";
    exit 1;
}

my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot open $file: $!";
my @lines = <$fh>;
close $fh;

my $commit = `git-core read-ref HEAD 2>/dev/null`;
chomp $commit;

for my $i (0..$#lines) {
    my $sha = substr($commit, 0, 8);
    print "$sha ($i+1) $lines[$i]";
}
