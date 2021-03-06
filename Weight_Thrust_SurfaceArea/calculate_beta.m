
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bernardo Pacini & Nathan Wei                                          %%
%% MAE 332 - Aircraft Design                                             %%
%% Preliminary Design Calculations                                       %%
%% 7 March 2017  
%% Dependencies: none
%% Modified 07/02/2017 by Leif Fredericks
%% Calculate Beta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% R (miles), E (hrs), V (mph), tsfc (lbfuel/hr/lbthrust)
function beta = calculate_beta(ID, R, E, M, V, AR, e, C_D0, tsfc, LD,LDC)
% if M < 1
%     L_D = AR + 10; % M<1                                 
% else
%     L_D = 11/sqrt(M);   %M>1
% end
  
L_D = LDC ; % Cruise Lift to drag ratio       

switch ID
    
    case 'takeoff'
        beta = 0.9725; % estimate
        
    case 'climb'
        if M < 1
            beta = 1.0065 - 0.0325*M;
        else
            beta = 0.991 - 0.007*M - 0.01*M^2;
        end
        
    case 'cruise'
        % Breguet Range Equation
        % R = (V/tsfc) * (L_D) * ln(Wi/Wf) %lbfuel/h/lbt
        beta = 1/(exp(R*((tsfc/V))/(L_D)));
        
    case 'loiter'
        % LD_max = 0.5*sqrt(pi*e*AR/C_D0);
        LD_max = LD;   % max L/D
        beta = 1/(exp((E*tsfc)/LD_max));
        
    case 'land'
        beta = 0.9725; % estimate
        
end

end