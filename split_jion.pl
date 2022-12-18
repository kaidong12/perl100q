#!/usr/bin/perl

####
# $string = ":K Andy Wu:1:0 0 Alice Long:1:0 1 1 0";
# $string =~ s/(?<=[a-zA-Z])([ ]+)(?=[a-zA-Z])/'-' x length($1)/eg;
#
# print $string, "\n";
#
# @a = split /[ :]/, $string;
#
# print join "\n", @a, "\n";
####

$_= ':K Andy Wu:1:0 0 Alice Long:1:0 1 1 0';
while (/[\:\s]([A-Za-z\s]+|[\d+])/g)
{
  print $1 . "\n";
}
