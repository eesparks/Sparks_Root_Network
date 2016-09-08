#!/usr/bin/perl -w

$file="/nfs/gordan_sata/Raluca/ErinSparks_BenfeyLab/Full_dataset_from_TimHughes/SignalIntensities.txt";
#$list="full_dataset.list";

#open(L,">$list")||die;
open(F,"$file")||die;
while(<F>){
	if($_=~/^Seq\s/){
		(@arr)=split /\s+/,$_;
		for($i=1;$i<scalar(@arr);$i++){
			$name=$arr[$i]; $name=~s/:/_/g;
			$newdir="full_dataset/$name";
			$header=$newdir."/".$name;
			$sfile="full_dataset/$name"."/".$name.".txt"; #system "rm $sfile";
#			$re=`wc $sfile`; (@all)=split /\s+/,$re;
#			print L $sfile,"\t",$all[1],"\n";
			$sfile_sort=$sfile; $sfile_sort=~s/txt/sorted.txt/;
			system "sort -rn -k1,1 $sfile > $sfile_sort";
			print "Reading file: $sfile_sort","\n";
			system "perl /nfs/labs/gordanlab/PBM_analysis/seed_and_wobble_35bp.pl $sfile_sort 8 /nfs/labs/gordanlab/PBM_analysis/patterns_8of10.txt /nfs/labs/gordanlab/PBM_analysis/patterns_4*44k_all_8mer.txt $header";
		}
		last;
	}
}


