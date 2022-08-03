function  smallest_circle(A)
    %Get a matrix A where first line is x-points, second line is y-points,
    %third line is z-points. if A is size 2*n it will plot closest circle
    %if 3xN will plot closest sphere
    %for any other case function will print out the hyper-sphere equation
    %minimum matrix size in 2 rows and 3 columns in order to be able to get
    %a circle
    [m,n] = size(A);
    if m == 2
        plot(A(1,:), A(2,:), 'Om');
    elseif m == 3
        plot3(A(1,:), A(2,:), A(3,:), 'Om');            
    end
    hold on
    cvx_begin
        variables x(m) r
        minimize(r)
        subject to
            for i=1:1:n
                norm(x - A(:,i), 2) <= r
            end
    cvx_end
    t = 0:0.01:2*pi; %make vector points for plotting
    if m == 2 %if problem ix surface plot a circle
        xx = x(1) + r.*cos(t);
        yy = x(2) + r.*sin(t);
        plot(x(1),x(2),'Xr', xx, yy);
    elseif m ==3 %if problem is 3d plot a sphere
        phi = 0:0.01:2*pi;
        xx = x(1) + r.*sin(t).'.*cos(phi);  
        yy = x(2) + r.*sin(t).'.*sin(phi);
        zz = x(3) + r.*cos(phi);
        plot3(x(1),x(2),x(3), 'Xr', xx, yy, zz);
    else
        text = "(";
        for i=1:m
            text = text + "x" + i + "-" + x(i) + ")^2 + ";
            if i==m
                break
            end
            text = text + "(";
        end
        text = text + " = " + r + "^2";
        disp(text)
    end
end
