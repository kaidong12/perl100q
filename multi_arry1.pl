#!/usr/bin/perl

open(MYFILE,"file3.txt") || die "Error openning file3.$!";
while(<MYFILE>){
       push @array1,[split];
       #push @array1,[split /:/];
       #push @array1,[split /-/];
}
foreach(@array1){
         print "@$_\n";
}

print "\n\none individual element:\n$array1[22][3]\n";
#print "\n\none individual element:\n$array1[0][1]\n";