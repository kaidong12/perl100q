#!/usr/bin/perl

#!/usr/bin/perl


# extract data from a data file
open (MYDATA,"Sales-DB-for-SQL-Server.sql") || die "Open ssql data file error. $!";
open (OUTDATA,">>Sales-DB-for-SQL-Server.TXT") || die "Open ssql data file error. $!";
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

%mm = ("Jan","01","Apr","04","Jun","06","Dec","12");

$total = 0;
@datafile = <MYDATA>;
foreach (@datafile){
#           print "$_"

           #if (/-...-/)
           if (/(.*)'(\d+)-(\w+)-(\d+)'(.*)/)
           {
            #print OUTDATA $_;
            #print "$4-$3-$2\n";
            #print "$1$4-$3-$2$5\n";
            #print OUTDATA "$1$4-$3-$2$5\n";
            $m=$mm{$3};
            print OUTDATA "$1$4-$m-$2$5\n";
            $total += 1;
           }
           else
           {
           print OUTDATA $_;
           }

# $time = "6:5:50 PM";
# $time =~ /(\d+):(\d+):(\d+)\s(.*)/;
# print "$1µ„$2∑÷$3√Î $4\n";
#
#
#
#               s/-...-/-03-/;
#               print OUTDATA $_;
#              $total += 1;
}
print "Total number is: $total\n";