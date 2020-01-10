img=imread("3d.jpg");
[r,c,ch]=size(img);
if ch==3
img=rgb2gray(img);
end
H=detectHarrisFeatures(img);
%%%%%%HARRIS CORNER DETECTION%%%%%%%%%%%%
figure
imshow(img);hold on
plot(H)
title("Harris Corners");

%%%%%%%%%%%%INTERSECTION OF TWO LINES %%%%%%%%%% 
    figure;
   
    BW = edge(img, 'Canny');
    [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);
   
    P  = houghpeaks(H, 20, 'Threshold',0.5*max(H(:)));
    lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',40);

   
    imshow(img), hold on
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
      
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    end
   
   
   %i detect my first lines as 51 95, 96 291 
   %i detect my second lines  as 63 249 192 324
  l1p1=[984 685];
  l1p2=[1070 642];
  l2p1=[989 667];
  l2p2= [989 719];
  
  %% i get the numbers

   for i=1:length(lines)
      if isequal(lines(i).point1,l1p1) &&isequal(lines(i).point2,l1p2) 
          n1=i;
      end
        if isequal(lines(i).point1,l2p1) &&isequal(lines(i).point2,l2p2) 
         n2= i;
      end
   end
   
  
   line1=lines(n1);
   line2=lines(n2);
   
    b=[line1.rho ;line2.rho];
    A = [cosd(line1.theta) sind(line1.theta); cosd(line2.theta) sind(line2.theta)];
    Ainv=inv(A);
    res=Ainv*b;
 
    plot(res(1),res(2),'m*')
   
    x=0:size(img,1);
    y1=(line1.rho-x*cosd(line1.theta))/ sind(line1.theta);
    y2=(line2.rho-x*cosd(line2.theta))/ sind(line2.theta);
    
    
    plot(x,y1,"b");
    plot(x,y2,"b");
%     
    
 
    
   







