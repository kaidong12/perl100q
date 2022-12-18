#!/usr/bin/perl

&loop_dir("E:\\S_Perl");
sub loop_dir(){
local ($dir)=@_;
opendir (dir, $dir) or die "Cannot open $dir : $!";
foreach $next (readdir dir) {
         next if "$next" eq "." or "$next" eq "..";
         if ( -f "$dir/$next" )
         {
         #print "$dir/$next\n";
         print "$next\n";
         }
         if ( -d "$dir/$next" ) {
         print "=====$dir=====\n";
         loop_dir ("$dir/$next");
         }
         }
closedir (dir);
          return;
}


#
# #!/usr/bin/perl
# &loop_dir("d:\\S_Python");
# sub loop_dir(){
#   local($dir) = @_;
#   opendir(DIR,"$dir");
#   local @files =readdir(DIR);
#   closedir(DIR);
#   for $file (@files){
#     next if($file=~m/^\./ || $file =~m/^\.\./);
#
#     #==============================
#     #next unless(-d "$dir/$file");
#     #print"��ķ������!\n"unless($score<60);
#     unless(-d "$dir/$file"){
#     print "$file\n";
#     next;
#     }
#     &loop_dir("$dir/$file");
#     #==============================
#
# #     if(-d "$dir/$file"){
# #     print "-----$dir-----\n";
# #     &loop_dir("$dir/$file");
# #     }
# #     else{
# #     print "$file\n";
# #     }
#
#   }
# }