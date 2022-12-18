#!/usr/bin/perl

# rename file
# open (MYDATA,"rename_data.txt") || die "Open data file error. $!";
# @datafile = <MYDATA>;
# foreach (@datafile){
#            print "$_";
#           #$new = lc;
#           #$new = uc;
#            $new = ucfirst;
#            print "$new\n";
#
# }

$windir = "D:\\S_Perl\\myplscript";

@filelist = exec "dir \/a $windir";
foreach (@filelist){
           print "$_";
          #$new = lc;
          #$new = uc;
           $new = ucfirst;
           rename ($_,$new);
          #print "$new\n";
}

