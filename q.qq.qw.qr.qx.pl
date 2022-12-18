#!/usr/bin/perl

#q
print q~I've passed the exam.~, "\n";

#qq
print qq~He said:"Don't move!" ~, "\n";

#qw
@array1 = qw(aa bb cc dd);
print  @array1[0..$#array1], "\n";

#qr
$str1 = "Fuck you dad!";
$replaceword = qr(you);
$finalword="OK" if ($str1 =~ $replaceword);
print $finalword, "\n";

#qx        (quoted execution operator)
qx/uname -p -r/;

