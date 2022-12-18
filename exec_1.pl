#!/usr/bin/perl


$windir = "D:\\×ÀÃæ\\471954595";
$files = "*.txt";

#@filelist = exec "dir \/n $windir\\$files";
#dir /a /b *.txt
@filelist = exec "dir \/a \/b $windir\\$files";
foreach (@filelist){
           print "$_";
           $new = s/\.txt/\.jpg/;
           #exec "ren $_, $new";
           print "$new\n";
}