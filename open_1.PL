#!/usr/bin/perl

open(MYFILE,"logfile.txt") || die "can't open the file.\n$!";
$line = <MYFILE>;
print $line;

# while (<MYFILE>){
# print $_;
# }
# print "=================\n";

# while (defined($a=<MYFILE>)){
# print $a;
# }
# print "=================\n";

@contents = <MYFILE>;
#print "@contents";

foreach (@contents){
print $_;
}
print "=================\n";

print -e 'logfile_.txt',"\n";
print -M 'logfile_.txt',"\n";
print -s 'logfile_.txt',"\n";


open (DEST,">>logfile_.txt") || die "$!";
#@contents = <MYFILE>;
print DEST @contents;
foreach (@contents){
print DEST $_;
}
print DEST "li         jinglong\n";


print -e 'logfile_.txt',"\n";
print DEST -M 'logfile_.txt',"\n";
print DEST -s 'logfile_.txt',"\n";



close(MYFILE);
# close(DEST);