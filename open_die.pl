#!/usr/bin/perl
use warnings;
use strict;

open (han1,">>logfile.txt") || die "Errors opening file: $!";
log_message();
# my $ww = <han1>;
# print "$ww";

sub log_message{
my $current_time = localtime;
print "$current_time", "\n";

}