#!/usr/bin/perl

#**************************************************************************
# Html

print "Content-type: text/html\n\n";
print "<html><h1>Hello!</h1></html>\n";
 print "<html>\n";
 print "<head>\n";
 print "<title></title>\n";
 print "</head>\n";
 print "<body>\n", 'lao po wo xiang bao zhe ni shui jiao';
 print "</body>\n";
 print "</html>\n";
print "=======================\n";


#**************************************************************************
# Scalar

# #$name = "yan kai dong";
print "Hello,please enter your name:";
$name = <stdin>;
chomp ($name);
# # print 'lao po wo $name xiang bao zhe ni shui jiao\n';
# print $name," said lao po wo xiang bao zhe ni shui jiao.\n";
print $name, ' said:"lao po wo yao bao zhe ni shui jiao."',"\n";
print "===========Scalar============\n";


#**************************************************************************
# Array

@laopo = ("PC","BMW","XQ");
print "@laopo\n";
print "Hello,$name please choose a laopo:","\n";
print "$laopo[0]"," 1","\n";
print "$laopo[1]"," 2" ,"\n";
print "$laopo[2]"," 3" ,"\n";
print "@laopo[0,1,2]","\n";
print "@laopo[0..2]","\n";
print "Totally have ", $#laopo+1, " laopo \n" ;
$selected = <stdin>;
chomp ($selected);
print "Hello,$name your selected laopo is: $laopo[$selected-1]","\n";


@pp = qw(aa bb cc dd);
print "@pp[0..$#pp]",  "\n";
print "============Array===========\n";


#**************************************************************************
#Hash

$lp="PC";
%laopo = ("PC", "ACER", "BMW", "CAR", "XQ", "PERSON");
#%laopo = qw(PC ACER BMW CAR XQ PERSON);
print $laopo{$lp}, "\n";
@key_of_laopo = keys %laopo;
@val_of_laopo = values %laopo;
print "Keys in Hash: @key_of_laopo[0..$#key_of_laopo]\n";
print "Values in Hash: @val_of_laopo[0..$#val_of_laopo]\n";
$lp = XQ;
%laopo = (PC => "ACER",
          BMW => "CAR",
          XQ => "PERSON");
print $laopo{$lp}, "\n";
print "===========Hash============\n";


#**************************************************************************
#sub routine

sub test {
	print "Hello, $_[0]", "\n";
	print "Hello, $_[2]", "\n";
	
	foreach (@_){
	    print "Hello1, $_", "\n";
	}

	foreach $str (@_){
	    print "Hello2, $str", "\n";
	}

	print "Hello3, @_", "\n";

}

test("Yan", "Jack", "Zam","Linda");

print "============sub===========\n";