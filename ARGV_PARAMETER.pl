#!/usr/bin/perl

# To explain how to extract command line arguments
# @Argv;


print "$ARGV[0]\n";
print "$#ARGV\n";

#**********************************************************
$requirement = 2;
$#ARGV += 1;
#print "$#ARGV\n";
unless ($#ARGV == $requirement){
       print "$0 requires $requirement arguments!\n";
       exit 165;           #perldoc -f exit
}
print "@ARGV[0..$#ARGV]\n";

#**********************************************************

foreach(@ARGV){
         print "$_\n";
}

#**********************************************************
# ���������ļ���������ļ�����
#@ARGV = ("myfile1", "myfile2"); #ʵ�����������в�����ֵ
#     while ($line = <>) {
#     print ($line);
#     }
