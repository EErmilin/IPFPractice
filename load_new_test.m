clear all
[Filename Pathname]=uigetfile('*.dat','Select OCT dat file');
fid=fopen([Pathname Filename]);
data=fread(fid,'float');
Rx=512; %fast
Rz=256; %depth
Ry=512; %slow
% for y=1:Ry; 
%     for x=1:Rx 
%         for z=1:Rz  
%             datareal(x,y,z)=data(2*z-1+2*Rz*(x-1)+2*Rz*Rx*(y-1));
%             dataim(x,y,z)=data(2*z+2*Rz*(x-1)+2*Rz*Rx*(y-1));            
%         end
%     end
% end
h=waitbar(0,'Converting dat to mat');
for y=1:2*Ry
    for z=1:Rz 
        data3d1(z,y,:)=data(1+(z-1)*Rx+(y-1)*Rx*Rz:(z-1)*Rx+Rx+(y-1)*Rx*Rz);
    waitbar(y/(2*Ry))
    end
end
close(h);
for y=1:Ry
    data3d(:,y,:)=sqrt(data3d1(:,2*y-1,:).^2+data3d1(:,2*y,:).^2);
    phase3d(:,y,:)=atan(data3d1(:,2*y,:)./data3d1(:,2*y-1,:));
    complexsignalOCT(:,y,:)=data3d1(:,2*y-1,:)+1i*data3d1(:,2*y,:);
end
% data3d=10*log10(abs(data3d));

% figure
% imagesc(10*log10(squeeze(data3d(128,:,:))));
% colorbar
% colormap hot
% caxis([0 40])
save('OCT_full_data_new.mat','data3d');
save('OCT_full_phase_new.mat','phase3d');
save('OCT_complexsignal_new.mat','complexsignalOCT');
