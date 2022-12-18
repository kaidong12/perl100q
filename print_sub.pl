#!/usr/bin/perl

$windir = "D:\\S_Perl\\myplscript";
$files = "*.txt";
$DIRHANDLE = "HANDLE";
opendir ($DIRHANDLE,"$windir") || die "Error opening $windir: $!";
@filelist = readdir ($DIRHANDLE);
#@filelist = exec "dir \/a \/b $windir\\$files";
foreach (@filelist){
        if ($_ =~ /txt$/){
          print "$_"."\n" ;
          open(MF,"$_") || die "Error!$!" ;
          open(DF,">>_$_") || die "Error!$!" ;
          @readdata=<MF>;
          foreach(@readdata){
          s/^print.*\n$//;
          print DF "$_" ;
          #print "$_" ;
          }
#           while(<MF>){
#           s/^print.*\n$//;
#           print "$_" ;
#           }
        }
}