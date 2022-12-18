#!/usr/bin/perl

use strict;
my @array1 = ("1","2","3");
    print "Array1 is like this: @array1\n";
my $ppop = pop @array1;
    print "After using pop: @array1\n" ;
    print "ppop is: $ppop\n";
my $laopo = "0";
push @array1,$laopo;
    print "After using push: @array1\n" ;
unshift  @array1,$laopo;
    print "After using unshift: @array1\n" ;
(shift @array1,$laopo) or (my @array11) ;
# shift @array1,$laopo; 
# Useless use of private variable in void context at
    print "After using shift: @array1\n" ;
    print "After using shift: @array11\n" ;

#my @array2 = qw(1 5 3 4 2);
my @array2 = qw(aa bb dd ae ac);
$a = @array2;
print "Array2 has $a elements.\n";
$b = $#array2;
print "Array2's upper bound is: $b \n";
print "Array2 before using Sort: @array2\n";
@array2 = sort @array2;
print "Array2 after using Sort: @array2\n";
