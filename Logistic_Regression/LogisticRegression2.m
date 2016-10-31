%Logistic Regression Model for Activator and Repressor Relationships to
%Generate SHR Expression

%Input TF Expression in Different Tissues. Set Repressors as negative.

%First fit a general linearized model (glm)

%X contains the predictor data. examples (cell types) in rows, variables (TFs) in columns. 
X = horzcat (A1,A2,A3,A4,A5,R1,R2,R3,R5,R6,R7,R8,R9,R10);
XA = horzcat (A1,A2,A3,A4,A5);
XR = horzcat (R1,R2,R3,R5,R6,R7,R8,R9,R10);

%Y contains the target variable. 0 or 1 depending on the outcome. Here 0 is
%OFF and 1 is ON
Y= SHR_Outcome;
Y= transpose(Y);
Y1 = {'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'On' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'Off' 'On'}';
Y1=categorical(Y1);

%N contains the count of events for each row of the example data most 
%often, this will be a columns of 1s, the same size as Y. 

%B will contain the coefficients for the linear portion of the logistic
%regression.
%glmfit outputs a vector of regression coefficients, whereas fitglm outputs
%a regression object.
%In B the first term is the constant term, and the next elements are the
%coefficients for the input variables

B = glmfit(X, [Y ones(23,1)],'binomial', 'link', 'logit');
%B = fitglm(X, [Y ones(23,1)], 'Distribution','binomial');
BA = glmfit(XA, [Y ones(23,1)],'binomial', 'link', 'logit');
BR = glmfit(XR, [Y ones(23,1)],'binomial', 'link', 'logit');
%[B,dev,stats] = mnrfit(X,Y1)
%plotSlice(B)

%Testing loss of predictors to see if they still fit the model. 
%Here testing only 4,5,7,8,9,10,11,12,13,14,15.
X2 = horzcat (A4,A5,R2,R3,R5,R6,R7,R8,R9,R10);
B2 = glmfit(X2, [Y ones(23,1)], 'binomial', 'link', 'logit');

%Here testing only 1,2,3,6
X3 = horzcat (A1,A2,A3,R1);
B3 = glmfit(X3, [Y ones(23,1)], 'binomial','link','logit');

%Here testing only 1,3,5,7,9,11,13,15
X4 = horzcat (A1,A3,A5,R2,R6,R8,R10);
B4 = glmfit(X4, [Y ones(23,1)], 'binomial','link','logit');

%Here testing only 2,4,6,8,10,12,14
X5 = horzcat (A2,A4,R1,R3,R5,R7,R9);
B5 = glmfit(X5, [Y ones(23,1)], 'binomial','link','logit');

%Apply the linear part of the logistic regression
L = B(1) + X(:,1) * (B(2)) + X(:,2) * (B(3)) + X(:,3) * (B(4)) + X(:,4) * (B(5)) + X(:,5) * (B(6)) + X(:,6) * (B(7)) + X(:,7) * (B(8)) + X(:,8) * (B(9)) + X(:,9) * (B(10)) + X(:,10) * (B(11)) + X(:,11) * (B(12)) + X(:,12) * (B(13)) + X(:,13) * (B(14)) + X(:,14) * (B(15)) + X(:,15) * (B(16));
LA = BA(1) + XA(:,1) * (BA(2)) + XA(:,2) * (BA(3)) + XA(:,3) * (BA(4)) + XA(:,4) * (BA(5)) + XA(:,5) * (BA(6));
LR = BR(1) + XR(:,1) * (BR(2)) + XR(:,2) * (BR(3)) + XR(:,3) * (BR(4)) + XR(:,4) * (BR(5)) + XR(:,5) * (BR(6)) + XR(:,6) * (BR(7)) + XR(:,7) * (BR(8)) + XR(:,8) * (BR(9)) + XR(:,9) * (BR(10));
%L2 = B2(1) + X2(:,1) * (B2(2)) + X2(:,2) * (B2(3)) + X2(:,3) * (B2(4)) + X2(:,4) * (B2(5)) + X2(:,5) * (B2(6)) + X2(:,6) * (B2(7)) + X2(:,7) * (B2(8)) + X2(:,8) * (B2(9)) + X2(:,9) * (B2(10)) + X2(:,10) * (B2(11)) + X2(:,11) * (B2(12));
%L3 = B3(1) + X3(:,1) * (B3(2)) + X3(:,2) * (B3(3)) + X3(:,3) * (B3(4)) + X3(:,4) * (B3(5));
%L4 = B4(1) + X4(:,1) * (B4(2)) + X4(:,2) * (B4(3)) + X4(:,3) * (B4(4)) + X4(:,4) * (B4(5)) + X4(:,5) * (B4(6)) + X4(:,6) * (B4(7)) + X4(:,7) * (B4(8)) + X4(:,8) * (B4(9));
%L5 = B5(1) + X5(:,1) * (B5(2)) + X5(:,2) * (B5(3)) + X5(:,3) * (B5(4)) + X5(:,4) * (B5(5)) + X5(:,5) * (B5(6)) + X5(:,6) * (B5(7)) + X5(:,7) * (B5(8));

%Apply the logistic regression
Z = Logistic(B(1) + X(:,1) * (B(2)) + X(:,2) * (B(3)) + X(:,3) * (B(4)) + X(:,4) * (B(5)) + X(:,5) * (B(6)) + X(:,6) * (B(7)) + X(:,7) * (B(8)) + X(:,8) * (B(9)) + X(:,9) * (B(10)) + X(:,10) * (B(11)) + X(:,11) * (B(12)) + X(:,12) * (B(13)) + X(:,13) * (B(14)) + X(:,14) * (B(15)) + X(:,15) * (B(16)));
ZA = Logistic(BA(1) + XA(:,1) * (BA(2)) + XA(:,2) * (BA(3)) + XA(:,3) * (BA(4)) + XA(:,4) * (BA(5)) + XA(:,5) * (BA(6)));
ZR = Logistic(BR(1) + XR(:,1) * (BR(2)) + XR(:,2) * (BR(3)) + XR(:,3) * (BR(4)) + XR(:,4) * (BR(5)) + XR(:,5) * (BR(6)) + XR(:,6) * (BR(7)) + XR(:,7) * (BR(8)) + XR(:,8) * (BR(9)) + XR(:,9) * (BR(10)));

%Z2 = Logistic(B2(1) + X2(:,1) * (B2(2)) + X2(:,2) * (B2(3)) + X2(:,3) * (B2(4)) + X2(:,4) * (B2(5)) + X2(:,5) * (B2(6)) + X2(:,6) * (B2(7)) + X2(:,7) * (B2(8)) + X2(:,8) * (B2(9)) + X2(:,9) * (B2(10)) + X2(:,10) * (B2(11)) + X2(:,11) * (B2(12)));
%Z3 = Logistic(B3(1) + X3(:,1) * (B3(2)) + X3(:,2) * (B3(3)) + X3(:,3) * (B3(4)) + X3(:,4) * (B3(5)));
%Z4 = Logistic(B4(1) + X4(:,1) * (B4(2)) + X4(:,2) * (B4(3)) + X4(:,3) * (B4(4)) + X4(:,4) * (B4(5)) + X4(:,5) * (B4(6)) + X4(:,6) * (B4(7)) + X4(:,7) * (B4(8)) + X4(:,8) * (B4(9));
%Z5 = Logistic(B5(1) + X5(:,1) * (B5(2)) + X5(:,2) * (B5(3)) + X5(:,3) * (B5(4)) + X5(:,4) * (B5(5)) + X5(:,5) * (B5(6)) + X5(:,6) * (B5(7)) + X5(:,7) * (B5(8)));



%Try single activators or inhibitors
BA1 = glmfit(A1, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LA1 = BA1(1) + A1 * (BA1(2));
ZA1 = Logistic(BA1(1) + A1 * (BA1(2)));

BA2 = glmfit(A2, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LA2 = BA2(1) + A2 * (BA2(2));
ZA2 = Logistic(BA2(1) + A2 * (BA2(2)));

BA3 = glmfit(A3, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LA3 = BA3(1) + A3 * (BA3(2));
ZA3 = Logistic(BA3(1) + A3 * (BA3(2)));

BA4 = glmfit(A4, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LA4 = BA4(1) + A4 * (BA4(2));
ZA4 = Logistic(BA4(1) + A4 * (BA4(2)));

BA5 = glmfit(A5, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LA5 = BA5(1) + A5 * (BA5(2));
ZA5 = Logistic(BA5(1) + A5 * (BA5(2)));

BR1 = glmfit(R1, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LR1 = BR1(1) + R1 * (BR1(2));
ZR1 = Logistic(BR1(1) + R1 * (BR1(2)));

BR2 = glmfit(R2, [Y ones(23,1)], 'binomial', 'link', 'logit');
%LR2 = BR2(1) + R2 * (BR2(2));
ZR2 = Logistic(BR2(1) + R2 * (BR2(2)));

BR3 = glmfit(R3, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR3 = Logistic(BR3(1) + R3 * (BR3(2)));

%BR4= glmfit(R4, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZR4 = Logistic(BR4(1) + R4 * (BR4(2)));

BR5 = glmfit(R5, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR5 = Logistic(BR5(1) + R5 * (BR5(2)));

BR6 = glmfit(R6, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR6 = Logistic(BR6(1) + R6 * (BR6(2)));

BR7 = glmfit(R7, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR7 = Logistic(BR7(1) + R7 * (BR7(2)));

BR8 = glmfit(R8, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR8 = Logistic(BR8(1) + R8 * (BR8(2)));

BR9 = glmfit(R9, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR9 = Logistic(BR9(1) + R9 * (BR9(2)));

BR10 = glmfit(R10, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZR10 = Logistic(BR10(1) + R10 * (BR10(2)));

%Plot outcome of regression predictions (Z) versus real (Y)
SHR2 = transpose(SHR);
a=250;
C = transpose(SHR_Outcome);
%scatter(SHR2, ZA1 ,a,C,'filled')
%title('Activator (STK01)')
%xlabel('SHR Expression')
%ylabel('Probability P(x)')
