clear;clc;close;
filename='.\score2.xls';
record=xlsread(filename);
num=size(record,1);
credit_sum = 0.0;
GP_sum = 0.0;
for idx = 1:num
    credit = record(idx,2);
    score = record(idx,1);
    credit_sum = credit_sum + credit;
    if score >= 85
        GP_sum = GP_sum + 4.0 * credit;
    else 
        GP_sum = GP_sum + (4.0 - floor(85 - score) * 0.1)*credit;
    end   
end
GPA = GP_sum / credit_sum;

disp(GPA)