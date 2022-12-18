#!/usr/bin/perl

# print "Content-type: text/html\n\n";
# print "<html><h1>Hello!</h1></html>\n";


#!/usr/bin/perl -w
use strict;
$|++;

#
#   FILE:  sptinstall
#
#   Part of the Scout Portal Toolkit
#   Copyright 2002 Internet Scout Project
#   http://scout.cs.wisc.edu
#

use Cwd;

# software version (inserted here by SPT--BuildRelease)
my($SptVersion) = "1.1.3";

# default installation directory and web address
my($DefaultDstDir) = "/usr/local/apache/htdocs";
my($DefaultWebAddressDir) = "/SPT/";

# global values (easier than passing by reference everywhere)
my($DistArchiveName);
my($DstDir) = "";
my($WebAddress) = "";
my($UpgradeRequested) = 0;
my($SaveOldInstall) = 0;
my($OldSptVersion) = "";
my($NoCronTab) = 0;


sub GetInstallInfo
{
    # give instructions on usage
    print("\n"
            ."本程序将要询问你一些问题以得到安装csdlspt所需的一些信息\n"
            ."缺省的选择会在问题后面的方括号里面提示\n"
            ."如果要使用缺省的设置只需按回车即可\n"
            ."\n");

    # get destination directory
    if ($DstDir eq "") {  $DstDir = $DefaultDstDir;  }
    print("csdlspt将安装到您指定的位置.\n"
            ."安装目录必须是web服务起上面能访问到的地方.\n");
    print("安装目录： [${DstDir}]: ");
    my($Line) = "";
    $Line = <STDIN>;
    chomp($Line);
    if ($Line ne "")
    {
        $DstDir = $Line;
        # (strip off any trailing slash)
        if ($DstDir =~ /\/$/) {  chomp($DstDir);  }
    }
    print("使用目录 ${DstDir} 安装\n");
    if (! -d $DstDir)
    {
            do {
            print("目录不存在，要创建么 [Y/N]? ");
            $Line = <STDIN>;
                chomp($Line);
            } while ($Line !~ /y|n|yes|no/i);
            if ($Line !~ /y|yes/i)
            {
            print("\n请创建该目录，然后重新运行安装程序.\n");
            exit(1);
        }
        else
        {
            print("\n正在创建目录 ${DstDir}\n");
            `mkdir ${DstDir}`;
        }
    }
    print("\n");

    # check if destination dir is writable
    if ((! -w $DstDir) || (! -d $DstDir))
    {
        print("不能写安装目录  ${DstDir}\n");
        exit(1);
    }

    # if destination dir already contains SPT installation
    if ((-f $DstDir."/SPT--Home.php") && (-f $DstDir."/VERSION"))
    {
        # grab version of old installation
        $OldSptVersion = `cat ${DstDir}/VERSION`;
        chomp($OldSptVersion);

        # if checksum file is not available
        if (! -r "${DstDir}/CHECKSUMS")
        {
            # ask if user wants to proceed without upgrading
            print("目录:\n"
                    ."    ${DstDir}\n"
                    ."已经有一个版本号为 ${OldSptVersion} 的spt,\n"
                    ."该版本不能升级?.\n"
                    ."如果你要继续按装旧的安装版本将会被移到\n"
                    ."上级目录下的一个叫做 OLDVER-${OldSptVersion} 的子目录下面.\n");
            do {
                print("你想要继续安装么 [Yes]? ");
                $Line = <STDIN>;
                chomp($Line);
            } while (($Line !~ /^[YNyn]+/) && ($Line ne ""));

            # if user did not want to proceed
            if ($Line =~ /^[Nn]+/)
            {
                # tell user install is cancelled and then exit
                print("\n退出安装.\n");
                exit(1);
            }
            else
            {
                # set flag indicating old version must be moved aside
                $SaveOldInstall = 1;
                print("旧版本会在安装前移到 OLDVER-${OldSptVersion} .\n");
            }
        }
        else
        {
            # ask if user wants to do upgrade
            print("目录:\n"
                    ."    ${DstDir}\n"
                    ."已经有一个版本号为 ${OldSptVersion} 的spt,\n"
                    ."如果你要升级按装旧的安装版本将会被移到\n"
                    ."上级目录下的一个叫做 OLDVER-${OldSptVersion} 的子目录下面.\n");
            do {
                print("确认要升级这个安装吗[Yes]? ");
                $Line = <STDIN>;
                chomp($Line);
            } while (($Line !~ /^[YNyn]+/) && ($Line ne ""));

            # if upgrade requested
            if (($Line =~ /^[Yy]+/) || ($Line eq ""))
            {
                # check to make sure that md5sum is available
                $Line = `md5sum --version 2>&1`;
                if ((! defined($Line)) || ($Line =~ /Command not found/))
                {
                    print("\nGNU的工具 'md5sum' 是升级spt所必须的\n"
                           ."此工具未发现，请和你的系统管理员联系\n"
                           ."在你的服务器上安装 md5sum .\n");
                   exit(1);
                }

                # set flag indicating upgrade request
                $UpgradeRequested = 1;
                print("安装将被升级到版本 ${SptVersion}.\n");
            }
            else
            {
                # set flag indicating old version must be moved aside
                $SaveOldInstall = 1;
                print("在安装前旧版本将被移到 OLDVER-${OldSptVersion} .\n");
            }
        }
    }

    # get web server address
    if ($WebAddress eq "")
    {
        my($Host) = `hostname`;
        if ($Host !~ /[a-z0-9]+\.[a-z0-9]+/i)
        {
            $Host = `hostname --fqdn`;
        }
        chomp($Host);
        $WebAddress = "http://${Host}${DefaultWebAddressDir}";
    }
    print("\n"
            ."下面请填写门户的网络地址.\n");
    print("Web 服务器地址 [${WebAddress}]: ");
    $Line = <STDIN>;
    chomp($Line);
    if ($Line ne "")
    {
        $WebAddress = $Line;
    }
    print("使用 web 地址 ${WebAddress}\n");
    print("\n");

    # make sure that web server address has a trailing slash
    if ($WebAddress !~ /\/$/) {  $WebAddress .= "/";  }

    # check if web server supports PHP version we need
    print("检查php版本...");
    $Line = `lynx -version 2>&1 | grep -i 'lynx version'`;
    chomp($Line);
    if ($Line eq "")
    {
        print("\n 'lynx' 未发现，请一定要安装!!!\n"
                ."\n");
        do {
            print("忽略错误继续安装 [Y/N]? ");
            $Line = <STDIN>;
            chomp($Line);
        } while ($Line !~ /y|n|yes|no/i);
        if ($Line !~ /y|yes/i)
        {
            print("\n请改正错误后重新执行安装程序.\n");
            exit(1);
        }

        # set flag to prevent installation of crontab entry
        $NoCronTab = 1;
    }
    else
    {
        $Line = `lynx -dump -head ${WebAddress} 2>&1 | grep '^Server:'`;
        chomp($Line);
        if ($Line eq "")
        {
            print("\n不能连接 web 服务器 ${WebAddress}\n");
            exit(1);
        }
        $Line = `lynx -dump -head ${WebAddress} 2>&1 | grep 'PHP'`;
        chomp($Line);
        if ($Line !~  /PHP\/[4-9]/)
        {
            print("\n在:\n"
                    ."    ${WebAddress}\n"
                    ."的web服务器不支持php4.   支持php 4或更高的web 服务器是必须的\n"
                    ."\n"
                    ."如果你确定你的web服务器支持php4你可以忽略这项测试.\n"
                    ."\n");
            do {
                print("忽略这项测试继续安装 [Y/N]? ");
                $Line = <STDIN>;
                chomp($Line);
            } while ($Line !~ /y|n|yes|no/i);
            if ($Line !~ /y|yes/i)
            {
                print("\n请在一个支持php4的web服务器上重新运行安装程序.\n");
                exit(1);
            }
            print("忽略对web服务器的php4的支持的检查.\n");
        }
        else
        {
            print("okay.\n");
        }
    }
}


