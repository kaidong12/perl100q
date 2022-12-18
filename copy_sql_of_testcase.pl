#!/usr/bin/perl
# concat files in a specific folder
$windir = "E:\\test\\db";
$casename = "QAtestCMS_217";
$newsql = "$windir\\after\\$casename.txt";

opendir ($DIRHANDLE,"$windir") || die "Error opening $windir:$!";
@filelist = readdir ($DIRHANDLE);
foreach $file (@filelist){
         if ($file =~ /txt$/){
              print  $file."\n";
              open (XMLTo,">>$newsql") || die "Error opening Script.$!";
              open (MyXML,"$windir\\$file") || die "Error opening Script.$!";
              @myxml = <MyXML>;
              foreach $line (@myxml){
                        if($line =~ /$casename/i)
                        {
                                     #print "$line";
                                     #$line =~ s/c_name/e_name/g;
                                     print XMLTo "$line" ;
                        }
                }
            close  MyXML;
         }
}
$|++;
$|=1;
#<>;