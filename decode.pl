#!/usr/bin/perl


$line = "-" x 70 ."\n";
print "-" x 70, "\n";
print $line;


use Encode;
use strict;

# my $str = "�й�";
# Encode::_utf8_on($str);
# print length($str) . "\n";
# Encode::_utf8_off($str);
# print length($str) . "\n";



my $a = "china��-�й�";
my $b = "china��-�й�";
Encode::_utf8_on($a);
Encode::_utf8_off($b);
$a =~ s/\W+//g;
$b =~ s/\W+//g;
print $a, "\n";
print $b, "\n";