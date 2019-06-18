function plotGenerator
%{
This function exists to create consistent plots across group members. Save
your data as a .mat file (have in same directory) and call function in line 54.
The options are as follows:
1 - 2D plot of data
2 - 3D surface plot (default coloring, shading interp)
3 - 3D temp plot (2D view with third dimension as color)
4 - 4D temp plot (3D view with fourth dimension as color)
More options to come if necessary.
- option is a vector of numbers corresponding to each desired plot
- holdSet is either 'on' or 'off' depending if you want multiple plots of plots
stacked in one graph (only use if using option 1 or 2, otherwise ~)
- data variable should only include the following variables:
x,x_title,y,y_title,z,z_title,graph_title    (ensure variable names are the aforementioned names)
IMPORTANT: Option 4 requires a fourth variable named t with associated
t_title representing the color
- x and y should be cell arrays of data (each cell should be a vector of data) for
1; 
- x and y should be cell arrays of data (each cell should be a vector of data) for 2 and 3 
z should be cell arrays of matrices for 3 (should be in format z corresponding to [{x1y1 x2y1
x3y1...;x1y2 x2y2 x3y2...;...} {...}])
- x, y, and z should be cell arrays of data (each cell should be a vector of data) for 4; 
t should be cell arrays of matrices for 4 (should be in format t corresponding to (1,1,1)-->x1y1z1, (1,1,2)-->x2y1z1,
(1,2,1)-->x1y2z1, (1,2,2)-->x2y2z1, (2,1,1)-->x1y1z2, (2,1,2)-->x2y1z2, etc.)
- x_title, y_title, and z_title (and maybe t_title) should be cell arrays of strings representing the axis labels
for respective graphs (first row contains the names for the first rows of data, etc.)
i.e. [{x_title1} {x_title2} {x_title3}]
- title should be a cell array of strings representing titles of plot, if
no title, use empty string within the cell array  
i.e. [{''} {title2} {''}] if only 2nd plot has title
%}

% Your function should have the following lines at the end of the function: 
% clearvars -except x x_title y y_title z z_title graph_title option holdSet
% save data.mat
% OR
% clearvars -except x x_title y y_title z z_title t t_title graph_title option holdSet
% save data.mat

