#!/usr/bin/perl

$min=1;
$max=10;
$string_to_print="ho ho ho";

# for ($i=$min;$i<=$max;$i++)
# {
#  print "$string_to_print $i \n";
# }

for ($min..$max)
{
	print "$string_to_print $_ \n";
}

#**********************************************************
@array1 = ("Linux","Scripting","Java","C#","QTP");
foreach(@array1)
{
 print "$_\n";
}
$arraryelments=$#array1+1;
print "Totally have $arraryelments elements.\n";


#**********************************************************
$v1 = 1;
$v2 = 5;

# while ($v1<$v2)
# {
# print "$v1\n";
# $v1 += 1;
# }

until ($v1>$v2)
{
 print "$v2\n";
 $v2 += -1;
}




