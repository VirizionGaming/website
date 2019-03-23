package SimLib;

use strict;
use SimHMAC;

# $Id: SimLib.pm,v 1.5 2002/10/22 21:02:59 adama Exp $

require Exporter;

@SimLib::ISA = qw( Exporter );
@SimLib::EXPORT = qw( &GenerateInspFP &InsertFP &get_submission ); 

sub GenerateInspFP
{
	my ($loginid, $txnkey, $amount, $sequence,$tstamp) = @_;

	&SimHMAC::hmac_hex($loginid ."^".$sequence."^".$tstamp."^".$amount."^",$txnkey);	
}

sub InsertFP
{
	my ($loginid, $txnkey, $amount) = @_;
	my $tstamp = time;
	my $sequence = int(rand 1000);

	my $fp = &GenerateInspFP($loginid, $txnkey, $amount, $sequence,$tstamp);

	print("<INPUT TYPE=\"HIDDEN\" NAME=\"x_fp_sequence\" VALUE=\"".$sequence."\">\n");
	print("<INPUT TYPE=\"HIDDEN\" NAME=\"x_fp_timestamp\" VALUE=\"".$tstamp."\">\n");
	print("<INPUT TYPE=\"HIDDEN\" NAME=\"x_fp_hash\" VALUE=\"".$fp."\">\n");

}


sub get_submission {
    my %ENTRY = ();
    my $GetPost = '';
    my $GetGet = $ENV{'QUERY_STRING'};

    my $cl = $ENV{'CONTENT_LENGTH'};
    if (defined{$cl}) {
        binmode(STDIN);
        while ($cl > 0 && read(STDIN, $_, $cl) > 0) {
            $GetPost .= $_;
            $cl -= length($_);
        }
        close STDIN;
    }

    my $submission = $GetGet . $GetPost;
    chomp $submission;

    # Split the name-value pairs
    foreach my $pair (split(/[&;]/, $submission)) {
        # Convert plus to space
        $pair =~ y/+/ /;

        # Split into key and value.
        my ($name, $value) = split(/=/, $pair, 2); # splits on the first =.

        # Convert %XX from hex numbers to character
        $name  =~ s/%([A-Fa-f0-9]{2})/pack("c", hex($1))/ge;
        $value =~ s/%([A-Fa-f0-9]{2})/pack("c", hex($1))/ge;

        # Associate key and value
        $ENTRY{$name} .= "\0" if (defined($ENTRY{$name}));
        $ENTRY{$name} .= $value;
    }
    return %ENTRY;
}




1;
