#!/usr/bin/perl


$data = "what do you think of Perl?";
#     if ($data =~ /perl/i)
#       {
#        print "$data\n";
#       }

#Anchor tag -- $ --Search at end of the string
#Anchor tag -- ^ --Search at beginning of string

if ($data =~ /\?$/)
{
 print "$data\n";
}

#*********************************************************
@array1 = ("Yan Yan kaidong","Kaidong Yan Yan");
 foreach (@array1)
 {
#      if(/^Yan/i)
#      {
#           print "$_\n";
#      }

     s/Yan/yan/g;
     print "$_\n";
 }

$data =~ s/you/YOU/;
print "$data\n";
