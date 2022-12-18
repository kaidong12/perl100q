#!/usr/bin/perl

$FILEIN = "file1.txt";
$FILEOUT = "file1_.txt";
open ($IN,"$FILEIN") || die "Error opening file. $!";
open ($OUT,"+<$FILEOUT") || die "Error opening file. $!";

@filecontents = <$IN>;
#@filecontents = <$OUT>;
 foreach (@filecontents)
 {
           if (/^print/i)
           {
                s/print/'printt/;
                print $OUT "$_\n";
           }

 }




