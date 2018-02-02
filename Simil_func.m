%% Suivi des objets dans un vidéo en mode Mean-Shift.


%% Description
% Mesurer la similitude entre deux estimations

% q est l'estimation d'un patch de référence
% p l'estimation d'un candidat 'T2'

function [f,w] = Simil_func(q,p,T2,k,H,W)

w = zeros(H,W);
f = 0;
for i=1:H
    for j=1:W
        w(i,j) = sqrt(q(T2(i,j)+1)/p(T2(i,j)+1));
        f = f+w(i,j)*k(i,j);
    end
end
% Normalisation de f
f = f/(H*W);