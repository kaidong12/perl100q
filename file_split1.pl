#!/usr/bin/perl


#Illustrate split, jion...

#split
$data1 = "yan kai dong";
@array1 = split /\s+/, $data1;
#@array1 = split /k/, $data1;
foreach (@array1){
          print "$_\n";
}


# $lc = 0;
# while (<>){
#              print $_;
#              @array2 = split /\s+/, $_;
#              foreach(@array2){
#                       print "$_\n";
#              }
#              $lc += 1;
# }
# print "Line count is:", "\t", "\n";


#join
$data2 = join ":", @array1;
print "New delimiter should be \":\" ", "$data2", "\n";


