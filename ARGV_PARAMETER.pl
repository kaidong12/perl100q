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
# 输入数据文件名，输出文件内容
#@ARGV = ("myfile1", "myfile2"); #实际上由命令行参数赋值
#     while ($line = <>) {
#     print ($line);
#     }

