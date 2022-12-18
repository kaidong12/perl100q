#!/usr/bin/perl


$script_dir = "E:\\S_Perl\\myplscripts";
print $script_dir;
<>;
opendir (MyDir,"$script_dir") || die "Error opening Folder.$!";
@myfiles = readdir(MyDir);
foreach(@myfiles)
{
 if (/pl$/)
 {
  $fullname_o = "$script_dir\\$_";
  print "$fullname_o\n";
  open (MyVBS,"$fullname_o") || die "Error opening Script.$!";
  @myscript = <MyVBS>;
#   $new_script_dir = "$script_dir"."_1";
#   mkdir "$new_script_dir";
#   $fullname_n = "$new_script_dir\\$_"; #./*.vbs-->./New/*.vbs
#   open (VBSTo,">$fullname_n") || die "Error opening Script.$!";
  foreach $line (@myscript)
  {
   if($line =~ /spreadsheet/i)
   {
     print $fullname_o."\n";
   #  if(/log_print/i)
#     {
#      print "$_";
# #     s/log_print/'log_print/i;
# #     print VBSTo "$_";
#      print VBSTo "\n";
#     }
#     else
#     {
#      print "$_";
#      s/print/'Print/i;
#      print VBSTo "$_";
#     }
#    }
#    elsif(/^Function/)
#    {
#     print VBSTo "$_";
#     @function_header = split(/\s+/,$_);
#     print VBSTo "Write_log "."\"b$function_header[1]\""."\n";
#     #print VBSTo "Write_log "."\"c$function_header[1]\""."\n";
#     #print VBSTo "Write_log "."\"v$function_header[1]\""."\n";
#    }
#    elsif(/^Public Function/)
#    {
#     s/Public Function/Function/i;
#     print VBSTo "$_";
#     @function_header = split(/\s+/,$_);
#     print VBSTo "Write_log "."\"b$function_header[1]\""."\n";
#     #print VBSTo "Write_log "."\"c$function_header[1]\""."\n";
#     #print VBSTo "Write_log "."\"v$function_header[1]\""."\n";
#    }
#    else
#    {
#     print VBSTo "$_";
     }
  }
 }
}
#<>;