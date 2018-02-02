%% Suivi des objets dans un vid�o en mode Mean-Shift.
% GUI : interface graphique en matlab pour le mode Mean-Shift de suivi.
% Ex�cutez-le en tapant "GUI" dans la ligne de commande.

function varargout = GUI(varargin)
%      Graphical User Interface (GUI)!
%      GUI est cr�e pour GUI.fig
%      GUI  cr�e une nouvelle interface graphique ou g�nere le singleton
%      existant.
%
%      GUI c'est une interface graphique en matlab.
%
%      H = GUI renvoie la poign�e � une nouvelle interface graphique ou la
%      poign�e vers le singleton existant.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) appelle la fonction
%      locale nomm�e CALLBACK dans GUI.M avec les arguments d'entr�e donn�s.
%
%      GUI('Property','Value',...) cr�e une nouvelle interface graphique ou
%      augmente le singleton existant. � partir de la gauche, les paires de
%      propri�t�s sont appliqu�es � l'interface utilisateur avant 
%      GUI_OpeningFcn est appel�.  Un nom de propri�t� non reconnu ou une 
%      valeur non valide rend l'application arr�ter. Toutes les entr�es passent
%      � GUI_OpeningFcn via varargin.
%

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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



function GUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
% Aucun fichier n'a encore �t� s�lectionn�
handles.FileName = 0;
% Obtenez la couleur de fond
colour = get(handles.Video_Panel,'BackgroundColor');
% R�gler les ic�nes du bouton de Lecture
img = imread('Images\Play_up.bmp');
handles.icon_play_up = Set_Button_Bckgrnd(img,colour);
set(handles.Play,'CData',handles.icon_play_up);
img = imread('Images\Play_down.bmp');
handles.icon_play_down = Set_Button_Bckgrnd(img,colour);
% D�finir la valeur par d�faut du curseur de vitesse !!!!!
set(handles.Speed,'Value',10);
% D�finir les ic�nes des boutons d'entr�e / sortie de marquage
in = imread('Images\Mark_in.bmp');
out = imread('Images\Mark_out.bmp');
in = Set_Button_Bckgrnd(in,colour);
out = Set_Button_Bckgrnd(out,colour);
set(handles.Mark_in,'CData',in);
set(handles.Mark_out,'CData',out);
% R�gler l'ic�ne du bouton de S�lection d'objet
icon = imread('Images\Crop.bmp');
icon = Set_Button_Bckgrnd(icon,colour);
set(handles.Crop,'CData',icon);
icon = imread('Images\selection.bmp');
icon = Set_Button_Bckgrnd(icon,colour);
set(handles.Select_Target,'CData',icon);
% D�finir les options du noyau par d�faut
set(handles.Gaussian,'Value',1);
handles.Kernel_type = 'Gaussian';
handles.radius = str2double(get(...
    handles.Radius_edit,'String'))/100;
% D�finir limiteurs d'it�ration par d�faut
handles.f_thresh = str2double(get(...
    handles.F_thresh_edit,'String'));
handles.max_iter = str2double(get(...
    handles.Max_iter_edit,'String'));
% Mise � jour structure de la poign�e
guidata(hObject, handles);
% Affichage des images par d�faut
axes(handles.Target)
img = imread('Images\objet_defaut.png');
imshow(img);
axes(handles.Video)
img = imread('Images\defaut.png');
imshow(img);

%% Button de fonction du couleur du font
function icon = Set_Button_Bckgrnd(icon,colour)
for i=1:size(icon,1)
    for j=1:size(icon,2)
        if mean(icon(i,j,:))>= 196
            icon(i,j,:) = icon(i,j,:)-uint8(round(...
                255*(ones(1,1,3)-permute(colour,[1 3 2]))));
        end
    end
end

%% 
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  tableau de cellules pour retourner la sortie d'args (voir VARARGOUT);
% hObject    g�rer � figurer
% eventdata  r�serv� - � d�finir dans une future version de MATLAB
% handles    structure avec poign�es et donn�es d'utilisateur (voir GUIDATA)

% Obtenir la sortie de ligne de commande par d�faut de la structure des poign�es
varargout{1} = handles.output;

