#!/usr/bin/perl

print "$ARGV[0]\n";
print "$#ARGV\n";

$out = $ARGV[0];
open (MYFILE,"$out") || "Open file failed!";
@content=<MYFILE>;
$counter=0;
@temp;
foreach(@content){
#       print $_;
        @fields = split("pts/",$_);
        #print $fields[0]."\n";
        #$temp[$counter]=$fields[0];

        $flag=0;
        foreach(@temp){
                if($fields[0] eq $_){
                        $flag=1;
                }
        }

        #if($counter==0 || ($temp[$counter] ne $temp[$counter-1])){
        if($counter==0 || $flag ==0){
                $temp[$counter]=$fields[0];
                $counter++;

        }
}

foreach(@temp){
        print $_."\n";
}

#END