#!/usr/bin/perl

$FILEHANDLE="FILEHANDLEFORRW";
$filename = "tasks.txt";
$appendc="task1     task2     task4\n";

open ($FILEHANDLE,"+<$filename") || die "Error open $FILEHANDLE:$!";  #read and write
#open ($FILEHANDLE,">>$filename") || die "Error open $FILEHANDLE:$!";
@datacontents = <$FILEHANDLE>;
print $FILEHANDLE "$appendc";
foreach(@datacontents){
    print "$_";
}