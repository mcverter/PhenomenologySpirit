use Carp;
use strict;
use FileHandle;

my $IN = FileHandle->new();
my $OUT = FileHandle->new();
my $line;
my $german;

my @infiles = glob("*FINAL.html");
my @morefiles =  glob ("*BIL.html");
push @infiles, @morefiles;
my $infile;
my $outfile;



foreach my $file (@infiles)
{
    $infile = $file;
    $outfile = $file . "_BK.html";
    open ($IN, '<', $infile);
    open ($OUT, '>', $outfile);


while ($line = $IN->getline())
{
    if (($line =~ /[tT][[dD]/) && ($line =~ /(.*<\/[Tt][Dd]>\s*<[Tt][Dd]>)(.*)/))
    {
	$OUT->print ($1);
	my $buffer = $2;
        if ($buffer =~ /(.*?target=\"_dict\">)(.*)</)
	{
	    while ($buffer =~ /(.*?target=\"_dict\">)(.*?)(<.*)/)
	    {
		$german = $2;
		$german =~ s/Ä/&Auml/g;
		$german =~ s/ä/&auml/g; 
		$german =~ s/É/&Eacute/g;
		$german =~ s/é/&eacute/;
		$german =~ s/Ö/&Ouml/g; 
		$german =~ s/ö/&ouml/g; 
		$german =~ s/Ü/&Uuml/g; 
		$german =~ s/ü/&uuml/g; 
		$german =~ s/ß/&szlig/g; 
		$OUT->print( "$1", "$german");
		$buffer = $3;
	    }
	    $OUT->print ($buffer, "\n") ;
	}
	else 
	{
	    $OUT->print ($buffer, "\n");
	}
    }
    else
    {
        $OUT->print ($line);
    }

}

#print "performing diff $infile $outfile";
#system ("diff $infile $outfile");

}


#Ä  	&Auml; 	&#196; 	Capital A-umlaut
#ä  	&auml; 	&#228; 	Lowercase a-umlaut
#É 	&Eacute; 	&#201; 	Capital E-acute
#é 	&eacute; 	&#233; 	Lowercase E-acute
#Ö  	&Ouml; 	&#214; 	Capital O-umlaut
#ö  	&ouml; 	&#246; 	Lowercase o-umlaut
#Ü  	&Uuml; 	&#220; 	Capital U-umlaut
#ü  	&uuml; 	&#252; 	Lowercase u-umlaut
#ß 	&szlig; 	&#223; 	SZ ligature
#« 	&laquo; 	&#171; 	Left angle quotes
#» 	&raquo; 	&#187; 	Right angle quotes
#„ 	  	&#132; 	Left lower quotes
#“ 	  	&#147; 	Left quotes
#” 	  	&#148; 	Right quotes
#° 	  	&#176; 	Degree sign (Grad)
#€ 	&euro; 	&#128; 	Euro
#£ 	&pound; 	&#163; 	Pound Sterling
