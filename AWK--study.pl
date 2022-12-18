
# 此脚本的目的是方便我们以后导ldap的其他邮件的数据，
# 我们之前使用slapdcat -l 导出所有信息，然后我们需要
# 整理出uid  password , 这里的设置都是默认以":" 间隔的
# 例slapcat -l user.ldif  如果想得到一份uid 和userPassword 对应的文件，
# 修改username = "dn"; password = "userpassword"; awk -f ldap2txt.awk user.ldif | grep uid | more  可以查看结果 (有可能是多域的邮件)
# 如果想得到domain 所对应的密码，修改username = "dn"; password = "userpassword";  运行 awk -f ldap2txt.awk user.ldif |grep domain | more

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

