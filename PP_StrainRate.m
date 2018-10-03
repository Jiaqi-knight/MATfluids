%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                             POST-PROCESSING                             %
%                               STRAIN RATE                               %
%                                                                         %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% Giuseppe Di Labbio                                                      %
% Department of Mechanical, Industrial & Aerospace Engineering            %
% Concordia University Montr�al, Canada                                   %
%                                                                         %
% Last Update: October 3rd, 2018 by Giuseppe Di Labbio                    %
%                                                                         %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% SYNTAX                                                                  %
%                                                                         %
% SR = PP_StrainRate(VGT);                                                %
%                                                                         %
% DESCRIPTION                                                             %
%                                                                         %
% This function computes the strain rate tensor (or spin tensor) of a     %
% velocity field given its velocity gradient tensor. The function detects %
% if the calculation is two or three dimensional.                         %
%                                                                         %
% References:                                                             %
% N/A                                                                     %
%                                                                         %
% ----------------------------------------------------------------------- %
% Variables:                                                              %
% ----------------------------------------------------------------------- %
% 'SR'         - STRUCT                                                   %
%              - Strain rate tensor containing the four components 'xx',  %
%                'xy', 'yx' and 'yy' in 2D or the nine components 'xx',   %
%                'xy', 'xz', 'yx', 'yy', 'yz', 'zx', 'zy' and 'zz' in 3D. %
% ----------------------------------------------------------------------- %
% 'VGT'        - STRUCT                                                   %
%              - Velocity gradient tensor containing the four components  %
%                'UX', 'UY', 'VX' and 'VY' in 2D or the nine components   %
%                'UX', 'UY', 'UZ', 'VX', 'VY', 'VZ', 'WX', 'WY' and 'WZ'  %
%                in 3D.                                                   %
% ----------------------------------------------------------------------- %
%                                                                         %
% EXAMPLE                                                                 %
%                                                                         %
% Calculate the strain rate tensor of a time-dependent double gyre on the %
% domain (x,y) = [0,2]x[0,1] with a constant grid spacing of 0.01 over    %
% the time interval [0,20] with time-step size 0.1. Use A = 0.1, epsilon  %
% = 0.25, and omega = 2*pi/10.                                            %
%                                                                         %
% >> x = linspace(0, 2, 201).';                                           %
% >> y = linspace(0, 1, 101).';                                           %
% >> t = linspace(0, 20, 21).';                                           %
% >> A = 0.1;                                                             %
% >> epsn = 0.25;                                                         %
% >> omga = 2*pi/10;                                                      %
% >> [VEC, VGT] = GEN_DoubleGyre(x, y, t, A, epsn, omga);                 %
% >> SR = cell(length(t),1);                                              %
% >> for k = 1:length(t)                                                  %
% SR{k} = PP_StrainRate(VGT{k});                                          %
% end                                                                     %
% >> for k = 1:length(t)                                                  %
% contourf(VEC{k}.X, VEC{k}.Y, SR{k},yx, 'EdgeColor', 'None');            %
% colormap jet;                                                           %
% hold on;                                                                %
% quiver(VEC{k}.X(1:4:end,1:4:end), VEC{k}.Y(1:4:end,1:4:end), ...        %
%        VEC{k}.U(1:4:end,1:4:end), VEC{k}.V(1:4:end,1:4:end), 'k');      %
% hold off;                                                               %
% pause(0.25);                                                            %
% end                                                                     %
% >> clear k;                                                             %
%                                                                         %
% DEPENDENCIES                                                            %
%                                                                         %
% Requires:                                                               %
% N/A                                                                     %
%                                                                         %
% Called in:                                                              %
% N/A                                                                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PP_StrainRate
function [SR] = PP_StrainRate(VGT)

if length(fieldnames(VGT)) == 4
    
    SR = struct('xx', 0, 'xy', 0, 'yx', 0, 'yy', 0);

    SR.xx = VGT.UX;
    SR.xy = 0.5*(VGT.UY + VGT.VX);
    SR.yx = SR.xy;
    SR.yy = VGT.VY;
    
elseif length(fieldnames(VGT)) == 9
    
    SR = struct('xx', 0, 'xy', 0, 'xz', 0, 'yx', 0, 'yy', 0, 'yz', 0, ...
                'zx', 0, 'zy', 0, 'zz', 0);

    SR.xx = VGT.UX;
    SR.xy = 0.5*(VGT.UY + VGT.VX);
    SR.xz = 0.5*(VGT.UZ + VGT.WX);
    SR.yx = SR.xy;
    SR.yy = VGT.VY;
    SR.yz = 0.5*(VGT.VZ + VGT.WY);
    SR.zx = SR.xz;
    SR.zy = SR.yz;
    SR.zz = VGT.WZ;
    
end

%% %%%%%%%%%%%%%%%%%%%%%%%%% SUPPRESS MESSAGES %%%%%%%%%%%%%%%%%%%%%%%%% %%

%#ok<*N/A>
% Line(s) N/A
% Message(s)
% * N/A
% Reason(s)
% * N/A

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOTES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%                                                                         %
% Line(s) N/A                                                             %
% * N/A.                                                                  %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%