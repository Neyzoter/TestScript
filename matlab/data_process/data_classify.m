%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author:Neyzoter Soong
%  Date:2020-2-7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 清空变量、清屏
clear;clc;
% 文件地址
path = "./data.xlsx";
% 数值分类界限
% 这个界限可以自己调整
% 发现第一列>14的数值还是有的
thresholds = [0,4,8,12,14];
% 分类个数
class_num = length(thresholds) - 1;
data_num_in_classes = zeros(1,class_num);
% 读取文件
matrix = xlsread(path);
% 获取矩阵行数
matrix_row_num = size(matrix,1);
matrix_col_num = size(matrix,2);

% 每个类共有多少个数据
for idx = 1:matrix_row_num
    i = 1;
    while(i <= class_num)
        up = thresholds(i+1);
        down = thresholds(i);
        % 判断是否在该类中
        if (matrix(idx,1) <= up) && (matrix(idx,1) >= down)
            data_num_in_classes(i) = data_num_in_classes(i) + 1;
            break; % 退出while
        end
        i = i + 1;
    end
end

% 创建特定的一个cell，保存分类后的数据
for class_i = 1:class_num
    classifies_data{class_i} = zeros(data_num_in_classes(class_i),matrix_col_num);
    classifies_data_end{class_i} = 0;
end
% 给数据分类
for idx = 1:matrix_row_num
    i = 1;
    while(i <= class_num)
        up = thresholds(i+1);
        down = thresholds(i);
        % 判断是否在该类中
        if (matrix(idx,1) <= up) && (matrix(idx,1) >= down)
            data_num_in_classes(i) = data_num_in_classes(i) + 1;
            classifies_data{i}(classifies_data_end{i}+1,:) = matrix(idx,:);
            classifies_data_end{i} = classifies_data_end{i} + 1;
            break; % 退出while
        end
        i = i + 1;
    end
end

% 清空其他无用的变量
msg = sprintf('共 %d 个类, 分界线分别为',class_num);
disp(msg);
disp(thresholds);
clearvars -except classifies_data;
