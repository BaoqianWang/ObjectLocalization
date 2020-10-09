clc;
clear;


%%%%%%%%%%%%%%%Read Pixel Location from txt file%%%%%%%%%%%%%%%%%%%
fileID=fopen('./PositionData/pixelPosition0523.txt');
C=textscan(fileID,'%s');

cellLength=length(C{1,1});
intData=[];
for i=1:cellLength
   tempNum =regexp(C{1,1}{i,1},'\d+','match');
   intData=[intData,str2num(tempNum{1,1})];
end

xpixelData=intData(1,4:5:end);
ypixelData=intData(1,5:5:end);
dataLength=length(xpixelData);


%rate 66ms real position



%%%%%%%%%%%%%%%Read Real Location from csv file%%%%%%%%%%%%%%%%%%%%
realData=xlsread('./PositionData/Bao_GT_vicon.csv');
realX=realData(1:end,6);
realY=realData(1:end,7);
initialTime=realData(1,1)./1E9;
realTime=realData(1:end,1)./1E9;
realTime=realTime-initialTime;


%%%%%%%%%%%%%%%Implement Geolocation Algorithm%%%%%%%%%%%%%%%%%%%%%
fu=681;
fv=679;
h0=0.104;
ST=[0.411;0.231;2.219];
STz=ST(3);
centerx=320;
centery=240;
S2T=[0, -1, 0; -1, 0, 0; 0, 0,-1];
disCoe=[0.289 -1.08 0.0102 -0.0244 3.13];
totaloT=[];
for i=1:dataLength
xpixeldis=xpixelData(i);
ypixeldis=ypixelData(i);
xpixelnor=(xpixeldis-centerx)./fu;
ypixelnor=(ypixeldis-centery)./fv;
error=.001;
[xpixel,ypixel]=distortionCorrected(disCoe,xpixelnor,ypixelnor,error);
us=[xpixel;ypixel;1];
us=us./(norm(us));
uT=S2T*us;
r=(h0-STz)./uT(3);
oT=ST+r.*uT;
totaloT=[totaloT,oT];
end


estimatedTime=0:0.066667:(dataLength-1)*0.066667; %The Video is 0.066667s for each frame


indexTime=20;

estiD=(estimatedTime-indexTime);
realD=(realTime-indexTime);

estiIm=find(estiD==min(abs(estiD)));
realIm=find(realD==min(abs(realD)));

figure;
plot(realTime,realX,'linewidth',2);
hold on;
plot(estimatedTime,totaloT(1,:),'--','linewidth',2);
legend('Real Position','Estimated Position');
xlabel('Time (s)');
ylabel('X position (m)');
set(gca,'fontsize',16);


figure;
plot(realTime,realY,'linewidth',2);
hold on;
plot(estimatedTime,totaloT(2,:),'--','linewidth',2);
legend('Real Position','Estimated Position');
xlabel('Time (s)');
ylabel('Y position (m)');
set(gca,'fontsize',16);


figure;
plot(realX(1:realIm),realY(1:realIm),'linewidth',2);
hold on;
plot(totaloT(1,1:estiIm),totaloT(2,1:estiIm),'--','linewidth',2);
legend('Real Position','Estimated Position');
xlabel('X (m)');
ylabel('Y (m)');
set(gca,'fontsize',16);



