function attr = computeOptimalSplitRegression(x, y)
nSmps = size(x,1);
nAttrs = size(x,2);
y=cell2mat(y);
%standard deviation calculation for all the labels
s_d=std(y(:,1));
%create empty arrays
splittedtruey={};
splittedfalsey={};
reductioncell={};
meantruecell={};
meanfalsecell={};
sdtrue={};
sdfalse={};
%Test for all attributes.
for i=1:nAttrs
    %make the number of true and false 0 so that it can enter the loop
    %again from 0
    truetimes=0;
    falsetimes=0;
    for j=1:nSmps
        %In this loop it checks all the samples for an attribute and sstores 
        % the corresponding value of the label
        if x{j,i}==1
            truetimes=true+1;
            
            splittedtruey{end+1} = y(j,1);
        else
            falsetimes=falsetimes+1;
            splittedfalsey{end+1} = y(j,1);
        end
    
    
    end 
    
    %calculate the sd of the 2 splits of labels 
    truesd=std(cell2mat(splittedtruey));    
    falsesd=std(cell2mat(splittedfalsey));
    %calculate a weighted standard deviation
    newsd=(truetimes/nSmps)*truesd+(falsetimes/nSmps)*falsesd;
    %calculate how much it reduced from the initial label sd
    %and store this value in an array
    reduction=s_d-newsd;
    reductioncell{end+1}=reduction;
    %calculate the mean and the sd of the true and false branch and store
    %them as they will be needed to to calculate the coefficient of variation
    meantruecell{end+1}=mean(cell2mat(splittedtruey));
    meanfalsecell{end+1}=mean(cell2mat(splittedfalsey));
    sdtrue{end+1}=std(cell2mat(splittedtruey));
    sdfalse{end+1}=std(cell2mat(splittedfalsey));
    
    
    
    
end
%find the index of attribute with the largest refuction in sd
max=0;
maxattr=0;
for i=1:nAttrs
    
    if reductioncell{i}>max
        max=reductioncell{i};
        maxattr=i;
    end
end
%calculate the coefficient of variation for the 2 branches
attr=maxattr;
cv_true=cell2mat(sdtrue(maxattr))/ cell2mat(meantruecell(maxattr))*100;
cv_false=cell2mat(sdfalse(maxattr))/ cell2mat(meanfalsecell(maxattr))*100;
end
