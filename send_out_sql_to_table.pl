#!/usr/bin/perl
# concat files in a specific folder
$windir = "E:\\test\\db";
$casename = "QAtestCMS_216";
$casesql = "$windir\\after\\$casename.txt";

open (CASESQL,"$casesql") || die "Error opening Script.$!";
@mysql = <CASESQL>;
foreach $line (@mysql){
          @strarray = split /\"/, $line;
          print "$strarray[1]\n";
          $tablefile = "$windir\\$strarray[1].txt";
          open (SQLTo,">>$tablefile") || die "Error opening Script.$!";
          print SQLTo "$line" ;
          close SQLTo;
}
close CASESQL;
$|++;
$|=1;
#<>;