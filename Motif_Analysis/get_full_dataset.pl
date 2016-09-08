#!/usr/bin/perl -w

$file="/nfs/gordan_sata/Raluca/ErinSparks_BenfeyLab/Full_dataset_from_TimHughes/SignalIntensities.txt";
$list="full_dataset.list";

open(L,">$list")||die;
open(F,"$file")||die;
while(<F>){
	if($_=~/^Seq\s/){
		(@arr)=split /\s+/,$_;
		@samples=();
		for($i=1;$i<scalar(@arr);$i++){
			$name=$arr[$i]; $name=~s/:/_/g;
			$newdir="full_dataset/$name";
#			$sfile="full_dataset/$name".$name.".txt"; system "rm $sfile";
			$sfile="full_dataset/$name"."/".$name.".txt"; #system "rm $sfile";
#			system "mkdir $newdir";
			my ($allwc)=`wc $sfile`; my (@all)=split /\s+/,$allwc;
			print L $sfile,"\t",$all[1],"\n";
			push (@samples, $name);
		}
		die;next;
	}
	(@arr)=split /\s+/,$_;
if(scalar(@arr)!=scalar(@samples)+1){print $_,"\n";die;}
	$seq=$arr[0];
	for($i=1;$i<scalar(@arr);$i++){
		$sig=$arr[$i];
		if($sig eq "NA"){next;}
		
		$sample=$samples[$i-1];
		$sfile="full_dataset/$sample"."/".$sample.".txt";
		open(SF,">>$sfile")||die;
		print SF $sig,"\t",$seq,"\n";
		close(SF);
	}
	next;
}


