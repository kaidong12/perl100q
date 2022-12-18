#!/usr/bin/perl

# https://metacpan.org/dist/Spreadsheet-WriteExcel


use Spreadsheet::WriteExcel;

## Create a new Excel workbook
my $xl = Spreadsheet::WriteExcel->new("TEST.xls");
#Add a worksheet
my $xlsheet = $xl->add_worksheet("TestSheet");
#Add and define a format
$rptheader = $xl->add_format(); # Add a format
$rptheader->set_bold();
$rptheader->set_size('12');
$rptheader->set_align('center');
#Add and define a format
$normcell = $xl->add_format(); # Add a format
$normcell->set_size('9');
$normcell->set_align('center');
$normcell->set_bg_color('22');
#Write a formatted and unformatted string, row and column notation.
$col = $row = 0;
$xlsheet->write($row, $col, 'Hi Excel!', $format);
$xlsheet->write(1,    $col, 'Hi Excel!');

$xlsheet->set_column('A:A',10);
$xlsheet->set_column('B:B',12);
$xlsheet->set_column('C:C',17);

#Write a number and a formula using A1 notation
$xlsheet->write("A2","Number", $rptheader);
$xlsheet->write("B2","Name",$rptheader);
$xlsheet->write("C2","Language",$rptheader);

$xlsheet->write("A3","1", $normcell);
$xlsheet->write("B3","Test",$normcell);
$xlsheet->write("C3","Perl",$normcell);

#Close file
$xl->close();