sub InstallSoftware()
{
    # if we need to move old install aside
    my($OurHomeDir) = getcwd();
    print("\n");
    if ($SaveOldInstall)
    {
        print("保存旧的安装?...");

        # create subdirectory to hold old version (if it doesn't exist)
        my($OldVerDir) = "${DstDir}/OLDVER-${OldSptVersion}";
        if (! -d $OldVerDir)
        {
            `mkdir ${OldVerDir}`;
        }

        # check that old version subdirectory is writable
        if ((! -d $OldVerDir) || (! -w $OldVerDir))
        {
            print("\n不能创建 ${OldVerDir}\n");
            exit(1);
        }

        # move all files into subdirectory
        chdir($DstDir);
        `mv * ${OldVerDir}/. 2>&1`;

        # move any other old installs back up
        chdir($OldVerDir);
        `mv OLDVER-* .. 2>&1`;

        # copy old configuration info back up
        if (-f "${OldVerDir}/include/SPT--Config.php")
        {
            `mkdir ${DstDir}/include`;
            `cp ${OldVerDir}/include/SPT--Config.php ${DstDir}/include/.`;
        }

        print("完成.\n");
    }

    # unpack distribution archive
    print("解压缩发布的文件...");
    my($FullDistArchiveName) = $OurHomeDir."/".$DistArchiveName;
    my($WorkDir) = "/tmp/csdlspt-".$SptVersion;
    chdir("/tmp");
    `tar xzf ${FullDistArchiveName}`;
    print("done.\n");

    # if user requested upgrade
    if ($UpgradeRequested)
    {
        # for each file in checksum list for old install
        print("检查升级过程中要保留的html文件...");
        my($Line);
        my($FileName);
        my($NewFileName);
        my($Checksum);
        my($NewChecksum);
        chdir($DstDir);
        open(INPUT, "CHECKSUMS");
        while ($Line = <INPUT>)
        {
            # grab checksum info for old install
            ($Checksum, $FileName) = split(/\s+/, $Line);
            ($NewChecksum, $NewFileName) = split(/\s+/, `md5sum ${FileName}`);
            if ($NewFileName ne $FileName)
            {
                    print("\n\n计算文件校检和时发生错误.\n");
                exit(1);
            }

            # if file has changed
            if ($NewChecksum ne $Checksum)
            {
                # rename distribution copy of file to include version number
                rename($WorkDir."/".$FileName, $WorkDir."/".$FileName."--".$SptVersion);
            }
        }
        print("done.\n");
    }

    # copy files from distribution to destination
    print("向安装目录拷贝文件...");
    chdir($WorkDir);
    `tar cf - * | (cd ${DstDir} ; tar xpf -)`;
    `rm -r ${WorkDir}`;
    print("done.\n");

    # set up config file and make it writable
    print("准备配置文件...");
    chdir($DstDir);
    `chmod a+rwx include`;
    print("完成.\n");

    # make sure permissions are okay
    print("设置文件权限...");
    `find . -type f -not -name INSTALLED -not -name SPT--Config.php -exec chmod a+r {} \\;`;
    `find . -type d -exec chmod a+rx {} \\;`;
    `chmod a+w SPTUI--Default/include/SPT--Stylesheet.css`;
    print("完成.\n");

    # set up link to default page
    print("设置到 index.php的连接...");
    if (! -l "index.php") {  `ln -s SPT--Home.php index.php`;  }
    print("完成.\n");

    # set up subdirectories
    print("设置子目录...");
    if (! -d "ImageStorage") {  `mkdir ImageStorage`;  `chmod a+rwx ImageStorage`;  }
    if (! -d "ImageStorage/Previews") {  `mkdir ImageStorage/Previews`;  `chmod a+rwx ImageStorage/Previews`;  }
    if (! -d "ImageStorage/Thumbnails") {  `mkdir ImageStorage/Thumbnails`;  `chmod a+rwx ImageStorage/Thumbnails`;  }

    if (! -d "FileStorage") {  `mkdir FileStorage`;  `chmod a+rwx FileStorage`;  }

    if (! -d "TempStorage") {  `mkdir TempStorage`;  `chmod a+rwx TempStorage`;  }
    print("完成.\n");

    # set up subdirectory soft links
    print("设置子目录的连接...");
    if (! -l "MetadataTool/include") {  `ln -s ../include MetadataTool`;  }
    if (! -l "MetadataTool/images") {  `ln -s ../images MetadataTool`;  }
    if (! -l "MetadataTool/Axis--Database.php") {  `ln -s ../Axis--Database.php MetadataTool`;  }
    if (! -l "MetadataTool/Axis--StandardLibrary.php") {  `ln -s ../Axis--StandardLibrary.php MetadataTool`;  }
    if (! -l "MetadataTool/Axis--Session.php") {  `ln -s ../Axis--Session.php MetadataTool`;  }
    if (! -l "MetadataTool/Axis--User.php") {  `ln -s ../Axis--User.php MetadataTool`;  }
    if (! -l "MetadataTool/Axis--Image.php") {  `ln -s ../Axis--Image.php MetadataTool`;  }
    if (! -l "MetadataTool/SPTUI--Default") {  `ln -s ../SPTUI--Default/MetadataTool MetadataTool/SPTUI--Default`;  }
    if (! -l "SPTUI--Default/MetadataTool/include") {  `ln -s ../include SPTUI--Default/MetadataTool/include`;  }
    if (! -l "SPTUI--Default/MetadataTool/images") {  `ln -s ../images SPTUI--Default/MetadataTool/images`;  }
    if (! -l "MetadataTool/SPTUI--CleanOrange") {  `ln -s ../SPTUI--CleanOrange/MetadataTool MetadataTool/SPTUI--CleanOrange`;  }
    if (! -l "SPTUI--CleanOrange/MetadataTool/include") {  `ln -s ../include SPTUI--CleanOrange/MetadataTool/include`;  }
    if (! -l "SPTUI--CleanOrange/MetadataTool/images") {  `ln -s ../images SPTUI--CleanOrange/MetadataTool/images`;  }
    if (! -l "MetadataTool/SPTUI--Standards") {  `ln -s ../SPTUI--Standards/MetadataTool MetadataTool/SPTUI--Standards`;  }
    if (! -l "SPTUI--Standards/MetadataTool/include") {  `ln -s ../include SPTUI--Standards/MetadataTool/include`;  }
    if (! -l "SPTUI--Standards/MetadataTool/images") {  `ln -s ../images SPTUI--Standards/MetadataTool/images`;  }

    print("完成.\n");

    # set up style sheet if not already there
    if (! -f "SPTUI--Default/include/SPT--Stylesheet.css") {  `cp SPTUI--Default/include/SPT--Stylesheet.css.DIST SPTUI--Default/include/SPT--Stylesheet.css`;  `chmod a+w SPTUI--Default/include/SPT--Stylesheet.css`;  }

    # save old version number
    if (length($OldSptVersion) > 0)
    {
            `echo ${OldSptVersion} > ${DstDir}/OLDVERSION`;
    }

    # clear install flag if present
    if (-f "include/INSTALLED") {  `rm -f include/INSTALLED`;  }
}

