#!/usr/bin/perl

use Spreadsheet::WriteExcel;
#************����Excel�ĵ�****************
my $xl = Spreadsheet::WriteExcel->new("TEST.xls");
#����Excel��
my $xlsheet = $xl->add_worksheet(��TestSheet��);
#��Ӹ�ʽ����ͷ��
$rptheader = $xl->add_format(); # Add a format
$rptheader->set_bold();
$rptheader->set_size('12');
$rptheader->set_align('center');
#��Ӹ�ʽ�������ݣ�
$normcell = $xl->add_format(); # Add a format
$normcell->set_size('9');
$normcell->set_align('center');
$normcell->set_bg_color('22');
#�����еĿ��
$xlsheet->set_column('A:A',10);
$xlsheet->set_column('B:B',12);
$xlsheet->set_column('C:C',17);
#д��ͷ����ʽ��ʹ��������ӵı�ͷ��ʽ��
$xlsheet->write("A2","Number", $rptheader);
$xlsheet->write("B2","Name",$rptheader);
$xlsheet->write("C2","Language",$rptheader);
#д���ݣ���ʽ��ʹ��������ӵı����ݸ�ʽ��
$xlsheet->write("A3","1", $normcell);
$xlsheet->write("B3","Test",$normcell);
$xlsheet->write("C3","Perl",$normcell);
#�رղ���excel�Ķ���.
$xl->close();