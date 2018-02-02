%% Suivi des objets dans un vidéo en mode Mean-Shift.g0
%% Description
% Trace un patch 'T' dans une séquence vidéo 'Movie'
% en utilisant l'algorithme Mean-Shift.


% [x,y,loss,f,f_indx] = MeanShift_Tracking(q,I2,Lmap,...
%     height,width,f_thresh,max_it,x0,y0,H,W,k,gx,gy,...
%     f,f_indx,loss)
% avec:
% (x,y) - la location de l'objet dans le cadre I2
% (f,f_indx) - stocker l'évolution de la similitude.
% loss - signal pour la perte de l'objet.
% I2 - le cadre suivant.
% f_thresh - le seuil de similarité.
% max_it - le nombre maximum d'itérations.
% x0,y0 - l'emplacement de l'objet.
% (k,gx,gy) - masque de noyau et ses gradients.



function [x,y,loss,f,f_indx] = MeanShift_Tracking(q,I2,Lmap,...
    height,width,f_thresh,max_it,x0,y0,H,W,k,gx,gy,f,f_indx,...
    loss)
% Initialisation
y = y0;
x = x0;
T2 = I2(y:y+H-1,x:x+W-1);
p = Density_estim(T2,Lmap,k,H,W,0);
% Nombre des iterations
step = 1;
% Calcul de la valeur de similarité
[fi,w] = Simil_func(q,p,T2,k,H,W);
f = cat(2,f,fi);
% Application de l'algorithme Mean-shift
while f(f_indx)<f_thresh && step<max_it
    step = step+1;
    f_indx = f_indx+1;
    num_x = 0;
    num_y = 0;
    den = 0;
    for i = 1:H
        for j=1:W
            num_x = num_x+i*w(i,j)*gx(i,j);
            num_y = num_y+j*w(i,j)*gy(i,j);
            den = den+w(i,j)*norm([gx(i,j) gy(i,j)]);
        end
    end
    % Le vecteur de déplacement (dx, dy) sur l'ascension de gradient
    if den ~= 0
        dx = round(num_x/den);
        dy = round(num_y/den);
        y = y+dy;
        x = x+dx;
    end
    % Détection de l'objet ciblé
    if (y<1 || y>height-H) || (x<1 || x>width-W)
        loss = 1;
        Target_Loss_Dialog_Box();
        uiwait(Target_Loss_Dialog_Box);
        break;
    end
    % Mise à jour l'objet.
    T2 = I2(y:y+H-1,x:x+W-1);
    p = Density_estim(T2,Lmap,k,H,W,0);
    [fi,w] = Simil_func(q,p,T2,k,H,W);
    f = cat(2,f,fi);
end
