function four_up_plot(t, y, t_mask, tc)
figure
subplot(2, 2, 1)
hold on
for i=1:27
    plot(t-tc, y(:, i), 'r-')
end
hold off
title('Vertical Position of the Drifters')
xlabel('Elapsed Time (s)')
ylabel('Vertical Grid Point')
set(gca, 'Ydir', 'reverse')
subplot(2, 2, 2)
hold on
for i=1:27
    plot(t-tc, y(:, 27+i), 'b-')
end
hold off
title('Along Strait Position of the Drifters')
xlabel('Elapsed Time (s)')
ylabel('NW Grid Point')
subplot(2, 2, 3)
hold on
for i=1:27
    plot(t-tc, y(:, 2*27+i), 'g-')
end
hold off
title('Across-Strait Position of the Drifters')
xlabel('Elapsed Time (s)')
ylabel('NE Grid Point')

subplot(2, 2, 4)
ex = 15;
i1 = floor(min(min(y(:, 2*27+1:3*27)))) - ex;
i2 = ceil(max(max(y(:, 2*27+1:3*27)))) + ex;
j1 = floor(min(min(y(:, 27+1:2*27)))) - ex;
j2 = ceil(max(max(y(:, 27+1:2*27)))) + ex;
hold on
for i=i1:i2
    for j=j1:j2
        if t_mask(i, j, 1) == 0
            plot(i, j, 'sk', 'MarkerFaceColor', 'k', 'Markersize', 10)
        end
    end
end
%contourf(t_mask(i1:i2, j1:j2, 1)')
colormap winter
for i=1:27
    scatter(y(:, 2*27+i), y(:, 27+i), 4, y(:, i))
end
plot(y(1, 2*27+5), y(1, 27+5), 'kx')
xlim([i1-1 i2+1])
ylim([j1-1 j2+1])
colorbar
hold off