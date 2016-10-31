##Summary of Scripts and Data Used in Sparks et al. Developmental Cell, 2016  

---   
*This repository contains the data and scripts used for the manuscript - **"Establishment of expression in the SHORTROOT-SCARECROW transcriptional cascade through opposing activities of both activators and repressors"** by Sparks et al., Developmental Cell 2016*

For information and scripts related to webhosting networks - visit https://github.com/eesparks/Root_Transcriptional_Network.

###Network:
1. Enrichment_Analysis.R - Script for network randomization via edge switching.

###Motif_Analysis:
1. get_full_dataset.pl - PBM analysis.
2. run_snw_full_dataset.pl - PBM analysis.
3. seed_and_wobble.pl - PBM analysis.
4. escore_files - output of PBM analysis.
5. pwm_files - output of PBM analysis.


###Plotting_Motif_Related
1. Dendrogram.R - Script used to order TFs based on shared binding motif.
2. Shared_Motif_Matrix.csv - Indicates which motifs are assigned to each TF.
3. Shared_Target_Matrix2.csv - Matrix indicating the percent overlap of targets.
4. Heatmap.R - Script used to generate a heatmap of TFs based on shared targets.
3. TFBS_Plots.R - Script used to generate TF binding site plots with ggplot2.
4. SHR_Motifs.csv - FIMO predicted interactions for the SHORTROOT promoter (2.5kb).
5. SCR_Motifs.csv - FIMO predicted interactions for the SCARECROW promoter (2kb).


###Clustering:
1. Kmeans_Clustering.R  - Script used to cluster data from cell-type specific microarray data and AtGenExpress data.
3. AtGenExpress.csv - AtGenExpress values for the TFs in the network. Data includes the Developmental, Light, Abiotic, Biotic and Hormone assays.
4. AtGenExpress_Abiotic.csv - AtGenExpress Abiotic only.
5. AtGenExpress_Hormone.csv - AtGenExpress Hormone only.
6. AtGenExpress_Dev.csv - AtGenExpress Developmental only.
7. AtGenExpress_Biotic.csv - AtGenExpress Biotic only.
8. AtGenExpress_Light.csv - AtGenExpress Light only.
9. Microarray_CelLTypes.csv - Compiled root cell type specific expression data for the TFs in the network.
4. Pearson_Correlation.R - Script used to perform Pearson correlation on clusters.
5. Clusters_Summary.csv - Cluster assignment for node similarity based clustering, root cell type-specific microarray clustering and AtGenExpress clustering.
6. TestModuleClustering.R - Script used to cluster by node similarity.     


###FIMO_Input:
1. Network_Promoters_Fasta_Motif_Interactions_Only.txt - Promoter sequences input into FIMO. Only the promoters from the eY1H that were involved in an interaction with a TF where a motif was present was used. 
2. Motifs_MEME_Format_GTsubset_ALL.txt - the subset of motifs present in the eY1H network. Includes both motifs from the CIS-BP database and those motifs from the analysis here.

###Fluorescence_Quantification:

1. Sum_Projections.xls - Raw data from fluorescent quantification.
2. SHR_Fluor_Quant_New.csv - Summary of raw data from fluorescent quantification.
3. SHR_Fluor_Quant_New2.csv - Input file for plotting.
4. Box&Whisker_Plots.R - Plots.
5. Raw_Images Folder - contains images that were quantified.

###Root_Growth_Assays:
1. 012115_RootGrowth_Final - summary of daily root growth assessment/ Scale bar is set by one grid on the plate = 13mm.
2. Folders contain scanned images from plates of root growth assay.

###Meristem_Confocal_Images:
1. All images obtained at 7dai for different T-DNA lines.  Please refer to supplemental tables for more information.

###qRT-PCR:
1. SHR_qRT-PCR_Validation_Summary.xlsx - Summary of qRT-PCR experiments looking at changes in SHR expression.
2. SCR_qRT-PCR_Validation_Summary.xlsx - Summary of qRT-PCR experiments looking at changes in SCR expression.
3. qRTPCR_Plots.R - Plots.
4. TARGET_All.csv - qRT-PCR results from transient inducible experiments.


###Logistic_Regression:
1. MATLAB code used to run the logistic regression.




