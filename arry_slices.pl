#!/usr/bin/perl

#Purpose: to explain lists, slices, ranges,etc.

#print (qw(Boston Charotte Newyork Miami));
#print (qw(Boston Charotte Newyork Miami)[0,1]);
#print (qw(Boston Charotte Newyork Miami)[0..2,3]);

@uscities = qw(Boston Charotte Newyork Miami Columbia Atlanta Dallas Houston);
print "@uscities\n";
print "@uscities[0,2]\n";
print "@uscities[0..2]\n";
print "@uscities[0..$#uscities]\n";

@eastcities = @uscities[1..3,7,8];
print "@eastcities[0,1]\n";
print "East cities: ", "@eastcities\n";
print "Other cities: ", "@uscities[0,4..6]\n";


