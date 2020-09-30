open ($IN, '<', "231_BIL.html");

open ($OUT, '>', "231_BIL_PL.html");

while ($line = <$IN>)
{
    if ($line =~ TD)
    {
	$line =~ (.*</td>\s*<td>);
	print $line OUT;
	while $line =~ (.*target=\"_dict\">)(.*)<\;
	{
	    $german =~ $2;
	    $german =~ tr ///;
	    print "$1$german $OUT";
	}
	print "/a></td></tr>\n" $OUT;
    }

    else 
    {
	print $line OUT:
    }
