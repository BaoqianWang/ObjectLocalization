clc;
clear;
%%%%%%%%%%%%%%%Read location data from CSV file%%%%%%%%%%%%%%%%%%%%
locationData=xlsread('./PositionData/location.csv');


dataLength=length(locationData(:,1));
indexX=4;
indexY=5;
%%%%%%%%%%%%%%%Implement Geolocation Algorithm%%%%%%%%%%%%%%%%%%%%%
fu=707;
fv=693;
h0=0.104;
ST=[0.411;0.231;2.219];
STz=ST(3);
centerx=260;
centery=265;
S2T=[0, -1, 0; -1, 0, 0; 0, 0,-1];
disCoe=[0.289 -1.08 0.0102 -0.0244 3.13];
totaloT=[];
for i=1:dataLength
xpixeldis=locationData(i,indexX);
ypixeldis=locationData(i,indexY);
xpixelnor=(xpixeldis-centerx)./fu;
ypixelnor=(ypixeldis-centery)./fv;
error=.0000001;
[xpixel,ypixel]=distortionCorrected(disCoe,xpixelnor,ypixelnor,error);
us=[xpixel;ypixel;1];
us=us./(norm(us));
uT=S2T*us;
r=(h0-STz)./uT(3);
oT=ST+r.*uT;
totaloT=[totaloT,oT];
fprintf('%d: Estimation X= %f, Y=%f', i,oT(1),oT(2));
fprintf('%d: Real X= %f, Y=%f\n',i,locationData(i,2),locationData(i,3));
end

figure;
hold on;
plot(totaloT(1,:));
plot(locationData(:,2));
legend('Estimated','Real');
ylabel('X position');
xlabel('Index of Image');
set(gca,'fontsize',18);




figure;
hold on;
plot(totaloT(2,:));
plot(locationData(:,3));
legend('Estimated','Real');
ylabel('Y position');
xlabel('Index of Image');
set(gca,'fontsize',18);


% fprintf('Estimated X= %f\n', totaloT(1));
% fprintf('Estimated Y= %f\n', totaloT(2));



