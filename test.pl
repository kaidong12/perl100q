#!/usr/bin/perl

# $myDir="C:\\Documents and Settings\\lyan\\Desktop\\Myscripts";
#
# &find_dir($myDir);
# sub find_dir(){
#   local($dir) = @_;
#   opendir(DIR,"$dir")||die "can not do this: $!";
#   local @files =readdir(DIR);
#
#   for $file (@files){
#     next if($file=~m/\./ || $file =~m/\.\./);
#
#     #next unless(-d "$dir/$file");
#     if(-d "$dir/$file") {
#              find_dir("$dir/$file");
#     }
#
#     print "$file\n";
#   }
#   closedir(DIR);
# }

#!/usr/bin/perl

print "content-type: text/html \n\n";        #HTTP HEADER

# DEFINE AN ARRAY
@coins = ("Quarter","Dime","Nickel");

# PRINT THE ARRAY
#print "@coins";
#print "<br />";

print "$#coins";



# use Time::localtime;
# my $tm = localtime(time);
# my ($HOUR, $MIN, $SEC, $YEAR, $MON, $DAY) = ($tm->hour, $tm->min, $tm->sec, $tm->year+1900, $tm->mon+1, $tm->mday);
# print "$YEAR+$MON+$DAY+$HOUR";

# use IO::Socket;
# my $server = shift;
# my $fh = IO::Socket::INET->new($server);
# my $line = <$fh> ;
# print  $line;
