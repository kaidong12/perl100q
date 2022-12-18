#!/usr/bin/perl

#open (MYFile,">file_list.txt") || die "Open data file error. $!";
#@datafile = <MYFile>;


# foreach (@datafile){
#            print "$_";
#           #$new = lc;
#           #$new = uc;
#            $new = ucfirst;
#            print "$new\n";
#
# }

$windir = "D:\\S_Perl\\myplscripts";
$files = "file*";
#$filelist = exec "dir \/a $windir";
$filelist = "dir \/a $windir";
#$filelist = 'ls -l $windir';

# foreach (@filelist){
#            print "$_";
#           #$new = lc;
#           #$new = uc;
#            $new = ucfirst;
#            rename ($_,$new);
#           #print "$new\n";
# }
log_write("$filelist");

sub log_write{
open (MYFile,">file_list.txt") || die "Open data file error. $!";
$currenttime = localtime;
  print MYFile "$currenttime \n $_[0]";
  #print MYFile "$currenttime";
}
<>;