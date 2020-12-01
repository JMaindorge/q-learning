function[threshold]= best_threshold(feature_col,label)
data_entropy=entropy1(label);
split=[];
all_entropy=[];
order_feature=sortrows(feature_col);
for i=1:(length(feature_col)-1)
    split(i)=order_feature(i) +(order_feature(i+1)-order_feature(i))/2;
end
split(length(feature_col))=order_feature(length(feature_col))+1;
for j=1:length(split)
    p1=0;
    p2=0;
    n1=0;
    n2=0;
    for i=1:length(feature_col)
        if feature_col(i)<split(j)
            if ismember(label(i),'M')
                p1=p1+1;
            else
                n1=n1+1;
            end
        end
        if feature_col(i)>=split(j)
            if ismember(label(i),'M')
                p2=p2+1;
            else
                n2=n2+1;
            end
        end
    end
    p1;
    n1;
    p2;
    n2;
    e1=(-p1/(p1+n1)*log2(p1/(p1+n1)))+(-n1/(p1+n1)*log2(n1/(p1+n1)));
    e2=(-p2/(p2+n2)*log2(p2/(p2+n2)))+(-n2/(p2+n2)*log2(n2/(p2+n2)));
    total_entropy=(e1*(p1+n1)/(length(feature_col)))+(e2*(p2+n2)/(length(feature_col)));
    all_entropy(j)=total_entropy;
end
all_entropy;
[B, I]=(min(all_entropy));
B;
info_gain=data_entropy-B;
threshold=split(I);
end