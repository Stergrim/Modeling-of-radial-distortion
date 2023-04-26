function NewImage = Distorsion(sourceImage,factor,autoCrop,backgroundColor,save)
% ������� ���������� ��������� ��������� �� �����������
% sourceImage - ����� ��������������� �����������, ��������: 'Test.jpg',
% ����� ����� ���� �������� ����� - ������-����� ��� ��� �������� �����;
% factor - ����������� ���������;
% autoCrop - ���/���� �������������� ������� �����������;
% backgroundColor - ���������� ����� ���� � RGB, ���� �� ���������
% �������������� �������;
% save - ���/���� ���������� ���������� � jpg.

% �������� �� ����� ����������
if nargin < 2
    error("������������ ����������");
elseif nargin == 2
    autoCrop = false;
    backgroundColor = [233, 72, 247];
    save = false;
elseif nargin == 3
    backgroundColor = [233, 72, 247];
    save = false;
elseif nargin == 4
    save = false;
end

% ������������ ������ ��� ����������� RGB
backgroundColor = circshift(backgroundColor,-1);

% �������� �����������
ImgStart = imread(sourceImage);

% ������ �������� �������� �����������
startHeight = size(ImgStart,1);
startWidth = size(ImgStart,2);
ColorCount = size(ImgStart,3);

% �������� ���������� ������� �����
if ColorCount ~= 3 && ColorCount ~= 1
    error("�������� ������� �����");
end

% ��������� ���������� ����������� ��� ���������� ������� ������� �����
% ���������
baseHeight = startHeight;
baseWidth = startWidth;
size_min = 3000;
max_size = max([baseHeight,baseWidth]);
if max_size < size_min
    percent = size_min/max_size;
    baseHeight = round(baseHeight*percent);
    baseWidth = round(baseWidth*percent);
    ImgStart = imresize(ImgStart,[baseHeight baseWidth]);
end

% ������������ ����������� ��� ����� ������� ������ ���������
scrPixels = Vectorization(ImgStart);
% ����� ��������������� �������
baseLength = size(scrPixels,1);
% ������������� ������� ��������� ��������
dstPixels = zeros(baseLength,1);

% ����� ����� ����
index = 1;
if ColorCount == 3
    while (index <= baseLength)
        dstPixels(index) = backgroundColor(1);
        index = index + 1;
        dstPixels(index) = backgroundColor(2);
        index = index + 1;
        dstPixels(index) = backgroundColor(3);
        index = index + 1;
    end
else
    while (index <= baseLength)
        dstPixels(index) = 125; % ����� ��� ��� �/�
        index = index + 1;
    end
end

% ����������� �� �������� factor
if ((factor < -1) || (factor > 1))
    error("������������ �������� factor");
end

% ���������� ��������� ��������� � ����������� �� �������� factor
if baseWidth < baseHeight
    Amplitude = floor(baseHeight/2)*factor;
else
    Amplitude = floor(baseWidth/2)*factor;
end

% ���������� ��� ����������� �����������
x1 = baseWidth;
y1 = baseHeight;
x2 = 0;
y2 = 0;

% �������� ���� ��������� ���������
aY = 0;
aX = 0;
index = baseWidth*ColorCount+1;
while (index <= baseLength)
    y = floor(index/(baseWidth*ColorCount));
    x = floor(index/ColorCount - y*baseWidth);

    angX = pi*x/baseWidth;
    caX = Amplitude*(baseHeight/2-y)/(baseHeight/2);
    
    angY = pi*y/baseHeight;
    caY = Amplitude*(baseWidth/2-x)/(baseWidth/2);
    
    if factor < 0
        aX = -caX;
        aY = -caY;
    end
    
    pY = floor(y+aX+caX*sin(angX));
    pX = floor(x+aY+caY*sin(angY));
    
    % ����������� ����� ��� ������� �����������
    if autoCrop
        if (factor >= 0)
            if (x == baseWidth/2)
                if (pY < y1)
                    y1 = pY;
                end
                if (pY > y2)
                    y2 = pY;
                end
            end
            if (y == baseHeight/2)
                if (pX < x1)
                    x1 = pX;
                end
                if (pX > x2)
                    x2 = pX;
                end
            end
        else
            if ((x == 1)&&(y == 1))
                y1 = pY;
                x1 = pX;
            end
            if ((x == baseWidth-1)&&(y == baseHeight-1))
                y2 = pY;
                x2 = pX;
            end
        end
    end
    
    % ����������� ����� ��������� ��������
    dstIndex = (pY*baseWidth+pX)*ColorCount;
    
    if ColorCount == 3
        dstPixels(dstIndex) = scrPixels(index);
        index = index + 1;
        dstPixels(dstIndex+1) = scrPixels(index);
        index = index + 1;
        dstPixels(dstIndex+2) = scrPixels(index);
        index = index + 1;
    else
        dstPixels(dstIndex) = scrPixels(index);
        index = index + 1;
    end
end

% �������������� ������� � �������
NewImage = DeVectorization(dstPixels,baseWidth,ColorCount);

% ��������� ������� �����������
if autoCrop
    targetSize = [abs(y2-y1) abs(x2-x1)];
    r = centerCropWindow2d(size(NewImage),targetSize);
    NewImage = imcrop(NewImage,r);
end

% ����������� � ��������� ������� �����������
NewImage = imresize(NewImage,[startHeight startWidth],'nearest');

% ���������� ������� �� ��������
NewImage = NewImage/(max(NewImage,[],'all'));

% �������������� �������� ������������������ ������ RGB
if ColorCount == 3
    NewImage = circshift(NewImage,[0 0 1]);
end

% ���������� ����������� � ������� jpg
if save
    imwrite(NewImage,'NewImage.jpg');
end

% ������������ ��������� � ������������� �����������
subplot(1,2,1), imshow(ImgStart)
subplot(1,2,2), imshow(NewImage)

end

