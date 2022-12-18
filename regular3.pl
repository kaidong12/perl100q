#!/usr/bin/perl

# https://www.runoob.com/python3/python3-reg-expressions.html

# Grouping
$var1 = "LinuxCBT 1 2 3 4";
# \d = only extracts digits

$var1 =~ /(\w+)(\s\d)(\s\d)(\s\d)/;       # $1, $2, $3, etc.
print "$1$2$3$4\n";

# ***********************************************************

#$time = "06:05:50 PM";
$time = "6:5:50 PM";
$time =~ /(\d+):(\d+):(\d+)\s(.*)/;
print "$1 :: $2 :: $3 :: $4\n";


# ***********************************************************

@array1 = ("right","tight","might","night","goodNight","dog","bird","cat");
    foreach(@array1)
    {
#         if(/[rmnt]ight/i)
#         {
#         print "$_\n";
#         }


           if (/dog|cat|bird/i)
           {
               print "$_\n";
           }
    }




