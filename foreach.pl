#!/usr/bin/perl

#!c:\Perl\site\bin\perl -w
foreach $x (1..9) {
    foreach(1..$x) {
        print "$x x $_=".$x*$_."  ";
    }
    print "\n"
}

#for $x(1..9){print map{"$_*$x=".$_*$x."\t".($_==$x?"\n":'')}1..$x;}




