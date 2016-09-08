#!/usr/bin/perl
use strict;
use warnings;

use lib '/nfs/labs/gordanlab/PBM_analysis/modules/';
use seed_and_wobble_modules;

##################################################################
### seed_and_wobble.pl
###
### Takes as input a two-column list of all "combinatorial" probe
###   intensities and sequences.  MUST BE PRE-ORDERED FROM BRIGHTEST
###   TO DIMMEST.
### Also takes file of gapped patterns (e.g., 11111.111) to
###   consider as candidate seeds.
### Also takes file of all gapped patterns (e.g., 111..11.1.11) that
###   are covered evenly on the universal array design.  This may be
###   the same as or longer than the above file of candidate seeds.
###
### Outputs list of all possible k-mers and their corresponding
###   enrichment score, median signal, and Z score (separate file for each seed).
### Also outputs single integrated file for all seeds above a cutoff.
### Also outputs file of top "N" position weight matrices.
###
### M. Berger 05/02/07 (adapted from A. Philippakis)
###   Modified 04/04/08
##################################################################

if($#ARGV !=4){die "Usage is:\n\tPBM data (sorted by intensities)\n\twidth of k-mers to inspect\n\tlist of candidate seed patterns (e.g., 11111.111)\n\tlist of all covered gapped patterns (e.g., 111..11.1.11)\n\toutput file prefix\nFor example, \"perl seed_and_wobble.pl TF_combinatorial.txt 8 query_patterns.txt all_patterns.txt output_prefix\"\n\n";}

my $intensity_file=shift; #PBM data file, two columns (intensity, sequence), pre-sorted from brightest to dimmest
my $order=shift; #k-mer order to use for seed patterns
my $seed_pattern_file=shift; #spaced seeds covered on array for seed determination
my $total_pattern_file=shift; #all spaced seeds covered on array
my $output_prefix=shift; #prefix for output files

##############################################################################
### PARAMETERS
my $spotlength=35; # total number of nucleotides in probe after common primer
my $startposition=2; # position from end of probe to consider, starting at 1
my $Escore_cutoff=0.25; # to store for integrated list of top k-mers from all seeds
my $print_seeds = "yes"; # "yes" if output file for each seed is desired
my $print_top_seeds = "yes"; # "yes" if output file for top seeds (above cutoff) is desired
my $topN = 5; # number of top k-mer seeds to use for seed-and-wobble PWM construction

###########################################################################
### Read in list of gapped patterns to consider for seeds
###########################################################################

my @seed_patterns;

open (FH1, "<$seed_pattern_file") or die "Cannot open seed patterns file.\n";

while (my $text = <FH1>) {
	my $numinfopos=0;
	chomp $text;
	push @seed_patterns, $text;	
	my @characters = split//,$text;
	for (my $p=0; $p<=$#characters; $p++) {
		if ($characters[$p] ne ".") {$numinfopos++;}
	}
	if ($numinfopos != $order) {
		die "Number of positions in seed $text in $seed_pattern_file does not agree with order = $order\n";
	}
}	

close FH1;

#################################################################
### Read in intensities and create array of sequences
#################################################################

my @data_matrix;

open (FH, "<$intensity_file") or die "Cannot open intensity file.\n";

my $spot = 1;

while (my $text = <FH>) {
    chomp $text;
    my @line = split ("\t", $text);
    $data_matrix[$spot][0] = $line[0]; ### spot intensity
    $data_matrix[$spot][1] = $line[1]; ### spot sequence
    if ($spot > 1) {
	if ($data_matrix[$spot][0]>$data_matrix[$spot-1][0]) {
	    die "Probes in input file are not sorted from brightest to dimmest.\n";
	}
    }
    $spot++;
}

close FH;

###############################################################################
### Calculate median intensity and enrichment score and Z score for each 8-mer
###############################################################################

my $numberspotsarray=$#data_matrix; #number of spots on array
my $tally=0;
my %top_kmerareas = ();
my %top_kmermedians = ();
my %top_kmerzscores = ();
my %kmerranks;
my $outputfile1;
my $keepfraction=0.5;

while ($tally<=$#seed_patterns) {

	if ($print_seeds eq "yes" || $tally ==0) {
	    if ($print_seeds eq "yes") {
		$outputfile1=$output_prefix."_".$order."mers_".$seed_patterns[$tally].".txt";
	    }
	    else {$outputfile1=$output_prefix."_".$order."mers.txt";}
	    open(OUTPUT1,">$outputfile1") || die "Cannot create k-mers output file.\n";
	    my $toplabel = $order."-mer";
	    print OUTPUT1 "$toplabel\t$toplabel\tE-score\tMedian\tZ-score\n";
	}

	%kmerranks = (); #data structure that stores ranks of every k-mer
	my %kmerintensities = (); #data structure that stores intensities of every k-mer
	my %kmerareas = (); #stores area for each gapped k-mer

	#get the ranks of every k-mer of the spaced seed in @seed_patterns

	my %observedpatterns = ();
	my $key;
	my $spaced_seed = $seed_patterns[$tally];
	my @split_seed = split//,$spaced_seed;
	my $rev_spaced_seed = reverse $spaced_seed;
	my @split_rev_seed = split//,$rev_spaced_seed;
	my $spaced_seed_width = length $spaced_seed;

	print "Currently on spaced seed: $spaced_seed\n";

	for (my $spotnumber=1; $spotnumber<=$#data_matrix; $spotnumber++) {
	    for (my $i=$startposition; $i<=$spotlength-$spaced_seed_width+1; $i++) {
		    my $currentstring = substr($data_matrix[$spotnumber][1], $i-1, $spaced_seed_width);
		    my @splitstring = split//,$currentstring;
		    my $fwd_element="";
		    my $rev_element="";
		    my $counter;
		    for ($counter=0; $counter<$spaced_seed_width; $counter++) {
			if ($split_seed[$counter] eq "1") {
				$fwd_element = $fwd_element.$splitstring[$counter];
			}
			else {
				$fwd_element = $fwd_element.".";
			}
		    }

		    my $rc_fwd_element = rc($fwd_element);
		    if ($fwd_element lt $rc_fwd_element) {$observedpatterns{$fwd_element}=0;}
		    else {$observedpatterns{$rc_fwd_element}=0;}

		    if ($spaced_seed ne $rev_spaced_seed) {
			for ($counter=0; $counter<$spaced_seed_width; $counter++) {
				if ($split_rev_seed[$counter] eq "1") {
					$rev_element = $rev_element.$splitstring[$counter];
				}
				else {
					$rev_element = $rev_element.".";
				}
			}

			my $rc_rev_element = rc($rev_element);
			if ($rev_element lt $rc_rev_element) {$observedpatterns{$rev_element}=0;}
			else {$observedpatterns{$rc_rev_element}=0;}
		    }			
	    }
	    foreach $key (keys %observedpatterns) {
		    push @{$kmerranks{$key}},$spotnumber;
		    push @{$kmerintensities{$key}},$data_matrix[$spotnumber][0];
	    }
	    undef %observedpatterns;
	    %observedpatterns=();
	    if ($spotnumber%1000==0) {print "$spotnumber\n";}
	}

	get_kmer_truncatedarea(\%kmerranks,\%kmerareas,$numberspotsarray,$keepfraction);

	###################################################################
	## Calculate median of all log (median), median absolute deviation
	###################################################################

	my @log_median=();
	my $bit_seed = $spaced_seed;
	$bit_seed =~ tr/./0/;
	$bit_seed = reverse $bit_seed;
	my $decimal_bit_seed = oct( "0b$bit_seed" );

	for (my $k=0; $k<4**($order); $k++) {
		my $word = gapped_convert_to_letters ($k, $order, $decimal_bit_seed, $spaced_seed_width);
		my $revcomp = rc($word);
		if ($word le $revcomp || $spaced_seed ne $rev_spaced_seed) {
			if ($word gt $revcomp) {$word = $revcomp;}
			if ($kmerintensities{$word}) {
			    my $medianintensity = median (\@{$kmerintensities{$word}});
			    my $log = log ($medianintensity);
			    push (@log_median, $log);
			}
		}
	}

	my $median_log_median = median (\@log_median);
	my @deviations=();

	for (my $counter=0; $counter<=$#log_median; $counter++) {
	    my $dev = abs ($log_median[$counter] - $median_log_median);
	    push (@deviations, $dev);
	}

	my $median_abs_dev = median (\@deviations);

	#############################################################
	## Print: Word / Enrichment / Median Intensity / Z-Score
	#############################################################

	for (my $k=0; $k<4**($order); $k++) {
		my $word = gapped_convert_to_letters ($k, $order, $decimal_bit_seed, $spaced_seed_width);
		my $revcomp = rc($word);
		if ($word le $revcomp || $spaced_seed ne $rev_spaced_seed) {
			if ($print_seeds eq "yes" || $tally == 0) {print OUTPUT1 "$word\t$revcomp\t";}
			if ($word gt $revcomp) {$word = $revcomp;}
			if ($kmerintensities{$word}) {
			    my $medianintensity = median (\@{$kmerintensities{$word}});
			    my $log = log ($medianintensity);
			    my $zscore = ($log - $median_log_median) / (1.4826 * $median_abs_dev);
			    if ($print_seeds eq "yes" || $tally == 0) {
				printf OUTPUT1 "%.5f\t", $kmerareas{$word};
				printf OUTPUT1 "%.2f\t", $medianintensity;
				printf OUTPUT1 "%.4f\n", $zscore;
			    }
			    if ($kmerareas{$word} > $Escore_cutoff) {
				$top_kmerareas{$word}=$kmerareas{$word};
				$top_kmermedians{$word}=$medianintensity;
				$top_kmerzscores{$word}=$zscore;
			    }
			}
			else {
			    if ($print_seeds eq "yes" || $tally == 0) {
				print OUTPUT1 "NA\tNA\tNA\n";}
			}
		}
	}
	undef %kmerranks;
	undef %kmerareas;
	undef %kmerintensities;

	close (OUTPUT1);

	$tally++;
}


#################################################
# Find top N seeds (adapted from A. Philippakis)
#################################################

print "Finding top $topN seeds.\n";

my @top_N_elements = ();
my @elementvalues;
my $key;
my $topNcounter=0;

foreach $key (keys %top_kmerareas) {
    push @elementvalues, {
	element=>$key,
	value=>$top_kmerareas{$key},
	median=>$top_kmermedians{$key},
	zscore=>$top_kmerzscores{$key}
    };
    $topNcounter++;
}
if ($topNcounter < $topN) {$topN = $topNcounter;}

@elementvalues = sort {$b->{value} <=> $a->{value}} @elementvalues;

for (my $N=0; $N<$topN; $N++) {
    push @top_N_elements, {
	element=>$elementvalues[$N]{element},
	value=>$elementvalues[$N]{value}
    };
}

if ($print_top_seeds eq "yes") {
    my $outputfile2 = $output_prefix."_".$order."mers_top_enrichment.txt";
    open(OUTPUT2,">$outputfile2") || die "Cannot create top k-mers output file.\n";
    my $toplabel = $order."-mer";
    print OUTPUT2 "$toplabel\t$toplabel\tE-score\tMedian\tZ-score\n";
    my $N=0;
    while ($elementvalues[$N]) {
	my $rc_element = rc($elementvalues[$N]{element});
	printf OUTPUT2 "$elementvalues[$N]{element}\t$rc_element\t%.5f\t%.2f\t%.4f\n", $elementvalues[$N]{value}, $elementvalues[$N]{median}, $elementvalues[$N]{zscore};
	$N++;
    }
    close (OUTPUT2);
}


#########################################################################################
### Read in list of all gapped patterns covered in universal PBM design (for wobble step)
#########################################################################################

my @total_patterns;

open (FH2, "<$total_pattern_file") or die "Cannot open total patterns file.\n";

while (my $text = <FH2>) {
	my $numinfopos=0;
	chomp $text;
	push @total_patterns, $text;	
	my @characters = split//,$text;
	for (my $p=0; $p<=$#characters; $p++) {
		if ($characters[$p] ne ".") {$numinfopos++;}
	}
	if ($numinfopos != $order) {
		die "Number of positions in seed $text in $total_pattern_file does not agree with order = $order\n";
	}
}	

close FH2;


###########################################################################
### Seed-and-Wobble PWM construction
###########################################################################

my %areapwm;
my $array=$intensity_file;

my $outputfile3 = $output_prefix."_".$order."mers_pwm.txt";
open(OUTPUT3,">$outputfile3") || die "Cannot create pwm output file.\n";

for (my $z=0; $z<=$#top_N_elements; $z++) {
	my $ranking = $z+1;
	print "Currently on element ranked:\t$ranking\n";
	my $seed = $top_N_elements[$z]{element};
	print "$seed\t";
	my $topescore = $top_N_elements[$z]{value};
	print "$topescore\n";
	print OUTPUT3 "$ranking\t$seed\t$top_kmerareas{$seed}\n\n";
	$seed = ".......".$seed.".......";

	wobble_seed_rerank(\%kmerranks,$seed,\%{$areapwm{$seed}},$array,$spotlength,$startposition,1);

	my $minimuminfopos=find_minimum_info_pos(\%{$areapwm{$seed}},$seed,log(10000));

	extend_seed_allpatterns_rerank(\%kmerranks,$seed,$minimuminfopos,\%{$areapwm{$seed}},$array,$spotlength,$startposition,1,\@total_patterns);

	while (($areapwm{$seed}{A}[0]==0) && ($areapwm{$seed}{C}[0]==0) && ($areapwm{$seed}{G}[0]==0) && ($areapwm{$seed}{T}[0]==0)) {
		shift @{$areapwm{$seed}{A}}; shift @{$areapwm{$seed}{C}}; shift @{$areapwm{$seed}{G}}; shift @{$areapwm{$seed}{T}};
	}

	while (($areapwm{$seed}{A}[-1]==0) && ($areapwm{$seed}{C}[-1]==0) && ($areapwm{$seed}{G}[-1]==0) && ($areapwm{$seed}{T}[-1]==0)) {
		pop @{$areapwm{$seed}{A}}; pop @{$areapwm{$seed}{C}}; pop @{$areapwm{$seed}{G}}; pop @{$areapwm{$seed}{T}};
	}
#	print OUTPUT3 "Enrichment score matrix\n\n";
#	foreach $key (sort keys %{$areapwm{$seed}}) {
#		print OUTPUT3 "$key:";
#		for (my $y=0; $y<=$#{$areapwm{$seed}{$key}}; $y++) {
#			print OUTPUT3 "\t$areapwm{$seed}{$key}[$y]";
#		}
#		print OUTPUT3 "\n";
#	}
#	print OUTPUT3 "\nEnergy matrix for enoLOGOS\n\n";
#	print OUTPUT3 "PO";
#	for (my $counter=1; $counter<=($#{$areapwm{$seed}{A}}+1); $counter++) {
#		print OUTPUT3 "\t$counter";
#	}
#	print OUTPUT3 "\n";
#	foreach $key (sort keys %{$areapwm{$seed}}) {
#		print OUTPUT3 "$key:";
#		for (my $y=0; $y<=$#{$areapwm{$seed}{$key}}; $y++) {
#		    my $logscaled = $areapwm{$seed}{$key}[$y]*(-log(10000));
#		    print OUTPUT3 "\t$logscaled";
#		}
#		print OUTPUT3 "\n";
#	}
##	print OUTPUT3 "\nReverse complement matrix for enoLOGOS\n\n";
##	print OUTPUT3 "PO";
##	for (my $counter=1; $counter<=($#{$areapwm{$seed}{A}}+1); $counter++) {
##		print OUTPUT3 "\t$counter";
##	}
##	print OUTPUT3 "\n";
##	foreach $key (sort keys %{$areapwm{$seed}}) {
##		my $compkey;
##		if ($key eq "A") {$compkey="T";}
##		if ($key eq "C") {$compkey="G";}
##		if ($key eq "G") {$compkey="C";}
##		if ($key eq "T") {$compkey="A";}
##		print OUTPUT3 "$compkey:";
##		for (my $y=$#{$areapwm{$seed}{$key}}; $y>=0; $y--) {
##		    my $logscaled = $areapwm{$seed}{$key}[$y]*(-log(10000));
##		    print OUTPUT3 "\t$logscaled";
##		}
##		print OUTPUT3 "\n";
##	}
#	print OUTPUT3 "\nProbability matrix\n";
	print OUTPUT3 "\n";
	foreach $key (sort keys %{$areapwm{$seed}}) {
		print OUTPUT3 "$key:";
		for (my $y=0; $y<=$#{$areapwm{$seed}{$key}}; $y++) {
			my $numerator = exp(log(10000)*$areapwm{$seed}{$key}[$y]);
			my $denominator = exp(log(10000)*$areapwm{$seed}{A}[$y]) + exp(log(10000)*$areapwm{$seed}{C}[$y]) + exp(log(10000)*$areapwm{$seed}{G}[$y]) + exp(log(10000)*$areapwm{$seed}{T}[$y]);
			my $probability = $numerator/$denominator;
			print OUTPUT3 "\t$probability";
		}
		print OUTPUT3 "\n";
	}
	print OUTPUT3 "\n\n\n";
}

close (OUTPUT3);