%% fonctions de cr�ation des objets
% Ex�cute lors de la cr�ation de l'objet
function Video_CreateFcn(hObject, eventdata, handles)
function Vid_Path_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function Slider_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Speed_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function Mark_in_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Mark_out_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Select_Target_CreateFcn(hObject, eventdata, handles)
function Target_CreateFcn(hObject, eventdata, handles)
function Radius_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function F_thresh_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Max_iter_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Similarity_Plot_CreateFcn(hObject, eventdata, handles)

%% frmer le boutton Call back
function Close_Callback(hObject, eventdata, handles)

display 'GUI closed. Thanks for using it. :)'
close(handles.MeanShift);

%% Appels d'entr�e vid�o
function Browse_Callback(hObject, eventdata, handles)

[FileName,PathName] = uigetfile({'*.avi','(*.avi) AVI video file'},...
    'S�lectionnez la vid�o AVI d entr�e ...');
if FileName~=0
    set(handles.Vid_Path,'String',strcat(PathName,FileName));
    Vid_Path_Callback(handles.Vid_Path,[], handles);
end


%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Vid_Path_Callback(hObject, eventdata, handles)
Path = get(hObject,'String');
if exist(Path,'file')==2
    L = length(Path);
    if L>3
        extension = Path(L-3:L);
        if strcmpi(extension,'.avi')==1
            set(hObject,'String',...
                'Importation de vid�o, soyez patient ...',...
                'ForegroundColor','red',...
                'FontWeight','bold');
            drawnow;
            [handles.lngth,handles.height,handles.width,...
                handles.Movie]=Import_mov(Path);
            set(hObject,'String',Path,...
                'ForegroundColor','black',...
                'FontWeight','normal');
            for i=L:-1:1
                if strcmp(Path(i),'\')==1
                    break;
                end
            end
            handles.FileName = Path(L-i:L-3);
            Video_Init(hObject,handles);
        end
    end
end

%% Initialisation de video
function Video_Init(hObject,handles)
handles.indx_start_frame = 1;
handles.indx_end_frame = handles.lngth;
guidata(hObject,handles);
set(handles.Play,'Enable','on');
set(handles.Speed,'Enable','on');
set(handles.Slider,'Min',1,'Max',handles.lngth,...
    'Value',1,'SliderStep',[0.01 0.1],'Enable','on');
Video_Callback(handles.Video,[],handles);
set(handles.Slider_edit,'Enable','on','String',1);
set(handles.Mark_in,'Enable','on');
set(handles.Mark_out,'Enable','on');
set(handles.Mark_in_edit,'Enable','on','String',1);
set(handles.Mark_out_edit,'Enable','on',...
    'String',num2str(handles.lngth));
set(handles.Crop,'Enable','on');
Set_Mark_in_pointer(handles.Mark_in_pointer,1,handles);
Set_Mark_in_pointer(handles.Mark_in_edit,1,handles);
Set_Mark_out_pointer(handles.Mark_out_pointer,...
    handles.lngth,handles);
Set_Mark_out_pointer(handles.Mark_out_edit,...
    handles.lngth,handles);
Disable_Parameters_Panels(handles);
Target_Init(handles);

%% D�sactiver l'acc�s aux param�tres sans s�lection d'objet
function Disable_Parameters_Panels(handles)
set(handles.Uniform,'Enable','off');
set(handles.Triangular,'Enable','off');
set(handles.Epanechnikov,'Enable','off');
set(handles.Gaussian,'Enable','off');
set(handles.Radius_edit,'Enable','off');
set(handles.F_thresh_edit,'Enable','off');
set(handles.Max_iter_edit,'Enable','off');
set(handles.Start,'Enable','off');

%% Initialisation de la s�lection d'objet
function Target_Init(handles)
set(handles.Select_Target,'Enable','on');

axes(handles.Target)
img = imread('Iamges\objet_defaut.png');
imshow(img);


%% affichage vid�o
function Video_Callback(hObject, eventdata, handles)
handles.index = round(get(handles.Slider,'Value'));
guidata(hObject,handles);
axes(handles.Video)
I = handles.Movie(handles.index).cdata;
imshow(I);

function Slider_Callback(hObject, eventdata, handles)
index = get(hObject,'Value');
set(handles.Slider_edit,'String',num2str(round(index)));
if handles.FileName~=0
    Video_Callback(handles.Video,[],handles);
end

function Slider_edit_Callback(hObject, eventdata, handles)
index = round(str2double(get(hObject,'String')));
if index > 0 && index <= handles.lngth
    set(handles.Slider,'Value',index);
    Video_Callback(handles.Video,[],handles);
end

%% Fonction play video
function Speed_Callback(hObject, eventdata, handles)

function Play_Callback(hObject, eventdata, handles)
button_state = get(hObject,'Value');
axes(handles.Video)
if button_state == get(hObject,'Max')
    set(handles.Play,'CData',handles.icon_play_down);
    drawnow;
    for indx=handles.index:handles.lngth
        pause(1/get(handles.Speed,'Value'));
        set(handles.Slider,'Value',indx);
        Slider_Callback(handles.Slider,[],handles);
        if get(hObject,'Min') == get(hObject,'Value')
            break;
        end
    end
    set(handles.Play,'CData',handles.icon_play_up,...
        'Value',get(hObject,'Min'));
end

%% Choix du segment vid�o
function Set_Mark_in_pointer(hObject,index,handles)
position = get(hObject,'Position');
position(1) = 3+index*371/handles.lngth;
set(hObject,'Position',position);
uistack(hObject,'top');

function Set_Mark_out_pointer(hObject,index,handles)
position = get(hObject,'Position');
position(1) = 42+index*371/handles.lngth;
set(hObject,'Position',position);
uistack(hObject,'top');

function Mark_in_Callback(hObject, eventdata, handles)
index = round(get(handles.Slider,'Value'));
if index < handles.indx_end_frame
    handles.indx_start_frame = index;
    guidata(hObject,handles);
    set(handles.Mark_in_edit,'String',num2str(index));
    Set_Mark_in_pointer(handles.Mark_in_pointer,index,handles);
    Set_Mark_in_pointer(handles.Mark_in_edit,index,handles);
end 

function Mark_out_Callback(hObject, eventdata, handles)
index = round(get(handles.Slider,'Value'));
if index > handles.indx_start_frame
    handles.indx_end_frame = index;
    guidata(hObject,handles);
    set(handles.Mark_out_edit,'String',num2str(index));
    Set_Mark_out_pointer(handles.Mark_out_pointer,index,handles);
    Set_Mark_out_pointer(handles.Mark_out_edit,index,handles);
end

function Mark_in_edit_Callback(hObject, eventdata, handles)
index = round(str2double(get(hObject,'String')));
if index > 0 && index < handles.indx_end_frame
    set(handles.Slider,'Value',index);
    Slider_Callback(handles.Slider,[],handles);
    Mark_in_Callback(handles.Mark_in,[],handles);
end

function Mark_out_edit_Callback(hObject, eventdata, handles)
index = round(str2double(get(hObject,'String')));
if index <= handles.lngth && index > handles.indx_start_frame
    set(handles.Slider,'Value',index);
    Slider_Callback(handles.Slider,[],handles);
    Mark_out_Callback(handles.Mark_out,[],handles);
end

function Crop_Callback(hObject, eventdata, handles)
indx_start = handles.indx_start_frame;
indx_end = handles.indx_end_frame;
handles.Movie = handles.Movie(1,indx_start:indx_end);
handles.lngth = indx_end - indx_start + 1;
guidata(hObject,handles);
Video_Init(handles.Video,handles);

%% Activer les param�tres d'acc�s sans s�lection d'objet
function Enable_Parameters_Panels(handles)
set(handles.Uniform,'Enable','on');
set(handles.Triangular,'Enable','on');
set(handles.Epanechnikov,'Enable','on');
set(handles.Gaussian,'Enable','on');
set(handles.Radius_edit,'Enable','on');
set(handles.F_thresh_edit,'Enable','on');
set(handles.Max_iter_edit,'Enable','on');
set(handles.Start,'Enable','on');

%% Les Callbacks de la S�lection de l'objet 
function Select_Target_Callback(hObject, eventdata, handles)
handles.index = 1;
I = handles.Movie(1).cdata;
[handles.T,handles.x0,handles.y0,handles.H,handles.W] = ...
    Select_patch(I,0);
guidata(hObject,handles);
axes(handles.Target)
imshow(handles.T);
Enable_Parameters_Panels(handles);
set(handles.Kernel_Panel,'SelectionChangeFcn',...
    @Kernel_Select);
Kernel_Plot(hObject,handles);

%% Les Callbacks des fen�tres du noyeau  Parzen 
function Kernel_Select(hObject,eventdata)
handles = guidata(hObject);
handles.Kernel_type = get(eventdata.NewValue,'Tag');
guidata(hObject,handles);
Kernel_Plot(hObject,handles);

function Radius_edit_Callback(hObject, eventdata, handles)
Kernel_Plot(hObject,handles);

function Kernel_Plot(hObject,handles)
radius = str2double(get(handles.Radius_edit,'String'));
if radius > 0 && radius <= 100
    handles.radius = radius/100;
    [k,handles.gx,handles.gy] = Parzen_window...
        (handles.H,handles.W,handles.radius,...
        handles.Kernel_type,0);
    guidata(hObject,handles);
    axes(handles.Kernel_Plot)
    mesh(k);
    surf(k);
    shading interp
    axis([1 handles.W 1 handles.H 0 1])
end
set(handles.Radius_edit,'String',num2str(100*handles.radius));

%% Param�tres d'it�ration de Mean-Shift 
function F_thresh_edit_Callback(hObject, eventdata, handles)
thresh = str2double(get(hObject,'String'));
if thresh > 0.0 && thresh < 1.0
    handles.f_thresh = thresh;
    guidata(hObject,handles);
end
set(hObject,'String',num2str(handles.f_thresh));

function Max_iter_edit_Callback(hObject, eventdata, handles)
Max = str2double(get(handles.Max_iter_edit,'String'));
if Max >= 1 && Max <= 15
    handles.max_iter = round(Max);
    guidata(hObject,handles);
end
set(hObject,'String',num2str(handles.max_iter));

%% le Callback de Boutton Start
function Start_Callback(hObject, eventdata, handles)
% Initialisation
H = handles.H;
W = handles.W;
x0 = handles.x0;
y0 = handles.y0;
kernel_type = handles.Kernel_type;
Length = handles.lngth;
f_thresh = handles.f_thresh;
max_it = handles.max_iter;
% Calculation  de fen�tre du noyeau  Parzen 
[k,gx,gy] = Parzen_window(H,W,handles.radius,kernel_type,0);
% Conversion de RGB en couleurs index�es
% pour calculer les fonctions de probabilit� de couleur (PDF)
[I,map] = rgb2ind(handles.Movie(1).cdata,65536);
Lmap = length(map)+1;
T = rgb2ind(handles.T,map);
% Estimation de l'objet PDF
q = Density_estim(T,Lmap,k,H,W,0);
% Drapeau pour perte de l'objet
loss = 0;
% Evolution de la similarit� du long suivi
f = [];
% Somme des it�rations selon le suivi et l'index de f
f_indx = 1;
% Dessinez l'objet s�lectionn�e dans le premier cadre
handles.Movie(1).cdata = Draw_target(x0,y0,W,H,...
    handles.Movie(1).cdata,2);
%%%% Le TRACKING
WaitBar = waitbar(0,'Le Suivi est en cours, soyez patient ...',...
    'Name','Tracking performing...');
% Du 1er cadre au dernier
for t=1:Length-1
    % cadre suivant
    I2 = rgb2ind(handles.Movie(t+1).cdata,map);
    % Appliquer l'algorithme Mean-Shift pour d�placer (x, y)
    % � l'emplacement d'objet dans la prochaine image.
    [x,y,loss,f,f_indx] = MeanShift_Tracking(q,I2,Lmap,...
        handles.height,handles.width,f_thresh,max_it,...
        x0,y0,H,W,k,gx,gy,f,f_indx,loss);
    % V�rifiez la perte de l'objet. Si c'est vrai, mettez fin au suivi
    if loss == 1
        break;
    else
        % Dessiner l'emplacement de l'objet dans le cadre suivant
        handles.Movie(t+1).cdata = Draw_target(x,y,W,H,...
            handles.Movie(t+1).cdata,2);
        % Le cadre suivant devient le cadre actuel
        y0 = y;
        x0 = x;
        % Mise � jour de la barre d'attente
        waitbar(t/(Length-1));
    end
end
close(WaitBar);
%%%% Fin de TRACKING

guidata(hObject,handles);
axes(handles.Similarity_Plot)
cla
plot(f,'-b');
ylim([0 f_thresh+f_thresh/25])
hold on
plot(f_thresh*ones(1,Length*max_it),'--r','LineWidth',1.5);
Video_Callback(handles.Video,[], handles);

%% Fin
%%%%%%%%%%%%%%
