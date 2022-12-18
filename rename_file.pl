
##################################################################################
#!/usr/bin/perl -w

#foreach my $file (glob "*txt"){
foreach my $file (glob "$ARGV[0]\\*.jpg"){
#foreach my $file (glob "$ARGV[0]\\*.txt"){
   my $newfile = $file;
   $newfile =~ s/jpg$/txt/;
   #$newfile =~ s/txt$/jpg/;
   if (-e $newfile) {
        warn "can't rename $file to $newfile: $newfile exists ";
   }
   elsif (rename $file, $newfile) {
   	
   }
   else {
         warn "rename $file to $newfile failed:$! ";
   }
}

##################################################################################
#!/usr/bin/perl -w

$op=shift;
for (@ARGV){
$was=$_;
eval $op;
die $@ if $@;
rename($was, $_) unless $was eq $_;
}
ʹ��:
������ű���rename.pl, ��������ִ��Ȩ��, Ȼ��ִ��
./rename.pl 'tr /A-Z/a-z/' *
# �ͻ�ѱ�Ŀ¼�е������ļ����Сд. ����ű�����������������ָ��ļ����Ĺ���.
# ϣ�������س���ʱ, �ļ�������ɴ�д�������а���.
if ($ENV{'REQUEST_METHOD'} eq 'POST') {
  read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
  $buffer = $ENV{'QUERY_STRING'};
}
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $name =~ tr/+/ /;
  $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $FORM{$name} = $value;
}