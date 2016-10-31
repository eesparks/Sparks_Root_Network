%Combinatorial Logistic Regression

%Activators
%CombA1 = horzcat (A1,A2);
%BCombA1 = glmfit(CombA1, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA1 = Logistic(BCombA1(1) + CombA1(:,1) * (BCombA1(2)) + CombA1(:,2) * (BCombA1(3)));

%CombA2 = horzcat (A1,A3);
%BCombA2 = glmfit(CombA2, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA2 = Logistic(BCombA2(1) + CombA2(:,1) * (BCombA2(2)) + CombA2(:,2) * (BCombA2(3)));

%CombA3 = horzcat (A1,A4);
%BCombA3 = glmfit(CombA3, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA3 = Logistic(BCombA3(1) + CombA3(:,1) * (BCombA3(2)) + CombA3(:,2) * (BCombA3(3)));

%CombA4 = horzcat (A1,A5);
%BCombA4 = glmfit(CombA4, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA4 = Logistic(BCombA4(1) + CombA4(:,1) * (BCombA4(2)) + CombA4(:,2) * (BCombA4(3)));

%CombA5 = horzcat (A2,A3);
%BCombA5 = glmfit(CombA5, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA5 = Logistic(BCombA5(1) + CombA5(:,1) * (BCombA5(2)) + CombA5(:,2) * (BCombA5(3)));

%CombA6 = horzcat (A2,A4);
%BCombA6 = glmfit(CombA6, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA6 = Logistic(BCombA6(1) + CombA6(:,1) * (BCombA6(2)) + CombA6(:,2) * (BCombA6(3)));

%CombA7 = horzcat (A2,A5);
%BCombA7 = glmfit(CombA7, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA7 = Logistic(BCombA7(1) + CombA7(:,1) * (BCombA7(2)) + CombA7(:,2) * (BCombA7(3)));

%CombA8 = horzcat (A3,A4);
%BCombA8 = glmfit(CombA8, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA8 = Logistic(BCombA8(1) + CombA8(:,1) * (BCombA8(2)) + CombA8(:,2) * (BCombA8(3)));

%CombA9 = horzcat (A3,A5);
%BCombA9 = glmfit(CombA9, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA9 = Logistic(BCombA9(1) + CombA9(:,1) * (BCombA9(2)) + CombA9(:,2) * (BCombA9(3)));

%CombA10 = horzcat (A4,A5);
%BCombA10 = glmfit(CombA10, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombA10 = Logistic(BCombA10(1) + CombA10(:,1) * (BCombA10(2)) + CombA10(:,2) * (BCombA10(3)));

%Repressors
CombR1 = horzcat (R1,R2);
BCombR1 = glmfit(CombR1, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR1 = Logistic(BCombR1(1) + CombR1(:,1) * (BCombR1(2)) + CombR1(:,2) * (BCombR1(3)));

CombR2 = horzcat (R1,R3);
BCombR2 = glmfit(CombR2, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR2 = Logistic(BCombR2(1) + CombR2(:,1) * (BCombR2(2)) + CombR2(:,2) * (BCombR2(3)));

%CombR3 = horzcat (R1,R4);
%BCombR3 = glmfit(CombR3, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR3 = Logistic(BCombR3(1) + CombR3(:,1) * (BCombR3(2)) + CombR3(:,2) * (BCombR3(3)));

CombR4 = horzcat (R1,R5);
BCombR4 = glmfit(CombR4, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR4 = Logistic(BCombR4(1) + CombR4(:,1) * (BCombR4(2)) + CombR4(:,2) * (BCombR4(3)));

CombR5 = horzcat (R1,R6);
BCombR5 = glmfit(CombR5, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR5 = Logistic(BCombR5(1) + CombR5(:,1) * (BCombR5(2)) + CombR5(:,2) * (BCombR5(3)));

CombR6 = horzcat (R1,R7);
BCombR6 = glmfit(CombR6, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR6 = Logistic(BCombR6(1) + CombR6(:,1) * (BCombR6(2)) + CombR6(:,2) * (BCombR6(3)));

CombR7 = horzcat (R1,R8);
BCombR7 = glmfit(CombR7, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR7 = Logistic(BCombR7(1) + CombR7(:,1) * (BCombR7(2)) + CombR7(:,2) * (BCombR7(3)));

CombR8 = horzcat (R1,R9);
BCombR8 = glmfit(CombR8, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR8 = Logistic(BCombR8(1) + CombR8(:,1) * (BCombR8(2)) + CombR8(:,2) * (BCombR8(3)));

CombR9 = horzcat (R1,R10);
BCombR9 = glmfit(CombR9, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR9 = Logistic(BCombR9(1) + CombR9(:,1) * (BCombR9(2)) + CombR9(:,2) * (BCombR9(3)));

CombR10 = horzcat (R2,R3);
BCombR10 = glmfit(CombR10, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR10 = Logistic(BCombR10(1) + CombR10(:,1) * (BCombR10(2)) + CombR10(:,2) * (BCombR10(3)));

%CombR11 = horzcat (R2,R4);
%BCombR11 = glmfit(CombR11, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR11 = Logistic(BCombR11(1) + CombR11(:,1) * (BCombR11(2)) + CombR11(:,2) * (BCombR11(3)));

CombR12 = horzcat (R2,R5);
BCombR12 = glmfit(CombR12, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR12 = Logistic(BCombR12(1) + CombR12(:,1) * (BCombR12(2)) + CombR12(:,2) * (BCombR12(3)));

CombR13 = horzcat (R2,R6);
BCombR13 = glmfit(CombR13, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR13 = Logistic(BCombR13(1) + CombR13(:,1) * (BCombR13(2)) + CombR13(:,2) * (BCombR13(3)));

CombR14 = horzcat (R2,R7);
BCombR14 = glmfit(CombR14, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR14 = Logistic(BCombR14(1) + CombR14(:,1) * (BCombR14(2)) + CombR14(:,2) * (BCombR14(3)));

CombR15 = horzcat (R2,R8);
BCombR15 = glmfit(CombR15, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR15 = Logistic(BCombR15(1) + CombR15(:,1) * (BCombR15(2)) + CombR15(:,2) * (BCombR15(3)));

CombR16 = horzcat (R2,R9);
BCombR16 = glmfit(CombR16, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR16 = Logistic(BCombR16(1) + CombR16(:,1) * (BCombR16(2)) + CombR16(:,2) * (BCombR16(3)));

CombR17 = horzcat (R2,R10);
BCombR17 = glmfit(CombR17, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR17 = Logistic(BCombR17(1) + CombR17(:,1) * (BCombR17(2)) + CombR17(:,2) * (BCombR17(3)));

%CombR18 = horzcat (R3,R4);
%BCombR18 = glmfit(CombR18, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR18 = Logistic(BCombR18(1) + CombR18(:,1) * (BCombR18(2)) + CombR18(:,2) * (BCombR18(3)));

CombR19 = horzcat (R3,R5);
BCombR19 = glmfit(CombR19, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR19 = Logistic(BCombR19(1) + CombR19(:,1) * (BCombR19(2)) + CombR19(:,2) * (BCombR19(3)));

CombR20 = horzcat (R3,R6);
BCombR20 = glmfit(CombR20, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR20 = Logistic(BCombR20(1) + CombR20(:,1) * (BCombR20(2)) + CombR20(:,2) * (BCombR20(3)));

CombR21 = horzcat (R3,R7);
BCombR21 = glmfit(CombR21, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR21 = Logistic(BCombR21(1) + CombR21(:,1) * (BCombR21(2)) + CombR21(:,2) * (BCombR21(3)));

CombR22 = horzcat (R3,R8);
BCombR22 = glmfit(CombR22, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR22 = Logistic(BCombR22(1) + CombR22(:,1) * (BCombR22(2)) + CombR22(:,2) * (BCombR22(3)));

CombR23 = horzcat (R3,R9);
BCombR23 = glmfit(CombR23, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR23 = Logistic(BCombR23(1) + CombR23(:,1) * (BCombR23(2)) + CombR23(:,2) * (BCombR23(3)));

CombR24 = horzcat (R3,R10);
BCombR24 = glmfit(CombR24, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR24 = Logistic(BCombR24(1) + CombR24(:,1) * (BCombR24(2)) + CombR24(:,2) * (BCombR24(3)));

%CombR25 = horzcat (R4,R5);
%BCombR25 = glmfit(CombR25, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR25 = Logistic(BCombR25(1) + CombR25(:,1) * (BCombR25(2)) + CombR25(:,2) * (BCombR25(3)));

%CombR26 = horzcat (R4,R6);
%BCombR26 = glmfit(CombR26, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR26 = Logistic(BCombR26(1) + CombR26(:,1) * (BCombR26(2)) + CombR26(:,2) * (BCombR26(3)));

%CombR27 = horzcat (R4,R7);
%BCombR27 = glmfit(CombR27, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR27 = Logistic(BCombR27(1) + CombR27(:,1) * (BCombR27(2)) + CombR27(:,2) * (BCombR27(3)));

%CombR28 = horzcat (R4,R8);
%BCombR28 = glmfit(CombR28, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR28 = Logistic(BCombR28(1) + CombR28(:,1) * (BCombR28(2)) + CombR28(:,2) * (BCombR28(3)));

%CombR29 = horzcat (R4,R9);
%BCombR29 = glmfit(CombR29, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR29 = Logistic(BCombR29(1) + CombR29(:,1) * (BCombR29(2)) + CombR29(:,2) * (BCombR29(3)));

%CombR30 = horzcat (R4,R10);
%BCombR30 = glmfit(CombR30, [Y ones(23,1)], 'binomial', 'link', 'logit');
%ZCombR30 = Logistic(BCombR30(1) + CombR30(:,1) * (BCombR30(2)) + CombR30(:,2) * (BCombR30(3)));

CombR31 = horzcat (R5,R6);
BCombR31 = glmfit(CombR31, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR31 = Logistic(BCombR31(1) + CombR31(:,1) * (BCombR31(2)) + CombR31(:,2) * (BCombR31(3)));

CombR32 = horzcat (R5,R7);
BCombR32 = glmfit(CombR32, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR32 = Logistic(BCombR32(1) + CombR32(:,1) * (BCombR32(2)) + CombR32(:,2) * (BCombR32(3)));

CombR33 = horzcat (R5,R8);
BCombR33 = glmfit(CombR33, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR33 = Logistic(BCombR33(1) + CombR33(:,1) * (BCombR33(2)) + CombR33(:,2) * (BCombR33(3)));

CombR34 = horzcat (R5,R9);
BCombR34 = glmfit(CombR34, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR34 = Logistic(BCombR34(1) + CombR34(:,1) * (BCombR34(2)) + CombR34(:,2) * (BCombR34(3)));

CombR35 = horzcat (R5,R10);
BCombR35 = glmfit(CombR35, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR35 = Logistic(BCombR35(1) + CombR35(:,1) * (BCombR35(2)) + CombR35(:,2) * (BCombR35(3)));

CombR36 = horzcat (R6,R7);
BCombR36 = glmfit(CombR36, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR36 = Logistic(BCombR36(1) + CombR36(:,1) * (BCombR36(2)) + CombR36(:,2) * (BCombR36(3)));

CombR37 = horzcat (R6,R8);
BCombR37 = glmfit(CombR37, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR37 = Logistic(BCombR37(1) + CombR37(:,1) * (BCombR37(2)) + CombR37(:,2) * (BCombR37(3)));

CombR38 = horzcat (R6,R9);
BCombR38 = glmfit(CombR38, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR38 = Logistic(BCombR38(1) + CombR38(:,1) * (BCombR38(2)) + CombR38(:,2) * (BCombR38(3)));

CombR39 = horzcat (R6,R10);
BCombR39 = glmfit(CombR39, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR39 = Logistic(BCombR39(1) + CombR39(:,1) * (BCombR39(2)) + CombR39(:,2) * (BCombR39(3)));

CombR40 = horzcat (R7,R8);
BCombR40 = glmfit(CombR40, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR40 = Logistic(BCombR40(1) + CombR40(:,1) * (BCombR40(2)) + CombR40(:,2) * (BCombR40(3)));

CombR41 = horzcat (R7,R9);
BCombR41 = glmfit(CombR41, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR41 = Logistic(BCombR41(1) + CombR41(:,1) * (BCombR41(2)) + CombR41(:,2) * (BCombR41(3)));

CombR42 = horzcat (R7,R10);
BCombR42 = glmfit(CombR42, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR42 = Logistic(BCombR42(1) + CombR42(:,1) * (BCombR42(2)) + CombR42(:,2) * (BCombR42(3)));

CombR43 = horzcat (R8,R9);
BCombR43 = glmfit(CombR43, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR43 = Logistic(BCombR43(1) + CombR43(:,1) * (BCombR43(2)) + CombR43(:,2) * (BCombR43(3)));

CombR44 = horzcat (R8,R10);
BCombR44 = glmfit(CombR44, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR44 = Logistic(BCombR44(1) + CombR44(:,1) * (BCombR44(2)) + CombR44(:,2) * (BCombR44(3)));

CombR45 = horzcat (R9,R10);
BCombR45 = glmfit(CombR45, [Y ones(23,1)], 'binomial', 'link', 'logit');
ZCombR45 = Logistic(BCombR45(1) + CombR45(:,1) * (BCombR45(2)) + CombR45(:,2) * (BCombR45(3)));












