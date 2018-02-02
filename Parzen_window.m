%% Suivi des objets dans un vidéo en mode Mean-Shift.
%% Description
%Calcule le masque d'une fenêtre de Parzen


function [k,gx,gy] = Parzen_window(H,W,R,type,graph)
k = zeros(H,W);

%% ----Uniform----
if strcmp(type,'Uniform')==1
    for i=1:H
        for j=1:W
            if (((2*i)/H-1)/R)^2+(((2*j)/W-1)/R)^2 <= 1
                k(i,j) = 1;
            end
        end
    end
end

%% ----Triangular----
if strcmp(type,'Triangular')==1
    Max = max(H,W);
    for z=1:round(R*Max/2)-1
        h = zeros(H,W);
        for i=1:H
            for j=1:W
                if ((i-(H/2))/(R*H/2-z*H/Max))^2+...
                        ((j-(W/2))/(R*W/2-z*W/Max))^2 <= 1
                    h(i,j) = 2/(Max*R);
                end
            end
        end
        k = k+h;
    end
end

%% ----Epanechnikov
if strcmp(type,'Epanechnikov')==1
    for i=1:H
        for j=1:W
            k(i,j) = (1-(2*i/(R*H)-1/R)^2-...
                (2*j/(R*W)-1/R)^2);
            if k(i,j) < 0
                k(i,j) = 0;
            end
        end
    end
end

%% ----Gaussian----
if strcmp(type,'Gaussian')==1
    sigmaH = (R*H/2)/3;
    sigmaW = (R*W/2)/3;
    % sigma = x/3 comme un gaussien est presque égal à 0
    % de 3*sigma.
    for i=1:H
        for j=1:W
            k(i,j) = exp(-.5*((i-.5*H)^2/sigmaH^2+...
                (j-.5*W)^2/sigmaW^2));
        end
    end
end

%% Gradient de noyau
[gx,gy] = gradient(-k);

%% Tracer la fenêtre
if graph==1
    figure (4)
    scrsz = get(0,'ScreenSize');
    set(4,'Position',[scrsz(3)/4 scrsz(4)/4 ...
        scrsz(3)/1.5 scrsz(4)/1.5])
    subplot(2,2,1)
    mesh(k);
    surf(k);
    shading interp
    subplot(2,2,2)
    mesh(gx);
    surf(gx);
    shading interp
    subplot(2,2,3)
    mesh(gy);
    surf(gy);
    shading interp
end