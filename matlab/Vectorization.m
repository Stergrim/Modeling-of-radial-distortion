function Vector = Vectorization(Matrix)

[Height, Width, Color] = size(Matrix);
Length = Height*Width*Color;
Vector = zeros(Length,1);

index = 0;
for h = 1:Height
    for w = 1:Width
        for c = 1:Color
            index = index + 1;
            Vector(index) = Matrix(h,w,c);
        end
    end
end

end

