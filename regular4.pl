#!/usr/bin/perl

#***********************************************************

$filename = "file1.txt";
open ($IN, "$filename") || die "Error opening file. $!";
       while(<$IN>){
              #if (m@/@)
#              if (/^\w:/)			#start with 1 (letter, number, _) and followed with a :
			   if (/^\W/)			#start with 1 non (letter, number, _) and followed with a :
#              if (/^[1-9]*/)		#start with 0 or more number
#              if (/^[1-9]?/)		#start with 0 or 1 number
#              if (/^[1-9]+/)  		#start with 1 or more number
#              if (/^\d/)			#start with 1 number
#              if (/^\s/)			#start with 1 space
#			   if (/^\S/)			#start with 1 non space
              {
                  print "$_";
              }
       }

#***********************************************************
# for (1..5){
# $_ = <STDIN>;
# #$inputss=<STDIN>;
# chomp $_;
# # frog,dog,flog,clog,log
# if (/(fr|d|l|((f|c)l))og/) {
# #if ($inputss =~ /dog|cats/){
#      #s/og/xx/ ;
#      print "\$_ contains a pet $_","\n";
#
#      $vv=0;
#      while ($_=~/\w/g){
#      $vv++;
#      }
#      print $vv."\n";
# }
# }