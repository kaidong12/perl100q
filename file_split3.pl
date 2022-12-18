#!/usr/bin/perl

#demonstrate the directory listening

$windir = "D:\\temp\\471954595";
$files = "*.txt";

$DIRHANDLE = "HANDLE";
opendir ($DIRHANDLE,"$windir") || die "Error opening $windir: $!";
@filelist = readdir ($DIRHANDLE);

#@filelist = exec "dir \/a \/b $windir\\$files";

  foreach (@filelist){
            s/txt/jpg/;
            print "$_\n";
  }




