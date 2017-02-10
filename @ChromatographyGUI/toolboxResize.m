function toolboxResize(obj, varargin)

% ---------------------------------------
% Positions
% ---------------------------------------
margin = 0.01;

tablePos(1) = 0.20 + margin;
tablePos(2) = 0.75 + margin;
tablePos(3) = 1.00 - tablePos(1) - margin;
tablePos(4) = 1.00 - tablePos(2) - margin;

plotPos(1) = tablePos(1);
plotPos(2) = margin;
plotPos(3) = tablePos(3);
plotPos(4) = 1.00 - tablePos(4) - margin * 3;

ctrlPos(1) = margin;
ctrlPos(2) = plotPos(2);
ctrlPos(3) = 1.00 - plotPos(3) - margin * 3;
ctrlPos(4) = plotPos(4);

selectPos(1) = ctrlPos(1);
selectPos(2) = tablePos(2);
selectPos(3) = ctrlPos(3);
selectPos(4) = tablePos(4);

xLimPos(1) = margin * 4;
xLimPos(2) = 0.70 + margin;
xLimPos(3) = 1.00 - margin * 8;
xLimPos(4) = 1.00 + margin * 2 - tablePos(2);

yLimPos(1) = xLimPos(1);
yLimPos(2) = xLimPos(2) - xLimPos(4) - margin * 2;
yLimPos(3) = xLimPos(3);
yLimPos(4) = xLimPos(4);

% ---------------------------------------
% Resize Callbacks
% ---------------------------------------
set(obj.panel.table,   'resizefcn', @(src, evt) resizeTablePanel(obj,  src, evt, tablePos));
set(obj.panel.axes,    'resizefcn', @(src, evt) resizeAxesPanel(obj,   src, evt, plotPos));
set(obj.panel.control, 'resizefcn', @(src, evt) resizeCtrlPanel(obj,   src, evt, ctrlPos));
set(obj.panel.select,  'resizefcn', @(src, evt) resizeSelectPanel(obj, src, evt, selectPos));
set(obj.panel.xlim,    'resizefcn', @(src, evt) resizeXlimPanel(obj,   src, evt, xLimPos));
set(obj.panel.ylim,    'resizefcn', @(src, evt) resizeYlimPanel(obj,   src, evt, yLimPos));

end

% ---------------------------------------
% Table Panel
% ---------------------------------------
function resizeTablePanel(obj, ~, ~, pos)

set(obj.panel.table, 'position', pos);

uiProperties = properties(obj.panel.table);

if any(strcmp(uiProperties, 'InnerPosition'))
    
    set(obj.table.main,  'units', 'pixels');
    set(obj.panel.table, 'units', 'pixels');
    
    x1 = get(obj.panel.table, 'innerposition');
    x2 = get(obj.panel.table, 'position');
    
    x(1) = x1(1) - x2(1);
    x(2) = x1(2) - x2(2);
    x(3) = x1(3);
    x(4) = x1(4);
    
    set(obj.table.main,  'position', x);
    set(obj.table.main,  'units', 'normalized');
    set(obj.panel.table, 'units', 'normalized');
    
end

end

% ---------------------------------------
% Axes Panel
% ---------------------------------------
function resizeAxesPanel(obj, ~, ~, pos)

set(obj.panel.axes, 'position', pos);

uiProperties = properties(obj.axes.main);

if any(strcmp(uiProperties, 'OuterPosition'))
    
    x1 = get(obj.axes.main, 'position');
    x2 = get(obj.axes.main, 'outerposition');
    
    x(1) = x1(1) - x2(1);
    x(2) = x1(2) - x2(2);
    x(3) = x1(3) - (x2(3)-1);
    x(4) = x1(4) - (x2(4)-1);
    
    set(obj.axes.main, 'position', x);
    set(obj.axes.secondary, 'position', x);
    
end

end

% ---------------------------------------
% Control Panel
% ---------------------------------------
function resizeCtrlPanel(obj, ~, ~, pos)

set(obj.panel.control, 'position', pos);

end

% ---------------------------------------
% Selection Panel
% ---------------------------------------
function resizeSelectPanel(obj, ~, ~, pos)

set(obj.panel.select, 'position', pos);

uiProperties = properties(obj.controls.editID);

if any(strcmp(uiProperties, 'OuterPosition'))
    
    x1 = get(obj.controls.selectID, 'extent');
    x2 = get(obj.controls.editID, 'outerposition');
    
    x(1) = 0.25 - (x1(3) / 2);
    x(3) = x1(3);
    x(4) = x1(4);
    x(2) = (x2(2) + (x2(4) / 2)) - (x1(4) / 2);
    
    set(obj.controls.selectID, 'position', x);
    
    x1 = get(obj.controls.selectName, 'extent');
    x2 = get(obj.controls.editName, 'outerposition');
    
    x(1) = 0.25 - (x1(3) / 2);
    x(3) = x1(3);
    x(4) = x1(4);
    x(2) = (x2(2) + (x2(4) / 2)) - (x1(4) / 2);
    
    set(obj.controls.selectName, 'position', x);
    
end

end

% ---------------------------------------
% X-Limit Panel
% ---------------------------------------
function resizeXlimPanel(obj, ~, ~, pos)

set(obj.panel.xlim, 'position', pos);

uiProperties = properties(obj.controls.xMin);

if any(strcmp(uiProperties, 'OuterPosition'))
    
    x1 = get(obj.controls.xMin, 'outerposition');
    x2 = get(obj.controls.xSeparator, 'extent');
    
    x(3) = x2(3);
    x(4) = x2(4);
    x(1) = 0.5 - (x2(3) / 2);
    x(2) = (x1(2) + (x1(4) / 2)) - (x2(4) / 2);
    
    set(obj.controls.xSeparator, 'position', x);
    
end

end

% ---------------------------------------
% Y-Limit Panel
% ---------------------------------------
function resizeYlimPanel(obj, ~, ~, pos)

set(obj.panel.ylim, 'position', pos);

uiProperties = properties(obj.controls.yMin);

if any(strcmp(uiProperties, 'OuterPosition'))
    
    x1 = get(obj.controls.yMin, 'outerposition');
    x2 = get(obj.controls.ySeparator, 'extent');
    
    x(3) = x2(3);
    x(4) = x2(4);
    x(1) = 0.5 - (x2(3) / 2);
    x(2) = (x1(2) + (x1(4) / 2)) - (x2(4) / 2);
    
    set(obj.controls.ySeparator, 'position', x);
    
end

end
