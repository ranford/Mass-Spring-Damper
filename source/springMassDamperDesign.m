design.k = 5e6;                   % Spring Constant
design.c = 2*getMass*sqrt(design.k/getMass); % Damping Coefficient to be critically damped

function m = getMass
m = 1500; % Need to know the mass to determine critical damping
end
