#!/usr/bin/perl
use strict;
    use Carp;


my @files = <*_BIL.html>;
my $file;
print @files;

foreach $file (@files)
{
    print $file;
    system("iconv --from-code=ISO-8859-1 --to-code=UTF-8 ./$file >! ./temp.html");
    system ("cp $file $file" . "_BK");
    system ("mv temp.html $file");
}
