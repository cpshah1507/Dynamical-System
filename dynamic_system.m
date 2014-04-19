% Example 1
clear;
clc;
close all;

Init = reg([1 2]);
U = reg([-0.1 0.1]);

reach = Init;
new = Init;

N =1;
figure();

while N <= 100 && new.isRegEmpty() ~= 1
    i1 = 1;
    r1 = reshape(sort(new.region)',1,[]);
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    temp = reg(new.product(-0.95));
    temp.region = temp.sum(U);
    new = reg(temp.difference(reach));
    reach = reg(reach.union(new));
    r1 = reshape(sort(reach.region)',1,[]);
    %{
    To plot reachable states uncomment this
    i1 = 1;
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end
    %}
    N = N+1;
    
end
xlim([0 100]); 
title('Example 1');
disp 'Example 1 Result:'
disp 'Reachable Region'
reach.region
disp 'Iteration Number where stopped'
N-1

% Example 2

Init = reg([1 2]);
U = reg([-0.1 0.1]);

reach = Init;
new = Init;

N =1;
figure();

while N <= 100 && new.isRegEmpty() ~= 1
    i1 = 1;
    r1 = reshape(sort(new.region)',1,[]);
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    temp = reg(new.product(-0.96));
    temp.region = temp.sum(U);
    new = reg(temp.difference(reach));
    reach = reg(reach.union(new));
    r1 = reshape(sort(reach.region)',1,[]);
     %{
    To plot reachable states uncomment this
    i1 = 1;
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    %}
    N = N+1;
end
xlim([0 100]);
title('Example 2'); 
disp 'Example 2 Result:'
disp 'Reachable Region'
reach.region
disp 'Iteration Number where stopped'
N-1

% Example 3

Init = reg([1 2]);
U = reg([-0.2 0.2]);

reach = Init;
new = Init;

N =1;
figure();

while N <= 100 && new.isRegEmpty() ~= 1
    i1 = 1;
    r1 = reshape(sort(new.region)',1,[]);
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    temp = reg(new.product(-0.95));
    temp.region = temp.sum(U);
    new = reg(temp.difference(reach));
    reach = reg(reach.union(new));
    r1 = reshape(sort(reach.region)',1,[]);
     %{
    To plot reachable states uncomment this
    i1 = 1;
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    %}
    N = N+1;
end
xlim([0 100]);
title('Example 3'); 
disp 'Example 3 Result:'
disp 'Reachable Region'
reach.region
disp 'Iteration Number where stopped'
N-1
% Example 4


Init = reg([1.8 1.89]);
U = reg([0 0.1]);

reach = Init;
new = Init;

N =1;
figure();

while N <= 40 && new.isRegEmpty() ~= 1
    i1 = 1;
    r1 = reshape(sort(new.region)',1,[]);
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    temp = reg(new.square());
    temp = reg(temp.product(0.5));
    temp.region = temp.sum(U);
    new = reg(temp.difference(reach));
    reach = reg(reach.union(new));
    r1 = reshape(sort(reach.region)',1,[]);
     %{
    To plot reachable states uncomment this
    i1 = 1;
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    %}
    N = N+1;
end
xlim([0 40]);
title('Example 4'); 
disp 'Example 4 Result:'
disp 'Reachable Region'
reach.region
disp 'Iteration Number where stopped'
N-1

% Example 5



Init = reg([1.8 1.9]);
U = reg([0 0.1]);

reach = Init;
new = Init;

N =1;
figure();

while N <= 40 && new.isRegEmpty() ~= 1
    i1 = 1;
    r1 = reshape(sort(new.region)',1,[]);
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    temp = reg(new.square());
    temp = reg(temp.product(0.5));
    temp.region = temp.sum(U);
    new = reg(temp.difference(reach));
    reach = reg(reach.union(new));
    r1 = reshape(sort(reach.region)',1,[]);
     %{
    To plot reachable states uncomment this
    i1 = 1;
    while i1<length(r1)
        hold on;
        line([N N],[r1(i1) r1(i1+1)]);
        i1=i1+2;
    end 
    %}
    N = N+1;
end
xlim([0 40]);
ylim([0 50]);
title('Example 5'); 
disp 'Example 5 Result:'
disp 'Reachable Region'
reach.region
disp 'Iteration Number where stopped'
N-1

