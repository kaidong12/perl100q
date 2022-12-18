
#!/usr/bin/perl
# concat files in a specific folder
$windir = "D:\\MyScripts\\temp\\0615";
$newxml = "$windir\\newxml.xml";

opendir ($DIRHANDLE,"$windir") || die "Error opening $windir:$!";
@filelist = readdir ($DIRHANDLE);
foreach $file (@filelist){
	if ($file =~ /xml$/){
		print  $file."\n";
		open (XMLTo,">>$newxml") || die "Error opening Script.$!";
		open (MyXML,"$windir\\$file") || die "Error opening Script.$!";
		@myxml = <MyXML>;
		foreach $line (@myxml){
			if($line !~ /testcase/i)
			{
				#print "$line";
				#$line =~ s/c_name/e_name/g;
				print XMLTo "$line" ;
			}
		}
		close  MyXML;
	}
}
$|++;