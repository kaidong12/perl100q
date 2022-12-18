#!/usr/bin/perl

my $str = 'hello, hello, hell ';

my $total = @{[$str =~ m/hell/g]};
if($total>=3){
    print $total;
}

