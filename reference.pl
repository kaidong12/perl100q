#!/usr/bin/perl

@uscities=("Boston","Charlotte","New York","San Francisco");
$uscities=\@uscities;
print "$uscities\n";
print "@{$uscities}\n";


print "$uscities[0].\n";
print "$uscities[1].\n";
print "$uscities[2].\n";

foreach(@{$uscities}){
           print "$_\n";
           #print "@_";
}