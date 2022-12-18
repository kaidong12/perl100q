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
            ."������Ҫѯ����һЩ�����Եõ���װcsdlspt�����һЩ��Ϣ\n"
            ."ȱʡ��ѡ������������ķ�����������ʾ\n"
            ."���Ҫʹ��ȱʡ������ֻ�谴�س�����\n"
            ."\n");

    # get destination directory
    if ($DstDir eq "") {  $DstDir = $DefaultDstDir;  }
    print("csdlspt����װ����ָ����λ��.\n"
            ."��װĿ¼������web�����������ܷ��ʵ��ĵط�.\n");
    print("��װĿ¼�� [${DstDir}]: ");
    my($Line) = "";
    $Line = <STDIN>;
    chomp($Line);
    if ($Line ne "")
    {
        $DstDir = $Line;
        # (strip off any trailing slash)
        if ($DstDir =~ /\/$/) {  chomp($DstDir);  }
    }
    print("ʹ��Ŀ¼ ${DstDir} ��װ\n");
    if (! -d $DstDir)
    {
            do {
            print("Ŀ¼�����ڣ�Ҫ����ô [Y/N]? ");
            $Line = <STDIN>;
                chomp($Line);
            } while ($Line !~ /y|n|yes|no/i);
            if ($Line !~ /y|yes/i)
            {
            print("\n�봴����Ŀ¼��Ȼ���������а�װ����.\n");
            exit(1);
        }
        else
        {
            print("\n���ڴ���Ŀ¼ ${DstDir}\n");
            `mkdir ${DstDir}`;
        }
    }
    print("\n");

    # check if destination dir is writable
    if ((! -w $DstDir) || (! -d $DstDir))
    {
        print("����д��װĿ¼  ${DstDir}\n");
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
            print("Ŀ¼:\n"
                    ."    ${DstDir}\n"
                    ."�Ѿ���һ���汾��Ϊ ${OldSptVersion} ��spt,\n"
                    ."�ð汾��������?.\n"
                    ."�����Ҫ������װ�ɵİ�װ�汾���ᱻ�Ƶ�\n"
                    ."�ϼ�Ŀ¼�µ�һ������ OLDVER-${OldSptVersion} ����Ŀ¼����.\n");
            do {
                print("����Ҫ������װô [Yes]? ");
                $Line = <STDIN>;
                chomp($Line);
            } while (($Line !~ /^[YNyn]+/) && ($Line ne ""));

            # if user did not want to proceed
            if ($Line =~ /^[Nn]+/)
            {
                # tell user install is cancelled and then exit
                print("\n�˳���װ.\n");
                exit(1);
            }
            else
            {
                # set flag indicating old version must be moved aside
                $SaveOldInstall = 1;
                print("�ɰ汾���ڰ�װǰ�Ƶ� OLDVER-${OldSptVersion} .\n");
            }
        }
        else
        {
            # ask if user wants to do upgrade
            print("Ŀ¼:\n"
                    ."    ${DstDir}\n"
                    ."�Ѿ���һ���汾��Ϊ ${OldSptVersion} ��spt,\n"
                    ."�����Ҫ������װ�ɵİ�װ�汾���ᱻ�Ƶ�\n"
                    ."�ϼ�Ŀ¼�µ�һ������ OLDVER-${OldSptVersion} ����Ŀ¼����.\n");
            do {
                print("ȷ��Ҫ���������װ��[Yes]? ");
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
                    print("\nGNU�Ĺ��� 'md5sum' ������spt�������\n"
                           ."�˹���δ���֣�������ϵͳ����Ա��ϵ\n"
                           ."����ķ������ϰ�װ md5sum .\n");
                   exit(1);
                }

                # set flag indicating upgrade request
                $UpgradeRequested = 1;
                print("��װ�����������汾 ${SptVersion}.\n");
            }
            else
            {
                # set flag indicating old version must be moved aside
                $SaveOldInstall = 1;
                print("�ڰ�װǰ�ɰ汾�����Ƶ� OLDVER-${OldSptVersion} .\n");
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
            ."��������д�Ż��������ַ.\n");
    print("Web ��������ַ [${WebAddress}]: ");
    $Line = <STDIN>;
    chomp($Line);
    if ($Line ne "")
    {
        $WebAddress = $Line;
    }
    print("ʹ�� web ��ַ ${WebAddress}\n");
    print("\n");

    # make sure that web server address has a trailing slash
    if ($WebAddress !~ /\/$/) {  $WebAddress .= "/";  }

    # check if web server supports PHP version we need
    print("���php�汾...");
    $Line = `lynx -version 2>&1 | grep -i 'lynx version'`;
    chomp($Line);
    if ($Line eq "")
    {
        print("\n 'lynx' δ���֣���һ��Ҫ��װ!!!\n"
                ."\n");
        do {
            print("���Դ��������װ [Y/N]? ");
            $Line = <STDIN>;
            chomp($Line);
        } while ($Line !~ /y|n|yes|no/i);
        if ($Line !~ /y|yes/i)
        {
            print("\n��������������ִ�а�װ����.\n");
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
            print("\n�������� web ������ ${WebAddress}\n");
            exit(1);
        }
        $Line = `lynx -dump -head ${WebAddress} 2>&1 | grep 'PHP'`;
        chomp($Line);
        if ($Line !~  /PHP\/[4-9]/)
        {
            print("\n��:\n"
                    ."    ${WebAddress}\n"
                    ."��web��������֧��php4.   ֧��php 4����ߵ�web �������Ǳ����\n"
                    ."\n"
                    ."�����ȷ�����web������֧��php4����Ժ����������.\n"
                    ."\n");
            do {
                print("����������Լ�����װ [Y/N]? ");
                $Line = <STDIN>;
                chomp($Line);
            } while ($Line !~ /y|n|yes|no/i);
            if ($Line !~ /y|yes/i)
            {
                print("\n����һ��֧��php4��web���������������а�װ����.\n");
                exit(1);
            }
            print("���Զ�web��������php4��֧�ֵļ��.\n");
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
        print("����ɵİ�װ?...");

        # create subdirectory to hold old version (if it doesn't exist)
        my($OldVerDir) = "${DstDir}/OLDVER-${OldSptVersion}";
        if (! -d $OldVerDir)
        {
            `mkdir ${OldVerDir}`;
        }

        # check that old version subdirectory is writable
        if ((! -d $OldVerDir) || (! -w $OldVerDir))
        {
            print("\n���ܴ��� ${OldVerDir}\n");
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

        print("���.\n");
    }

    # unpack distribution archive
    print("��ѹ���������ļ�...");
    my($FullDistArchiveName) = $OurHomeDir."/".$DistArchiveName;
    my($WorkDir) = "/tmp/csdlspt-".$SptVersion;
    chdir("/tmp");
    `tar xzf ${FullDistArchiveName}`;
    print("done.\n");

    # if user requested upgrade
    if ($UpgradeRequested)
    {
        # for each file in checksum list for old install
        print("�������������Ҫ������html�ļ�...");
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
                    print("\n\n�����ļ�У���ʱ��������.\n");
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
    print("��װĿ¼�����ļ�...");
    chdir($WorkDir);
    `tar cf - * | (cd ${DstDir} ; tar xpf -)`;
    `rm -r ${WorkDir}`;
    print("done.\n");

    # set up config file and make it writable
    print("׼�������ļ�...");
    chdir($DstDir);
    `chmod a+rwx include`;
    print("���.\n");

    # make sure permissions are okay
    print("�����ļ�Ȩ��...");
    `find . -type f -not -name INSTALLED -not -name SPT--Config.php -exec chmod a+r {} \\;`;
    `find . -type d -exec chmod a+rx {} \\;`;
    `chmod a+w SPTUI--Default/include/SPT--Stylesheet.css`;
    print("���.\n");

    # set up link to default page
    print("���õ� index.php������...");
    if (! -l "index.php") {  `ln -s SPT--Home.php index.php`;  }
    print("���.\n");

    # set up subdirectories
    print("������Ŀ¼...");
    if (! -d "ImageStorage") {  `mkdir ImageStorage`;  `chmod a+rwx ImageStorage`;  }
    if (! -d "ImageStorage/Previews") {  `mkdir ImageStorage/Previews`;  `chmod a+rwx ImageStorage/Previews`;  }
    if (! -d "ImageStorage/Thumbnails") {  `mkdir ImageStorage/Thumbnails`;  `chmod a+rwx ImageStorage/Thumbnails`;  }

    if (! -d "FileStorage") {  `mkdir FileStorage`;  `chmod a+rwx FileStorage`;  }

    if (! -d "TempStorage") {  `mkdir TempStorage`;  `chmod a+rwx TempStorage`;  }
    print("���.\n");

    # set up subdirectory soft links
    print("������Ŀ¼������...");
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

    print("���.\n");

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
            print("Crontab �ļ��Ѿ�������Ҫ���ӵ���.\n");

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

        print("���.\n");
    }
    else
    {
        print("Crontab file already contains entry for this SPT installation.\n");
    }
}


{
    # sign in
    print("\n");
    print("csdl-spt v${SptVersion}��װ���� \n");

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
            ."��װ����������в����Ѿ��ɹ�ִ��.\n"
            ."Ҫ���ʣ�ಿ�ֵİ�װ�����ҳ��:\n"
            ."    ${WebAddress}SPT--Install.php\n"
            ."����ݸ�ҳ�����ʾ���ʣ��İ�װ\n"
            ."\n"
            ."ллʹ��csdlspt !\n"
            );
}