% ----------------SAMPLE----------------%
% x = [{F(1,:)'} {F(2,3:end)'} {F(3,4:end)'}];
% y = [{Isp(1,:)'} {Isp(2,3:end)'} {Isp(3,4:end)'}];
% x_title = [{'Thrust Requirement, klb_{f}'} {''} {'a'}];
% y_title = [{'Optimum Specific Impulse, sec'} {''} {'b'}];
% graph_title = [{'Test'} {''} {'c'}]
% option = [1 1 1];
% holdSet = [{'on'} {'on'} {'off'}];
% clearvars -except x x_title y y_title z z_title graph_title option holdSet
% save data.mat
% --------------------------------------%

load data.mat       % .mat file to preserve variables
numPlots = length(option);

for i=1:numPlots
    
    switch option(i)
        
        case 1
            if strcmpi(holdSet{i},'on')
                if i~=1
                    if option(i-1)~=option(i)
                        disp('You are attempting to plot two types of graphs on the same axis.')
                        break
                    end
                    if strcmpi(holdSet{i-1},'off')
                        figure
                    end
                else
                    figure
                end
                hold on
                x_data = x{i};
                y_data = y{i};
                plot(x_data,y_data,'LineWidth',2)    % can add code to change colors as they aren't standard
                if i~=1
                    if strcmpi(holdSet{i-1},'off')
                        xlabel(x_title{i},'FontSize',16);
                        ylabel(y_title{i},'FontSize',16);
                        if ~isempty(graph_title{i})
                            title(graph_title{i})
                        end
                        set(gca,'FontSize',18);
                        set(gca,'Xgrid');
                    end
                else
                    xlabel(x_title{i},'FontSize',16);
                    ylabel(y_title{i},'FontSize',16);
                    if ~isempty(graph_title{i})
                        title(graph_title{i})
                    end
                    set(gca,'FontSize',18);
                    set(gca,'Xgrid');
                end
            elseif strcmpi(holdSet{i},'off')
                figure
                x_data = x{i};
                y_data = y{i};
                plot(x_data,y_data,'LineWidth',2)
                xlabel(x_title{i},'FontSize',16);
                ylabel(y_title{i},'FontSize',16);
                if ~isempty(graph_title{i})
                    title(graph_title{i})
                end
                set(gca,'FontSize',18);
                set(gca,'Xgrid');
            else
                disp('The hold variable entered is not a valid input.')
                break
            end
            
        case 2
            if strcmpi(holdSet{i},'on')
                if i~=1
                    if option(i-1)~=option(i)
                        disp('You are attempting to plot two types of graphs on the same axis.')
                        break
                    end
                    if strcmpi(holdSet{i-1},'off')
                        figure
                    end
                else
                    figure
                end
                x_data = x{i};
                y_data = y{i};
                x_data1 = linspace(min(x_data),max(x_data));
                y_data1 = linspace(min(y_data),max(y_data));
                [xx,yy]  = meshgrid(x_data,y_data);
                [xx1,yy1] = meshgrid(x_data1,y_data1);
                zz1 = interp2(xx,yy,z{i},xx1,yy1);
                surf(xx1,yy1,zz1)
                hold on
                shading interp
                colormap(jet(100))
                if i~=1
                    if strcmpi(holdSet{i-1},'off')
                        xlabel(x_title{i},'FontSize',16);
                        ylabel(y_title{i},'FontSize',16);
                        zlabel(z_title{i},'FontSize',16);
                        if ~isempty(graph_title{i})
                            title(graph_title{i})
                        end
                        set(gca,'FontSize',18);
                        set(gca,'Xgrid');
                    end
                else
                    xlabel(x_title{i},'FontSize',16);
                    ylabel(y_title{i},'FontSize',16);
                    zlabel(z_title{i},'FontSize',16);
                    if ~isempty(graph_title{i})
                        title(graph_title{i})
                    end
                    set(gca,'FontSize',18);
                    set(gca,'Xgrid');
                end
            elseif strcmpi(holdSet{i},'off')
                figure
                x_data = x{i};
                y_data = y{i};
                x_data1 = linspace(min(x_data),max(x_data));
                y_data1 = linspace(min(y_data),max(y_data));
                [xx,yy]  = meshgrid(x_data,y_data);
                [xx1,yy1] = meshgrid(x_data1,y_data1);
                zz1 = interp2(xx,yy,z{i},xx1,yy1);
                surf(xx1,yy1,zz1)
                xlabel(x_title{i},'FontSize',16);
                ylabel(y_title{i},'FontSize',16);
                zlabel(z_title{i},'FontSize',16);
                if ~isempty(graph_title{i})
                    title(graph_title{i})
                end
                set(gca,'FontSize',18);
                set(gca,'Xgrid');
                shading interp
                colormap(jet(100));
            else
                disp('The hold variable entered is not a valid input.')
                break
            end
            
        case 3
            if strcmpi(holdSet{i},'on')
                disp('Hold on makes no sense for this plot type.')
                break
            elseif strcmpi(holdSet{i},'off')
                figure
                x_data = x{i};
                y_data = y{i};
                x_data1 = linspace(min(x_data),max(x_data));
                y_data1 = linspace(min(y_data),max(y_data));
                [xx,yy]  = meshgrid(x_data,y_data);
                [xx1,yy1] = meshgrid(x_data1,y_data1);
                zz1 = interp2(xx,yy,z{i},xx1,yy1);
                imagesc(x_data1,y_data1,zz1);
                colorbar;
                cb = colorbar;    % create and label the colorbar
                cb.Label.String = z_title{i};
                set(cb,'FontSize',18);
                set(cb,'TickLabels',num2str(get(cb,'Ticks').','%2.2f'))
                colormap(jet(500));
                view(2)
                shading interp;
                xlabel(x_title{i},'FontSize',16);
                ylabel(y_title{i},'FontSize',16);
                if ~isempty(graph_title{i})
                    title(graph_title{i})
                end
                set(gca,'FontSize',18);
                set(gca,'Xgrid');
            else
                disp('The hold variable entered is not a valid input.')
                break
            end
            
        case 4
            if strcmpi(holdSet{i},'on')
                disp('Hold on makes no sense for this plot type.')
                break
            elseif strcmpi(holdSet{i},'off')
                figure
                x_data = x{i};
                y_data = y{i};
                z_data = z{i};
                x_data1 = linspace(min(x_data),max(x_data));
                y_data1 = linspace(min(y_data),max(y_data));
                z_data1 = linspace(min(z_data),max(z_data));
                [xx,yy,zz]  = meshgrid(x_data,y_data,z_data);
                [xx1,yy1,zz1] = meshgrid(x_data1,y_data1,z_data1);
                tt1 = interp3(xx,yy,zz,t{i},xx1,yy1,zz1);
                xslice = 0.5*min(x_data)+0.5*max(x_data);
                yslice = 0.3*min(y_data)+0.7*max(y_data);
                zslice = 0.3*min(z_data)+0.7*max(z_data);
                slice(xx1,yy1,zz1,tt1,xslice,yslice,zslice);
                cb = colorbar('northoutside');    % create and label the colorbar
                cb.Label.String = t_title{i};
                set(cb,'FontSize',18);
                colormap(jet(500));
                view(-34,24)
                shading interp;
                xlabel(x_title{i},'FontSize',16);
                ylabel(y_title{i},'FontSize',16);
                zlabel(z_title{i},'FontSize',16)
                if ~isempty(graph_title{i})
                    title(graph_title{i})
                end
                set(gca,'FontSize',18);
                set(gca,'Xgrid');
            else
                disp('The hold variable entered is not a valid input.')
                break
            end
    end
end

end