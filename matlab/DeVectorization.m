function Matrix = DeVectorization(Vector,Width,ColorCount)

Length = size(Vector,1);
Height = floor(Length/(Width*ColorCount));
Matrix = zeros(Height,Width,ColorCount);

index = 0;
for h = 1:Height
    for w = 1:Width
        for c = 1:ColorCount
            index = index + 1;
            Matrix(h,w,c) = Vector(index);
        end
    end
end

end

