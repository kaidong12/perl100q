
# �˽ű���Ŀ���Ƿ��������Ժ�ldap�������ʼ������ݣ�
# ����֮ǰʹ��slapdcat -l ����������Ϣ��Ȼ��������Ҫ
# ������uid  password , ��������ö���Ĭ����":" �����
# ��slapcat -l user.ldif  �����õ�һ��uid ��userPassword ��Ӧ���ļ���
# �޸�username = "dn"; password = "userpassword"; awk -f ldap2txt.awk user.ldif | grep uid | more  ���Բ鿴��� (�п����Ƕ�����ʼ�)
# �����õ�domain ����Ӧ�����룬�޸�username = "dn"; password = "userpassword";  ���� awk -f ldap2txt.awk user.ldif |grep domain | more

#!/bin/awk -f
# File name: ldap2txt.awk
#
# BEGIN {
#         FS = ":";
#         username = "uid";
#         password = "userPassword";
# }
#
# {
#
#         if(length($0) == 0 )
#         {
#                 if (name != "u"  &&  pword != "p")
#                 {
#                         printf ("%s:%s\n", name,pword);
#                         name = "u";
#                         pword = "p";
#                 }
#         }
#
#         else
#         {
#                 if ($1 == username)
#                 {
#                 name = "u";
#                 name = $0;
#                 }
#                 else if($1 == password)
#                 {
#                 pword = "p";
#                 pword = $0;
#                 }
#         }
# }
# END {
#
# }
