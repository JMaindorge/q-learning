T = readtable('data.csv');
T = removevars(T,{'Var1'});
Branch1=T;
Branch2=T;
labels=table2array(T(:,1));
all_threshold=[];
for i=1:width(T)-1
    all_threshold(i)=best_threshold(table2array(T(:,i+1)),labels);
end
[B, I]=max(all_threshold);
I
[info_gain,threshold]= best_threshold(table2array(T(:,I+1)),labels)


first_node=table2array(T(:,I+1));
Branch1(Branch1.(I+1)<threshold,:)=[];
Branch2(Branch2.(I+1)>=threshold,:)=[];

Branch1;
Branch2;
all_threshold=[];
for i=1:width(Branch1)-1
    all_threshold(i)=best_threshold(table2array(Branch1(:,i+1)),table2array(Branch1(:,1)));
end
[B, I]=max(all_threshold);
I
[info_gain,threshold]= best_threshold(table2array(Branch1(:,I+1)),table2array(Branch1(:,1)))



all_threshold=[];
for i=1:width(Branch2)-1
    all_threshold(i)=best_threshold(table2array(Branch2(:,i+1)),table2array(Branch2(:,1)));
end
[B, I]=max(all_threshold);
I
[info_gain,threshold]= best_threshold(table2array(Branch2(:,I+1)),table2array(Branch2(:,1)))
