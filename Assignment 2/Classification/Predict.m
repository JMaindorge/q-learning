% Given a sample of test data, return 1 if it got it right, 
% and 0 if it was wrong
function [tP,aP,rP,fP,tN,aN,rN,fN,acc] = Predict(Tree, Samples)
    
    %Send the testing data to the prediction function to run through
    %accuracy = 0;
    tP = 0;
    aP = 0;  
    rP = 0;
    tN = 0;
    aN = 0;
    rN = 0;
    acc = 0;
    
    for i = 1:size(Samples, 1)
        [a,b,c,d,e,f,g] = Search(Tree, Samples(i,:));
        tP = tP + a;
        aP = aP + b;
        rP = rP + c;
        
        tN = tN + d;
        aN = aN + e;
        rN = rN + f;
        
        acc = acc + g;
    end
    
    fP = 2*((tP*aP)/(tP+aP));
    fN = 2*((tN*aN)/(tN+aN));
    
    acc = acc / size(Samples, 1) * 100;
end

function [tP,aP,rP,tN,aN,rN,acc] = Search(Tree, Sample)
    root = Tree;
    
    %If the node has the field attribute, then it's not a leaf
    while isfield(root,'attribute')
        %Check if value 
         if Sample(1,root.attribute) < root.threshold
             %Delete the attribute field from the sample we've been given
             Sample(:, root.attribute) = [];
             root = root.kids{1,1};
         else
             %Delete the attribute field from the sample we've been given
             Sample(:, root.attribute) = [];
             
             %Check if the node only has one child, so we don't crash
             if size(root.kids, 2) == 1
                 root = root.kids{1,1};
             else
                 root = root.kids{1,2};
             end
         end
    end
    
    if root.prediction == 1
        aP = 1;
        if Sample(1, end) == 1
            acc = 1;
            tP = 1;
            rP = 1;
            rN = 0;
            
        else
            rN =  1;
            acc = 0;
            tP = 0;
            rP = 0;
        end
        tN = 0;
        aN = 0;
        
    else
        aN = 1;
        if Sample(1, end) == 0
            tN = 1;
            acc = 1;
            rP = 0;
            rN = 1;
        else
            tN = 0;
            acc = 0;
            rP = 1;
            rN = 0;
        end
        aP = 0;
        tP = 0;
    end
    
    %Reaching here, we can comfortably assume the node is now a leaf node
    %with a prediction
    %if Sample(1, end) == root.prediction
        %pred = 1;
    %else
        %pred = 0;
    %end
end