%% Suivi des objets dans un vidéo en mode Mean-Shift.
%%
% Importez un fichier vidéo AVI à partir de son «path».


function [lngth,h,w,mov]=Import_mov(path)
infomov = VideoReader(path);
lngth = infomov.NumberOfFrames;
h = infomov.Height;
w = infomov.Width;
mov(1:lngth) = struct('cdata', zeros(h, w, 3, 'uint8'), 'colormap', []);
% Lire un cadre
for k = 1 : lngth
    mov(k).cdata = read(infomov, k);
end