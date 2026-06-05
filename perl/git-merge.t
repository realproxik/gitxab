#!/usr/bin/perl
# git-merge.pl

use strict;
use warnings;

if (@ARGV < 1) {
    print "Usage: git-merge <branch>\n";
    exit 1;
}

my $branch = $ARGV[0];
my $their_sha = `git-core read-ref refs/heads/$branch 2>/dev/null`;
chomp $their_sha;

if (!$their_sha) {
    print "Branch not found: $branch\n";
    exit 1;
}

my $our_sha = `git-core read-ref HEAD 2>/dev/null`;
chomp $our_sha;

if ($our_sha eq $their_sha) {
    print "Already up to date.\n";
    exit 0;
}

# Simple fast-forward merge
my $their_tree = `git-core cat-file -p $their_sha | grep '^tree ' | sed 's/^tree //'`;
chomp $their_tree;

# Write their tree to working directory
system("git-core cat-file -p $their_tree | while read mode sha1 name; do mkdir -p \\$(dirname \"\\$name\"); git-core cat-file -p \\$sha1 > \"\\$name\"; chmod \\$mode \"\\$name\"; done");

# Update HEAD
system("git-core update-ref HEAD $their_sha");

print "Fast-forward merge completed.\n";