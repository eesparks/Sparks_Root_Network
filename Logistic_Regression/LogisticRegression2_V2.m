%First fit a general linearized model (glm)

%X contains the predictor data. examples (cell types) in rows, variables (TFs) in columns. 
X = horzcat (A1,A2,A3,A4,A5,R1,R2,R3,R5,R6,R7,R8,R9,R10);

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

%Calculate constant and coefficients
B = glmfit(X, [Y ones(23,1)],'binomial', 'link', 'logit');

%Apply logistic function
Z = Logistic(B(1) + X(:,1) * (B(2)) + X(:,2) * (B(3)) + X(:,3) * (B(4)) + X(:,4) * (B(5)) + X(:,5) * (B(6)) + X(:,6) * (B(7)) + X(:,7) * (B(8)) + X(:,8) * (B(9)) + X(:,9) * (B(10)) + X(:,10) * (B(11)) + X(:,11) * (B(12)) + X(:,12) * (B(13)));


%All Activators
%XA = horzcat (A1,A2,A3,A4,A5);
%BA = glmfit(XA, [Y ones(23,1)],'binomial', 'link', 'logit');
%ZA = Logistic(BA(1) + XA(:,1) * (BA(2)) + XA(:,2) * (BA(3)) + XA(:,3) * (BA(4)) + XA(:,4) * (BA(5)) + XA(:,5) * (BA(6)));

%All Repressors
%XR = horzcat (R1,R2,R3,R5,R6,R7,R8,R9,R10);
%BR = glmfit(XR, [Y ones(23,1)],'binomial', 'link', 'logit');
%ZR = Logistic(BR(1) + XR(:,1) * (BR(2)) + XR(:,2) * (BR(3)) + XR(:,3) * (BR(4)) + XR(:,4) * (BR(5)) + XR(:,5) * (BR(6)) + XR(:,6) * (BR(7)) + XR(:,7) * (BR(8)) + XR(:,8) * (BR(9)) + XR(:,9) * (BR(10)));


