%% Suivi des objets dans un vidéo en mode Mean-Shift.
%
%
%% Description
% Il permet de sélectionner un patch(objet) T à partir d'une image I.


function [T,x0,y0,H,W]=Select_patch(I,graph)
height = size(I,1);
width = size(I,2);
% Placez la figure au centre de l'écran,
% sans barre de menus ou axes.
scrsz = get(0,'ScreenSize');
figure (2)
set(2,'Name','Target Selection','Position',...
    [scrsz(3)/2-width/2 scrsz(4)/2-height/2 width height],...
    'MenuBar','none');
axis off
% Position de l'image à l'intérieur de la figure
set(gca,'Units','pixels','Position',[1 1 width height])

% Afficher l'image
imshow(I);
rect = getrect;
rect = floor(rect);
x0 = rect(1);
y0 = rect(2);
W = rect(3);
H = rect(4);
T = I(y0:y0+H-1,x0:x0+W-1,:);
if graph==1
    figure (3)
    set(3,'Name','Target Selected')
    imshow(T);
end
close (2)