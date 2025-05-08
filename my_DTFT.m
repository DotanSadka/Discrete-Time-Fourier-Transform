% create function

function [X,omega] = my_DTFT(x,n,Nw)

% checking if Nw is even or odd
% then we create a vector of samples defind by the length of Nw, the vector
% will be around 0.
% if - even do so
% else - odd do so

if mod(Nw,2) == 0
    samples = -(Nw)/2:1:(Nw)/2;
else
     samples = -(Nw-1)/2:1:(Nw-1)/2;
end


% define omega with 2 pi period (not minf to inf) and make sur it is horizontal
omega = 2*pi*samples./Nw;
if (iscolumn(omega))
    omega = omega.';
end

% now we check if the vector is vertical or horizintal
% we want n to be a vertical vector, 
% so in case it is horizontal we will use the transpose function to change it. 
% we do that because we want to create a matrix.

if (isrow(n))
    n = n.';
end
if (iscolumn(x))
    x = x.';
end

% create the matrix, than e^-jwn
power1 = n*omega;
power1 = exp(-1*1i*power1);

% x*e^-jwn
X = x*power1;


end


