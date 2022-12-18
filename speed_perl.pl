#!/usr/bin/perl

# print "Content-type: text/html\n\n";
# print "<html><h1>Hello!</h1></html>\n";


use Time::HiRes qw(time gettimeofday);

my $msec=time;

my $t=0;
my $cnt=1_000_000;

# for(my $i=0;$i<$cnt;$i++)
# {
# $t=$t+$i;
# }

for my $i (0..$cnt)
{
 $t=$t+$i;
}
my $msec2=time;

print "loop for $cnt times takes ",($msec2-$msec)*1000,"ms","\n";