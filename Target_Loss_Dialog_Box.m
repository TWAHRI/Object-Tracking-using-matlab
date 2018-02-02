%% Suivi des objets dans un vidéo en mode Mean-Shift.
%% Boîte avertissement qui s'affiche lorsque
% l'objet est perdue par le processus de suivi.


%%Pour l'exécuter, tapez 'Target_Loss_Dialog_Box' dans la ligne de commende.

function varargout = Target_Loss_Dialog_Box(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Target_Loss_Dialog_Box_OpeningFcn, ...
                   'gui_OutputFcn',  @Target_Loss_Dialog_Box_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



function Target_Loss_Dialog_Box_OpeningFcn(hObject, eventdata, handles, varargin)

% Choisissez la sortie de ligne de commande par défaut pour Target_Loss_Dialog_Box
handles.output = hObject;

% Mise à jour de la structure des poignées
guidata(hObject, handles);

% Réglez la boîte de dialogue au centre de l'écran
a = get(gcf,'Position');
width = a(3);
height = a(4);
scrsz = get(0,'ScreenSize');
set(gcf,'Position',[scrsz(3)/2-width/2 scrsz(4)/2-height/2 width height]);
% Afficher l'icône d'avertissement
icon = imread('Images/Objet_Perdu.bmp');
axes(handles.Loss_pict)
imshow(icon);


% ---Les sorties de cette fonction sont renvoyées dans la ligne de commande.
function varargout = Target_Loss_Dialog_Box_OutputFcn(hObject, eventdata, handles) 


% Obtenir la sortie de la ligne de commande par défaut de la structure des poignées
varargout{1} = handles.output;


%% Fermez la boîte de dialogue en appuyant sur OK
function Loss_OK_Callback(hObject, eventdata, handles)
delete(gcf);
