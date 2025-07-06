 gamma = 1.4;                           % Specific heat ratio (air)
    CR_values = [7, 9, 11];               % Compression ratios
    
    eta = 1 - 1 ./ (CR_values.^(gamma - 1));  % Thermal efficiency formula

    % Display results
    fprintf('CR\tEfficiency (%%)\n');
    for i = 1:length(CR_values)
        fprintf('%d\t%.2f%%\n', CR_values(i), eta(i)*100);
    end

    % Plotting
    figure;
    plot(CR_values, eta*100, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('Compression Ratio (CR)');
    ylabel('Thermal Efficiency (%)');
    title('Thermal Efficiency vs Compression Ratio');
    grid on;
    xlim([min(CR_values)-1, max(CR_values)+1]);

    % Inference
    fprintf('\nInference:\n');
    fprintf('Thermal efficiency increases with increasing compression ratio,\n');
    fprintf('but the rate of increase diminishes due to the exponential dependence.\n');