#!/usr/bin/perl
# git-diff.pl

use strict;
use warnings;

sub read_file {
    my ($file) = @_;
    open my $fh, '<', $file or return [];
    my @lines = <$fh>;
    close $fh;
    chomp @lines;
    return \@lines;
}

sub lcs {
    my ($a, $b) = @_;
    my @a = @$a;
    my @b = @$b;
    my @lcs;
    
    my @c;
    for my $i (0..$#a) {
        for my $j (0..$#b) {
            if ($a[$i] eq $b[$j]) {
                $c[$i][$j] = ($i && $j) ? $c[$i-1][$j-1] + 1 : 1;
            } else {
                $c[$i][$j] = 0;
            }
        }
    }
    
    # Simple diff output
    my $i = 0; my $j = 0;
    while ($i <= $#a || $j <= $#b) {
        if ($i <= $#a && $j <= $#b && $a[$i] eq $b[$j]) {
            print " $a[$i]\n";
            $i++; $j++;
        } elsif ($j <= $#b && ($i > $#a || !grep { $_ eq $b[$j] } @a[$i..$#a])) {
            print "+$b[$j]\n";
            $j++;
        } else {
            print "-$a[$i]\n" if $i <= $#a;
            $i++;
        }
    }
}

if (@ARGV < 1) {
    print "Usage: git-diff <file>\n";
    exit 1;
}

my $file = $ARGV[0];
my $index = `git-core read-index 2>/dev/null`;
my ($sha1) = $index =~ /^\S+\s+(\S+)\s+\Q$file\E$/m;

if (!$sha1) {
    print "File not in index\n";
    exit 1;
}

my $tmp = "/tmp/git-diff-$$";
system("git-core cat-file -p $sha1 > $tmp");

my $old = read_file($tmp);
my $new = read_file($file);

lcs($old, $new);
unlink($tmp);