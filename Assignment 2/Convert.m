function b = Convert(a)
    b = double(categorical(a));
    for c = 1 : length(a)
        if a(c,:) == "M"
            b(c,:) = 1;
        else
            b(c,:) = 0;
        end
    end
end