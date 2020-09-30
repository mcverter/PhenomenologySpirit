use Carp;
use strict;
use FileHandle;

my $IN = FileHandle->new();
my $OUT = FileHandle->new();
my $line;
my $german;

my @infiles = glob("*_BK.html");
my $infile;
my $outfile;


foreach my $backup (@infiles)
{
    $backup =~ /(.*)_BK.html/;
    my $original = $1;
    system ("mv $original temp");
    system ("mv $backup $original");
    system ("mv temp $backup");
}