sub InstallCronEntry()
{
    my($Line);
    my($AlreadyInCron) = 0;

    # backup current crontab
    `crontab -l > /tmp/crontab.backup.\${USER}.$$`;

    # grab current crontab
    my(@CronTab) = `crontab -l 2>&1`;

    # if crontab was empty
    if ($CronTab[0] =~ /^no crontab for /)
    {
            # clear error message out of crontab text
        undef @CronTab;
    }
    else
    {
        # see if we already have an entry in crontab
        foreach $Line (@CronTab)
        {
            if (($Line =~ /$WebAddress/) && ($Line =~ /HourlyMaint/))
            {
                $AlreadyInCron = 1;
            }
        }
    }

    # if we don't already have an entry in crontab
    if ($AlreadyInCron == 0)
    {
            print("Crontab 文件已经包含有要添加的项.\n");

        # add our entry to crontab text
        $CronTab[$#CronTab + 1] = "#\n";
        $CronTab[$#CronTab + 1] = "# Scout Portal Toolkit - Maintenance Task\n";
        $CronTab[$#CronTab + 1] = "0 * * * * lynx -dump ".$WebAddress."SPT--HourlyMaint.php > /dev/null\n";

        # install new crontab text
        open(*OUTPUT, "| crontab - ");
        foreach $Line (@CronTab)
        {
            print(OUTPUT $Line);
        }
        close(*OUTPUT);

        print("完成.\n");
    }
    else
    {
        print("Crontab file already contains entry for this SPT installation.\n");
    }
}


{
    # sign in
    print("\n");
    print("csdl-spt v${SptVersion}安装程序 \n");

    # check to make sure distribution file is available
    $DistArchiveName = "csdlspt-${SptVersion}.tgz";
    if (! -r $DistArchiveName)
    {
        print("Could not find SPT distribution archive ".$DistArchiveName."\n");
        exit(1);
    }

    # ask user for settings
    GetInstallInfo();

    # install portal toolkit
    InstallSoftware();

    # set up cron entry (if not disabled)
    if ($NoCronTab == 0)
    {
        InstallCronEntry()
    }

    # tell user next steps
    print("\n"
            ."安装程序的命令行部分已经成功执行.\n"
            ."要完成剩余部分的安装请访问页面:\n"
            ."    ${WebAddress}SPT--Install.php\n"
            ."请根据该页面的提示完成剩余的安装\n"
            ."\n"
            ."谢谢使用csdlspt !\n"
            );
}
