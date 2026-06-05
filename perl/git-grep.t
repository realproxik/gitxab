#!/usr/bin/perl
# git-grep.pl

use strict;
use warnings;

if (@ARGV < 1) {
    print "Usage: git-grep <pattern> [files...]\n";
    exit 1;
}

my $pattern = shift @ARGV;
my @files = @ARGV ? @ARGV : `find . -type f -not -path './.git/*'`;

for my $file (@files) {
    chomp $file;
    next unless -f $file;
    open my $fh, '<', $file or next;
    my $line = 0;
    while (<$fh>) {
        $line++;
        if (/$pattern/) {
            print "$file:$line:$_";
        }
    }
    close $fh;
}