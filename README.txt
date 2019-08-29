This folder contains MATLAB code for finding active electrodes. The codes calculate various metrics for active electrode selection and then perform clustering in the space defined by the metrics to find the active electrodes.

Description:

Code/:

ActElecFromModel.m: Finds active electrodes in the given data using a trained GMM model. Trained model must also be given as input. If ground_truth information active-inactive information for the electrode whose data is input is available, then sensitivity, specificity, and AUC-ROC are also computed. 

example.m: Example code to that (1) loads pre-trained GMM model for Induced Power High Gamma (IP-HG) feature and pre-computed IP-HG feature for a given subject, (2) uses pre-trained model to determine active electrodes for the given subject using ActElecFromModel.m function, (3) evalutes the prediction performance against ground truth.

gammaConsistency.m: calculates the gamma consistency metric which measures the "synchrony" between different sub-bands of gamma.

inducedPower.m: calculates the induced power metric. It is defined as the sum over time of the absolute value of the mena band power changes.

localGMMfunc.m: finds the GMM clusters and assignes the smaller cluster as the active electrode cluster. It also compares the result of the clustering with the ground truth active electrodes if available, and gives the sensitvity, specificity, and AUC-ROC. 

main_dummy.m: sort-of main file which describes the different steps involved in using the code in this repository to find active electrodes. Details comments have been provided along with example code. Code is commented out so that it can be appropriately modified. Going through the entire file before filling in the code is recommended.

smoothnessScore.m: calcaultes smoothness score for low theta and high theta bands. Smoothness score is defined as the 1-lag autocorrelation of the mean band power changes.

Data/:

subject_data.mat: Data from one subject. Contains the IP-HG and ground truth (active/inactive) value for each electrode in the subject.

trained_gmm_iphg.mat: Trained GMM using IP-HG feature from electrodes pooled from 115 subjects of the RAM Data. Subjects performed delayed free recall memory task.



