#!/usr/bin/perl

#!/usr/bin/perl -w

$function_dir = "C:\\EFOMRegression\\Function";
%FolderName = ("b" => "Function_BusinessCommon",
    "c" => "Function_Common",
    "v" => "Function_VerifyData");

@k = keys(%FolderName);
#@v = values %FolderName;

foreach $kk (@k)
{
 #print "$_\n";
 #print "$function_dir\\$FolderName{$_}\n";
 print "$kk\n";
 $script_dir = "$function_dir\\$FolderName{$kk}";
 print "$script_dir\n";
#}
 print "Are you sure to process this folder? \nN for no, press any key for yes.\n";
 #exit;

 $YN = <>;
 chomp($YN);
 if ($YN eq "N")
 {
  exit;
 }

 #$script_dir = "C:\\EFOMRegression\\Function\\Function_BusinessCommon";
 #$script_dir = "C:\\EFOMRegression\\Function\\Function_Common";
 #$script_dir = "C:\\EFOMRegression\\Function\\Function_VerifyData";
 print "Demo path:\n$script_dir\n";
 <>;
 opendir (MyDir,"$script_dir") || die "Error opening Folder.$!";
 @myfiles = readdir(MyDir);
 foreach $ff (@myfiles)
 {
  #if (/vbs$/)
  if ($ff =~ /vbs$/)
  {
   $fullname_o = "$script_dir\\$ff";
   print "$fullname_o\n";
   open (MyVBS,"$fullname_o") || die "Error opening Script.$!";
   @myscript = <MyVBS>;
   $new_script_dir = "$script_dir"."_1";
   mkdir "$new_script_dir";
   $fullname_n = "$new_script_dir\\$ff"; #./*.vbs-->./New/*.vbs
   open (VBSTo,">$fullname_n") || die "Error opening Script.$!";
   foreach $ss (@myscript)
   {
    if($ss =~ /print/i)
    {
     if($ss =~ /log_print/i)
     {
      print "$ss";
 #     s/log_print/'log_print/i;
 #     print VBSTo "$_";
      print VBSTo "\n";
     }
     else
     {
      print "$ss";
      s/print/'Print/i;
      print VBSTo "$ss";
     }
    }
    elsif($ss =~ /^Function/)
    {
     print VBSTo "$ss";
     @function_header = split(/\s+/,$ss);
     print VBSTo "Write_log "."\"$kk$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"b$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"c$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"v$function_header[1]\""."\n";
    }
    elsif($ss =~ /^Public Function/)
    {
     s/Public Function/Function/i;
     print VBSTo "$ss";
     @function_header = split(/\s+/,$ss);
     print VBSTo "Write_log "."\"$kk$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"b$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"c$function_header[1]\""."\n";
     #print VBSTo "Write_log "."\"v$function_header[1]\""."\n";
    }
    else
    {
     print VBSTo "$ss";
    }
   }
  }
 }
}
#<>;



