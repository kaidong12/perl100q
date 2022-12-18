#!/usr/bin/perl


# extract data from a data file
open (MYDATA,"products_data.txt") || die "Open data file error. $!";

# $lc = 0;
# while(<MYDATA>){
#              print $_;
#              @array2 = split /\s+/, $_;
#
#              foreach(@array2){
#                       print "$_\n";
#              }
#              $lc += 1;
# }
# print "Line count is:", "\t", "$lc", "\n";

$total = 0;
@datafile = <MYDATA>;
foreach (@datafile){
#          print "$_"
           @columns = split;
           print "$columns[5]\n";
           $total += $columns[3];

}
print "Total number is: $total\n";

