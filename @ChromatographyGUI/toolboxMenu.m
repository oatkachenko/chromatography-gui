function toolboxMenu(obj, varargin)

% ---------------------------------------
% Menu
% ---------------------------------------
obj.menu.file.main    = newMenu(obj.figure, 'File');
obj.menu.edit.main    = newMenu(obj.figure, 'Edit');
obj.menu.view.main    = newMenu(obj.figure, 'View');
obj.menu.options.main = newMenu(obj.figure, 'Options');
obj.menu.help.main    = newMenu(obj.figure, 'Help');

% ---------------------------------------
% File Menu
% ---------------------------------------
obj.menu.file.load   = newMenu(obj.menu.file.main, 'Load');
obj.menu.file.save   = newMenu(obj.menu.file.main, 'Save');
obj.menu.file.saveAs = newMenu(obj.menu.file.main, 'Save As...');
obj.menu.file.exit   = newMenu(obj.menu.file.main, 'Exit');

obj.menu.file.exit.Separator = 'on';

obj.menu.file.save.Callback = {@saveCheckpoint, obj};
obj.menu.file.exit.Callback = @obj.closeRequest;

% ---------------------------------------
% File Menu --> Load
% ---------------------------------------
obj.menu.loadAgilent   = newMenu(obj.menu.file.load, 'Agilent data (*.D)');
obj.menu.loadWorkspace = newMenu(obj.menu.file.load, 'Workspace data (*.MAT)');
obj.menu.loadPeaklist  = newMenu(obj.menu.file.load, 'Peak list (*.MAT)');

obj.menu.loadAgilent.Callback   = {@loadAgilentCallback, obj};
obj.menu.loadWorkspace.Callback = {@loadMatlabCallback, obj};
obj.menu.loadPeaklist.Callback  = {@obj.toolboxPeakList, 'load_custom'};

% ---------------------------------------
% File Menu --> Save As
% ---------------------------------------
obj.menu.saveWorkspace = newMenu(obj.menu.file.saveAs, 'Workspace data (*.MAT)');
obj.menu.savePeaklist  = newMenu(obj.menu.file.saveAs, 'Peak list (*.MAT)');
obj.menu.saveImg       = newMenu(obj.menu.file.saveAs, 'Figure (*.JPG, *.PNG, *.TIFF)');
obj.menu.saveTable     = newMenu(obj.menu.file.saveAs, 'Table (*.CSV)');

obj.menu.saveWorkspace.Callback = {@saveMatlabCallback, obj};
obj.menu.savePeaklist.Callback  = {@obj.toolboxPeakList, 'save_custom'};
obj.menu.saveImg.Callback       = {@saveImageCallback, obj};
obj.menu.saveTable.Callback     = {@saveCsvCallback, obj};

if ispc
    obj.menu.saveXls = newMenu(obj.menu.file.saveAs, 'Table (*.XLSX, *.XLS)');
    obj.menu.saveXls.Callback = {@saveXlsCallback, obj};
end

% ---------------------------------------
% Edit Menu
% ---------------------------------------
obj.menu.edit.copy   = newMenu(obj.menu.edit.main, 'Copy');
obj.menu.edit.delete = newMenu(obj.menu.edit.main, 'Delete');

% ---------------------------------------
% Edit Menu --> Copy
% ---------------------------------------
obj.menu.edit.copyFigure = newMenu(obj.menu.edit.copy, 'Figure');
obj.menu.edit.copyTable  = newMenu(obj.menu.edit.copy, 'Table');

obj.menu.edit.copyFigure.Callback = @obj.copyFigure;
obj.menu.edit.copyTable.Callback  = @obj.copyTable;

% ---------------------------------------
% Edit Menu --> Delete
% ---------------------------------------
obj.menu.edit.tableDelete    = newMenu(obj.menu.edit.delete, 'Table');
obj.menu.edit.peaklistDelete = newMenu(obj.menu.edit.delete, 'Peak List');

obj.menu.edit.tableDeleteSelected = newMenu(obj.menu.edit.tableDelete, 'Selected table rows...');
obj.menu.edit.tableDeleteAll      = newMenu(obj.menu.edit.tableDelete, 'All table rows...');
obj.menu.edit.peaklistDeleteAll   = newMenu(obj.menu.edit.peaklistDelete, 'All peaks...');

obj.menu.edit.tableDeleteSelected.Callback = {@tableDeleteRowMenu, obj};
obj.menu.edit.tableDeleteAll.Callback      = {@tableDeleteRowMenu, obj};
obj.menu.edit.peaklistDeleteAll.Callback   = {@peaklistDeleteMenu, obj};

obj.menu.edit.tableDeleteSelected.Tag = 'selected';
obj.menu.edit.tableDeleteAll.Tag      = 'all';
obj.menu.edit.peaklistDeleteAll.Tag   = 'all';

% ---------------------------------------
% View Menu
% ---------------------------------------
obj.menu.view.data = newMenu(obj.menu.view.main, 'Sample');
obj.menu.view.peak = newMenu(obj.menu.view.main, 'Peak');
obj.menu.view.zoom = newMenu(obj.menu.view.main, 'Zoom');

obj.menu.view.plotLabel    = newMenu(obj.menu.view.data, 'Show Label');
obj.menu.view.peakLabel    = newMenu(obj.menu.view.peak, 'Show Label');
obj.menu.view.peakLine     = newMenu(obj.menu.view.peak, 'Show Fit');
obj.menu.view.peakArea     = newMenu(obj.menu.view.peak, 'Show Area');
obj.menu.view.peakBaseline = newMenu(obj.menu.view.peak, 'Show Baseline');

obj.menu.view.plotLabel.Tag    = 'showPlotLabel';
obj.menu.view.peakLabel.Tag    = 'showPeakLabel';
obj.menu.view.peakLine.Tag     = 'showPeakLine';
obj.menu.view.peakArea.Tag     = 'showPeakArea';
obj.menu.view.peakBaseline.Tag = 'showPeakBaseline';

obj.menu.view.plotLabel.Callback    = {@plotViewMenuCallback, obj};
obj.menu.view.peakLabel.Callback    = {@peakViewMenuCallback, obj};
obj.menu.view.peakLine.Callback     = {@peakViewMenuCallback, obj};
obj.menu.view.peakArea.Callback     = {@peakViewMenuCallback, obj};
obj.menu.view.peakBaseline.Callback = {@peakViewMenuCallback, obj};
obj.menu.view.zoom.Callback         = {@zoomMenuCallback, obj};

obj.menu.view.zoom.Separator = 'on';

% ---------------------------------------
% Options Menu
% ---------------------------------------
obj.menu.dataOptions  = newMenu(obj.menu.options.main, 'Sample');
obj.menu.peakOptions  = newMenu(obj.menu.options.main, 'Peak');
obj.menu.otherOptions = newMenu(obj.menu.options.main, 'Other');

% ---------------------------------------
% Options --> Other --> Table
% ---------------------------------------
obj.menu.tableOptions = newMenu(obj.menu.otherOptions, 'Table');
obj.menu.tableColumns = newMenu(obj.menu.tableOptions, 'Columns');

obj.menu.tableColumns.Tag = 'table';

obj.menu.tablePeakArea   = newMenu(obj.menu.tableColumns, 'Peak Area');
obj.menu.tablePeakHeight = newMenu(obj.menu.tableColumns, 'Peak Height');
obj.menu.tablePeakTime   = newMenu(obj.menu.tableColumns, 'Peak Time');
obj.menu.tablePeakWidth  = newMenu(obj.menu.tableColumns, 'Peak Width');
obj.menu.tablePeakModel  = newMenu(obj.menu.tableColumns, 'Peak Model');
obj.menu.tablePeakAll    = newMenu(obj.menu.tableColumns, 'Select All');
obj.menu.tablePeakNone   = newMenu(obj.menu.tableColumns, 'Select None');

obj.menu.tablePeakArea.Tag   = 'showPeakArea';
obj.menu.tablePeakHeight.Tag = 'showPeakHeight';
obj.menu.tablePeakTime.Tag   = 'showPeakTime';
obj.menu.tablePeakWidth.Tag  = 'showPeakWidth';
obj.menu.tablePeakModel.Tag  = 'showPeakModel';
obj.menu.tablePeakAll.Tag    = 'selectAll';
obj.menu.tablePeakNone.Tag   = 'selectNone';

obj.menu.tablePeakArea.Callback   = {@plotLabelCallback, obj};
obj.menu.tablePeakHeight.Callback = {@plotLabelCallback, obj};
obj.menu.tablePeakTime.Callback   = {@plotLabelCallback, obj};
obj.menu.tablePeakWidth.Callback  = {@plotLabelCallback, obj};
obj.menu.tablePeakModel.Callback  = {@plotLabelCallback, obj};
obj.menu.tablePeakAll.Callback    = {@plotLabelQuickSelectCallback, obj};
obj.menu.tablePeakNone.Callback   = {@plotLabelQuickSelectCallback, obj};

obj.menu.tablePeakAll.Separator = 'on';

% ---------------------------------------
% Options --> Sample
% ---------------------------------------
obj.menu.labelData = newMenu(obj.menu.dataOptions, 'Label');

obj.menu.labelData.Tag = 'data';

% ---------------------------------------
% Options --> Sample --> Label
% ---------------------------------------
obj.menu.labelRowNum     = newMenu(obj.menu.labelData, 'ID');
obj.menu.labelFilePath   = newMenu(obj.menu.labelData, 'File Path');
obj.menu.labelFileName   = newMenu(obj.menu.labelData, 'File Name');
obj.menu.labelInstrument = newMenu(obj.menu.labelData, 'Instrument');
obj.menu.labelDatetime   = newMenu(obj.menu.labelData, 'Date/Time');
obj.menu.labelMethodName = newMenu(obj.menu.labelData, 'Method Name');
obj.menu.labelSampleName = newMenu(obj.menu.labelData, 'Sample Name');
obj.menu.labelOperator   = newMenu(obj.menu.labelData, 'Operator');
obj.menu.labelSeqIndex   = newMenu(obj.menu.labelData, 'Sequence Index');
obj.menu.labelVialNum    = newMenu(obj.menu.labelData, 'Vial #');
obj.menu.labelSelectAll  = newMenu(obj.menu.labelData, 'Select All');
obj.menu.labelSelectNone = newMenu(obj.menu.labelData, 'Select None');

obj.menu.labelRowNum.Tag     = 'row_num';
obj.menu.labelFilePath.Tag   = 'file_path';
obj.menu.labelFileName.Tag   = 'file_name';
obj.menu.labelInstrument.Tag = 'instrument';
obj.menu.labelDatetime.Tag   = 'datetime';
obj.menu.labelMethodName.Tag = 'method_name';
obj.menu.labelSampleName.Tag = 'sample_name';
obj.menu.labelOperator.Tag   = 'operator';
obj.menu.labelSeqIndex.Tag   = 'seqindex';
obj.menu.labelVialNum.Tag    = 'vial';
obj.menu.labelSelectAll.Tag  = 'selectAll';
obj.menu.labelSelectNone.Tag = 'selectNone';

obj.menu.labelRowNum.Callback     = {@plotLabelCallback, obj};
obj.menu.labelFilePath.Callback   = {@plotLabelCallback, obj};
obj.menu.labelFileName.Callback   = {@plotLabelCallback, obj};
obj.menu.labelInstrument.Callback = {@plotLabelCallback, obj};
obj.menu.labelDatetime.Callback   = {@plotLabelCallback, obj};
obj.menu.labelMethodName.Callback = {@plotLabelCallback, obj};
obj.menu.labelSampleName.Callback = {@plotLabelCallback, obj};
obj.menu.labelOperator.Callback   = {@plotLabelCallback, obj};
obj.menu.labelSeqIndex.Callback   = {@plotLabelCallback, obj};
obj.menu.labelVialNum.Callback    = {@plotLabelCallback, obj};
obj.menu.labelSelectAll.Callback  = {@plotLabelQuickSelectCallback, obj};
obj.menu.labelSelectNone.Callback = {@plotLabelQuickSelectCallback, obj};

obj.menu.labelSelectAll.Separator = 'on';

% ---------------------------------------
% Options --> Peak
% ---------------------------------------
obj.menu.peakOptionsLabel      = newMenu(obj.menu.peakOptions, 'Label');
obj.menu.peakOptionsModel      = newMenu(obj.menu.peakOptions, 'Model');
obj.menu.peakOptionsArea       = newMenu(obj.menu.peakOptions, 'AreaOf');
obj.menu.peakOptionsAutoDetect = newMenu(obj.menu.peakOptions, 'Auto-Detection');
obj.menu.peakOptionsAutoStep   = newMenu(obj.menu.peakOptions, 'Auto-Step');

obj.menu.peakOptionsLabel.Tag      = 'peak';
obj.menu.peakOptionsAutoDetect.Tag = 'autoDetect';
obj.menu.peakOptionsAutoStep.Tag   = 'autoStep';

obj.menu.peakOptionsModel.Separator      = 'on';
obj.menu.peakOptionsAutoDetect.Separator = 'on';

obj.menu.peakOptionsAutoDetect.Callback = {@menuOptionCheckedCallback, obj};
obj.menu.peakOptionsAutoStep.Callback   = {@menuOptionCheckedCallback, obj};

% ---------------------------------------
% Options --> Peak --> Label
% ---------------------------------------
obj.menu.labelPeakName   = newMenu(obj.menu.peakOptionsLabel, 'Name');
obj.menu.labelPeakTime   = newMenu(obj.menu.peakOptionsLabel, 'Time');
obj.menu.labelPeakWidth  = newMenu(obj.menu.peakOptionsLabel, 'Width');
obj.menu.labelPeakHeight = newMenu(obj.menu.peakOptionsLabel, 'Height');
obj.menu.labelPeakArea   = newMenu(obj.menu.peakOptionsLabel, 'Area');
obj.menu.labelPeakAll    = newMenu(obj.menu.peakOptionsLabel, 'Select All');
obj.menu.labelPeakNone   = newMenu(obj.menu.peakOptionsLabel, 'Select None');

obj.menu.labelPeakName.Tag   = 'peakName';
obj.menu.labelPeakTime.Tag   = 'peakTime';
obj.menu.labelPeakWidth.Tag  = 'peakWidth';
obj.menu.labelPeakHeight.Tag = 'peakHeight';
obj.menu.labelPeakArea.Tag   = 'peakArea';
obj.menu.labelPeakAll.Tag    = 'selectAll';
obj.menu.labelPeakNone.Tag   = 'selectNone';

obj.menu.labelPeakName.Callback   = {@plotLabelCallback, obj};
obj.menu.labelPeakTime.Callback   = {@plotLabelCallback, obj};
obj.menu.labelPeakWidth.Callback  = {@plotLabelCallback, obj};
obj.menu.labelPeakHeight.Callback = {@plotLabelCallback, obj};
obj.menu.labelPeakArea.Callback   = {@plotLabelCallback, obj};
obj.menu.labelPeakAll.Callback    = {@plotLabelQuickSelectCallback, obj};
obj.menu.labelPeakNone.Callback   = {@plotLabelQuickSelectCallback, obj};

obj.menu.labelPeakAll.Separator = 'on';

% ---------------------------------------
% Options --> Peak --> Model
% ---------------------------------------
obj.menu.peakNN1 = newMenu(obj.menu.peakOptionsModel, 'Neural Network (NN) v1.0');
obj.menu.peakNN2 = newMenu(obj.menu.peakOptionsModel, 'Neural Network (NN) v2.0');
obj.menu.peakEGH = newMenu(obj.menu.peakOptionsModel, 'Exponential Gaussian Hybrid (EGH)');

obj.menu.peakNN1.Tag = 'nn1';
obj.menu.peakNN2.Tag = 'nn2';
obj.menu.peakEGH.Tag = 'egh';

obj.menu.peakNN1.Callback = {@peakModelMenuCallback, obj};
obj.menu.peakNN2.Callback = {@peakModelMenuCallback, obj};
obj.menu.peakEGH.Callback = {@peakModelMenuCallback, obj};

% ---------------------------------------
% Options --> Peak --> Area
% ---------------------------------------
obj.menu.peakOptionsAreaActual = newMenu(obj.menu.peakOptionsArea, 'Raw Data');
obj.menu.peakOptionsAreaFit    = newMenu(obj.menu.peakOptionsArea, 'Curve Fit');

obj.menu.peakOptionsAreaActual.Tag = 'rawdata';
obj.menu.peakOptionsAreaFit.Tag    = 'fitdata';

obj.menu.peakOptionsAreaActual.Callback = {@peakAreaMenuCallback, obj};
obj.menu.peakOptionsAreaFit.Callback    = {@peakAreaMenuCallback, obj};

% ---------------------------------------
% Options --> Other
% ---------------------------------------
obj.menu.optionsImport = newMenu(obj.menu.otherOptions, 'Import');
obj.menu.optionsAsyncLoad = newMenu(obj.menu.optionsImport, 'Asynchronous Mode');

obj.menu.optionsAsyncLoad.Tag = 'asyncMode';

obj.menu.optionsAsyncLoad.Callback = {@menuOptionCheckedCallback, obj};

% ---------------------------------------
% Help Menu
% ---------------------------------------
obj.menu.help.website = newMenu(obj.menu.help.main, 'Project Website');
%obj.menu.help.update  = newMenu(obj.menu.help.main, 'Check for updates...');

obj.menu.help.website.Callback = @obj.toolboxWebsite;
%obj.menu.help.update.Callback  = @obj.toolboxUpdate;

end

% ---------------------------------------
% Load Agilent
% ---------------------------------------
function loadAgilentCallback(~, ~, obj)

% Options
options.depth = 3;
options.verbose = 'waitbar';
options.content = 'all';

if isfield(obj.settings, 'other')
    if isfield(obj.settings.other, 'asyncMode')
        
        if obj.settings.other.asyncMode
            options.content = 'header';
        else
            options.content = 'all';
        end
        
    end
end

% Load
try
    data = importAgilent(...
        'depth', options.depth,...
        'verbose', options.verbose,...
        'content', options.content);
catch
    disp('Error importing data...');
end

if ~isempty(data) && isstruct(data)
    
    % Check data files
    data(cellfun(@isempty, {data.file_path})) = [];
    data(cellfun(@isempty, {data.file_name})) = [];
    data([data.file_size] == 0) = [];
    
    if isempty(data)
        return
    end
    
    % Check sequence index
    idx = find(cellfun(@isempty, {data.seqindex}));
    
    for i = 1:length(idx)
        data(idx(i)).seqindex = 99;
    end
    
    % Sort by file name
    if all(cellfun(@length, {data.channel}) == 1)
        
        [~, idx] = sort({data.channel});
        
        if length(idx) == length(data)
            data = data(idx);
        end
        
    end
    
    % Sort by sequence index
    [~, idx] = sort([data.seqindex], 'ascend');
    
    if length(idx) == length(data)
        data = data(idx);
    end
    
    % Sort by file path
    if length(unique({data.file_path})) > 1
        
        [~, idx] = sort({data.file_path});
        
        if length(idx) == length(data)
            data = data(idx);
        end
        
    end
    
    % Check structure fields
    if isstruct(obj.data)
        
        a = fieldnames(obj.data);
        b = fieldnames(data);
        n = length(obj.data);
        
        if any(~ismember(a,b))
            
            idx = a(~ismember(a,b));
            
            for i = 1:length(idx)
                data = setfield(data, {1}, idx{i}, []);
            end
            
        end
        
        if any(~ismember(b,a))
            
            idx = b(~ismember(b,a));
            
            for i = 1:length(idx)
                obj.data = setfield(obj.data, {1}, idx{i}, []);
            end
            
            if n == 0
                obj.data(:) = [];
            end
            
        end
        
    end
    
    % Update GUI
    for i = 1:length(data)
        obj.data = [obj.data; data(i)];
        obj.appendTableData();
    end
    
    obj.validatePeakData(length(obj.data), length(obj.peaks.name));
    obj.updateFigure();
    
end

end

% ---------------------------------------
% Load MAT
% ---------------------------------------
function loadMatlabCallback(~, ~, obj)

[data, file] = importMAT('waitbar', true);

if ~isempty(data) && isstruct(data)
    
    if isstruct(data) && length(fields(data)) == 1
        x = fields(data);
        data = data.(x{1});
    end
    
    if isstruct(data) && isfield(data, 'sample_name') && length(data) >= 1
        
        if ~isfield(data, 'time') || ~isfield(data, 'intensity')
            return
        end
        
        if ~isfield(data, 'baseline')
            data(1).baseline = [];
        end
        
        if ~isfield(data, 'peaks')
            data(1).peaks = [];
            data(1).peaks.name = obj.peaks.name;
        end
        
        obj.data = data;
        obj.peaks = obj.data(1).peaks;
        obj.validatePeakFields();
        
        if ~isempty(obj.peaks.name)
            nRow = length(obj.data);
            nCol = length(obj.peaks.name);
            obj.validatePeakData(nRow, nCol);
        end
        
        obj.checkpoint = file;
        
        obj.clearTableData();
        obj.updateTableHeader();
        obj.updateTableProperties();
        
        obj.resetTableHeader();
        obj.resetTableData();
        
        listboxRefreshCallback(obj);
        
        obj.updateFigure();
        
    end
    
end

end

% ---------------------------------------
% Save MAT
% ---------------------------------------
function saveCheckpoint(~, ~, obj)

if ~isempty(obj.data)
    obj.data(1).peaks = obj.peaks;
else
    return
end

if ~isempty(obj.checkpoint) && fileattrib(obj.checkpoint)
    file = obj.checkpoint;
else
    file = [];
end

file = exportMAT(obj.data,...
    'file',    file,...
    'varname', 'data',...
    'waitbar', true);

if ischar(file)
    obj.checkpoint = file;
end

end

% ---------------------------------------
% Save MAT
% ---------------------------------------
function saveMatlabCallback(~, ~, obj)

if ~isempty(obj.data)
    obj.data(1).peaks = obj.peaks;
else
    return
end

file = exportMAT(obj.data,...
    'varname', 'data',...
    'waitbar', true);

if ischar(file)
    obj.checkpoint = file;
end

end

% ---------------------------------------
% Save Image
% ---------------------------------------
function saveImageCallback(~, ~, obj)

if isempty(obj.data) || obj.view.index == 0
    return
end

row = obj.view.index;

filterExtensions  = '*.jpg;*.jpeg;*.png;*.tif;*.tiff';
filterDescription = 'Image file (*.jpg, *.png, *.tif)';
filterDefaultName = '';

if ~isempty(obj.data(row).datetime) && length(obj.data(row).datetime) >= 10
    filterDefaultName = [obj.data(row).datetime(1:10), ' - '];
end

if ~isempty(obj.data(row).sample_name)
    sampleName = obj.data(row).sample_name;
    sampleName = regexprep(sampleName, '[/\*:?!%^#@"<>|.]', '_');
    sampleName = deblank(strtrim(sampleName));
    filterDefaultName = [filterDefaultName, sampleName];
end

if isempty(filterDefaultName)
    filterDefaultName = [datestr(date, 'yyyymmdd'),'-chromatography-data'];
end

[fileName, filePath] = uiputfile(...
    {filterExtensions, filterDescription},...
    'Save As...',...
    filterDefaultName);

if ischar(fileName) && ischar(filePath)
    
    [~, ~, fileExtension] = fileparts(fileName);
    
    switch fileExtension
        case {'.png'}
            fileType = '-dpng';
        case {'.jpg', '.jpeg'}
            fileType = '-djpeg';
        case {'.tif', '.tiff'}
            fileType = '-dtiff';
        otherwise
            fileType = [];
    end
    
    if ~isempty(fileType)
        
        exportFigure = figure;
        exportPanel = copy(obj.panel.axes);
        
        set(exportFigure,...
            'color',    'white',...
            'units',    'pixels',...
            'position', [0, 0, 1200, 600]);
        
        set(exportPanel,....
            'parent',   exportFigure,...
            'position', [0, 0, 1, 1],....
            'bordertype', 'none',...
            'backgroundcolor', 'white');
        
        axesHandles = exportPanel.Children;
        axesTags = get(axesHandles, 'tag');
        axesPlot = strcmpi(axesTags, 'axesplot');
        
        p1 = [];
        p2 = [];
        
        if any(axesPlot)
            
            uiProperties = properties(axesHandles(axesPlot));
            
            if any(strcmp(uiProperties, 'OuterPosition'))
                p1 = get(axesHandles(axesPlot), 'position');
                p2 = get(axesHandles(axesPlot), 'outerposition');
            end
            
        else
            
            uiProperties = properties(axesHandles(axesPlot));
            
            if any(strcmp(uiProperties, 'OuterPosition'))
                p1 = get(gca, 'position');
                p2 = get(gca, 'outerposition');
            end
            
        end
        
        if isempty(p1) || isempty(p2)
            p1 = get(gca, 'position');
            p2 = p1;
        end
        
        axesPosition(1) = p1(1) - p2(1);
        axesPosition(2) = p1(2) - p2(2);
        axesPosition(3) = p1(3) - (p2(3)-1);
        axesPosition(4) = p1(4) - (p2(4)-1);
        
        for i = 1:length(axesHandles)
            if strcmpi(get(axesHandles(i), 'type'), 'axes')
                set(axesHandles(i), 'position', axesPosition);
            end
        end
        
        if ~isempty(axesHandles(axesPlot))
            
            axesPlot = axesHandles(axesPlot);
            axesChildren = axesPlot.Children;
            axesTag = get(axesChildren(isprop(axesChildren, 'tag')), 'tag');
            axesLabel = axesChildren(strcmp(axesTag, 'plotlabel'));
            
            if ~isempty(axesLabel)
                
                axesLabel = axesLabel(1);
                
                m = 0.01;
                
                a = axesLabel.Extent;
                xlimit = axesPlot.XLim;
                ylimit = axesPlot.YLim;
                
                b = axesLabel.Position(1);
                b = b - (a(1)+a(3) - (xlimit(2) - diff(xlimit)*m));
                axesLabel.Position(1) = b;
                
                b = axesLabel.Position(2);
                b = b - (a(2)+a(4) - (ylimit(2) - diff(ylimit)*m));
                axesLabel.Position(2) = b;
                
            end
            
        end
        
        msg = ['Saving image... (', fileName, ')'];
        h = waitbar(0, msg);
        
        waitbar(0.25, h, msg);
        
        currentPath = pwd;
        cd(filePath);
        
        waitbar(0.75, h, msg);
        print(exportFigure, fileName, fileType, '-r150')
        waitbar(1.0, h, msg);
        
        cd(currentPath);
        
        if ishandle(h)
            close(h);
        end
        
        if ishandle(exportFigure)
            close(exportFigure);
        end
        
    end
end

end

% ---------------------------------------
% Save Excel
% ---------------------------------------
function saveXlsCallback(~, ~, obj)

if isempty(obj.data)
    return
end

if size(obj.table.main.Data,2) ~= length(obj.table.main.ColumnName)
    obj.table.main.Data{end, length(obj.table.main.ColumnName)} = [];
end

obj.removeTableHighlightText();

try
    excelData = [obj.table.main.ColumnName'; obj.table.main.Data];
catch
    excelData = obj.table.main.Data;
end

obj.addTableHighlightText();

if isempty(excelData)
    return
end

if length(excelData(1,:)) >= 14
    for i = 1:length(excelData(:,1))
        for j = 14:length(excelData(1,:))
            if ~isempty(excelData{i,j}) && isnumeric(excelData{i,j})
                excelData{i,j} = excelData{i,j};
            end
        end
    end
end

filterExtensions  = '*.xlsx;*.xls';
filterDescription = 'Excel spreadsheet (*.xlsx, *.xls)';
filterDefaultName = [datestr(date, 'yyyymmdd'),'-chromatography-data'];

[fileName, filePath] = uiputfile(...
    {filterExtensions, filterDescription},...
    'Save As...',...
    filterDefaultName);

if ischar(fileName) && ischar(filePath)
    currentPath = pwd;
    cd(filePath);
    xlswrite(fileName, excelData)
    cd(currentPath);
end

end

% ---------------------------------------
% Save CSV
% ---------------------------------------
function saveCsvCallback(~, ~, obj)

if isempty(obj.data) || isempty(obj.table.main.Data)
    return
end

% Get table data
obj.removeTableHighlightText();

tableHeader = obj.table.main.ColumnName;
tableData   = obj.table.main.Data;
tableFormat = obj.table.main.ColumnFormat;

obj.addTableHighlightText();

% Check table data
if length(tableData(1,:)) ~= length(tableHeader)
    tableData{end, length(tableHeader)} = ' ';
end

if length(tableFormat) ~= length(tableHeader)
    obj.updateTableProperties();
end

% Waitbar
h = waitbar(0, 'Saving CSV file...');
    
% File options
defaultName = [datestr(date, 'yyyymmdd'),'-chromatography-data'];

[fileName, filePath] = uiputfile(...
    {'*.csv', 'CSV file (*.csv)'},...
    'Save As...',...
    defaultName);

% Format table as CSV
if ischar(fileName) && ischar(filePath)

    % Set path
    currentPath = pwd;
    cd(filePath);

    [m,n] = size(tableData);

    for i = 1:m
        
        if ishandle(h)
            waitbar(i/(m+1), h);
        end
            
        for j = 1:n
            
            if j <= length(tableFormat)
                x = tableFormat{j};
            else
                x = 'char';
            end
            
            if isempty(tableData{i,j})
                tableData{i,j} = ' ';
                
            elseif strcmpi(x, 'numeric')
                tableData{i,j} = num2str(tableData{i,j});
                
            elseif strcmpi(x, 'char')
                tableData{i,j} = regexprep(tableData{i,j}, '([,]|\t)', ' ');
                tableData{i,j} = deblank(strtrim(tableData{i,j}));
            end
            
        end
        
    end
    
    if ishandle(h)
        waitbar(0.99, h);
    end
        
    % Write CSV file
    f = fopen(fileName, 'w');
    fmt = [repmat('%s,', 1, n-1), '%s' '\n'];
    
    fprintf(f, fmt, tableHeader{:});
    
    for i = 1:m
        fprintf(f, fmt, tableData{i,:});
    end
    
    fclose(f);
    
    % Reset path
    cd(currentPath);
    
end

if ishandle(h)
    close(h);
end

end

% ---------------------------------------
% Refresh Listbox
% ---------------------------------------
function listboxRefreshCallback(obj, varargin)

x = obj.controls.peakList.Value;

if isempty(x) || x == 0 || x > length(obj.peaks.name)
    obj.controls.peakList.Value = 1;
end

obj.controls.peakList.String = obj.peaks.name;

end

% ---------------------------------------
% Delete Table Row
% ---------------------------------------
function tableDeleteRowMenu(src, ~, obj)

if isempty(obj.data) || isempty(obj.table.main.Data)% || isempty(obj.table.selection)
    return
else
    row = '';
end

previousSelection = obj.table.selection;

switch src.Tag
    
    case 'all'
        obj.table.selection = (1:size(obj.table.main.Data,1))';
        
    case 'selected'
        
        if isempty(obj.table.selection)
            return
        else
            obj.table.selection = unique(obj.table.selection(:,1));
        end
        
end

nRows = length(obj.table.selection(:,1));

for i = 1:nRows
    
    n = obj.table.selection(i,1);
    
    if i == 1
        row = num2str(n);
        
    elseif i > 1
        
        if n - obj.table.selection(i-1,1) == 1
            
            if ~strcmpi(row(end), ':')
                
                if i == nRows
                    row = [row, ':', num2str(n)];
                else
                    if obj.table.selection(i+1,1) - n ~= 1
                        row = [row, ':', num2str(n)];
                    elseif obj.table.selection(i+1,1) - n == 1
                        row = [row, ':'];
                    end
                end
                
            elseif strcmpi(row(end), ':')
                
                if i == nRows
                    row = [row, num2str(n)];
                elseif obj.table.selection(i+1,1) - n ~= 1
                    row = [row, num2str(n)];
                end
            end
            
        elseif n - obj.table.selection(i-1,1) ~= 1
            row = [row, ', ', num2str(n)];
        end
    end
end

if isempty(row)
    message = 'Delete selected samples?';
else
    message = ['Delete selected samples (', row, ')?'];
end

msg = questdlg(...
    message,...
    'Delete',...
    'Yes', 'No', 'Yes');

switch msg
    
    case 'Yes'
        obj.tableDeleteRow();
        
    case 'No'
        obj.table.selection = previousSelection;
        return
        
    otherwise
        return
        
end

end

% ---------------------------------------
% Delete Peak List
% ---------------------------------------
function peaklistDeleteMenu(~, ~, obj)

if isempty(obj.peaks.name)
    return
end

msg = questdlg('Delete entire peak list?', 'Delete', 'Yes', 'No', 'Yes');

switch msg
    
    case 'Yes'
        
        n = length(obj.peaks.name);

        for i = n:-1:1
            obj.tableDeletePeakColumn(i)
        end

    case 'No'
        return
        
    otherwise
        return
        
end

end

% ---------------------------------------
% Enable/Disable Zoom
% ---------------------------------------
function zoomMenuCallback(src, evt, obj)

if strcmpi(evt.EventName, 'Action')
    
    switch src.Checked
        
        case 'on'
            src.Checked = 'off';
            obj.userZoom(0);
            
        case 'off'
            src.Checked = 'on';
            obj.userZoom(1);
            obj.userPeak(0);
            
    end
    
    obj.settings.showZoom = src.Checked;
    
end

end

% ---------------------------------------
% Enable/Disable Menu Option
% ---------------------------------------
function menuOptionCheckedCallback(src, evt, obj)

if strcmpi(evt.EventName, 'Action')
    
    switch src.Checked
        
        case 'on'
            src.Checked = 'off';
            src.UserData = 0;
            
        case 'off'
            src.Checked = 'on';
            src.UserData = 1;
            
    end
    
    switch src.Tag
       
        case 'asyncMode'
            obj.settings.other.asyncMode = src.UserData;
            
        case 'autoDetect'
            obj.settings.peakAutoDetect = src.UserData;
            obj.peakAutoDetectionCallback();
            
        case 'autoStep'
            obj.settings.peakAutoStep = src.UserData;
            
    end
    
end

end

% ---------------------------------------
% Enable/Disable Peak Labels, Lines
% ---------------------------------------
function peakViewMenuCallback(src, evt, obj)

if strcmpi(evt.EventName, 'Action')
    
    switch src.Checked
        
        case 'on'
            src.Checked = 'off';
            
        case 'off'
            src.Checked = 'on';
            
    end
    
    switch src.Tag
        
        case 'showPeakLabel'
            
            if strcmpi(src.Checked, 'on')
                obj.settings.showPeakLabel = 1;
                obj.plotPeakLabels();
            else
                obj.settings.showPeakLabel = 0;
                obj.clearLabel('peakLabel');
            end
            
        case 'showPeakLine'
            
            if strcmpi(src.Checked, 'on')
                obj.settings.showPeakLine = 1;
                obj.updatePeakLine();
            else
                obj.settings.showPeakLine = 0;
                obj.clearLine('peakLine');
            end
            
        case 'showPeakArea'
            
            if strcmpi(src.Checked, 'on')
                obj.settings.showPeakArea = 1;
                obj.updatePeakArea();
            else
                obj.settings.showPeakArea = 0;
                obj.clearLine('peakArea');
            end
            
        case 'showPeakBaseline'
            
            if strcmpi(src.Checked, 'on')
                obj.settings.showPeakBaseline = 1;
                obj.updatePeakBaseline();
            else
                obj.settings.showPeakBaseline = 0;
                obj.clearLine('peakBaseline');
            end
            
    end
    
end

end

% ---------------------------------------
% Enable/Disable Data Labels
% ---------------------------------------
function plotViewMenuCallback(src, evt, obj)

if strcmpi(evt.EventName, 'Action')
    
    switch src.Checked
        
        case 'on'
            src.Checked = 'off';
            
        case 'off'
            src.Checked = 'on';
            
    end
    
    switch src.Tag
        
        case 'showPlotLabel'
            
            if strcmpi(src.Checked, 'on')
                obj.settings.showPlotLabel = 1;
                obj.updatePlotLabel();
            else
                obj.settings.showPlotLabel = 0;
                obj.clearAxesChildren('plotlabel');
            end
            
    end
    
end

end

% ---------------------------------------
% Select Fields for Plot Label
% ---------------------------------------
function plotLabelCallback(src, ~, obj)

switch src.Checked
    
    case 'off'
        src.Checked = 'on';
        
    otherwise
        src.Checked = 'off';
        
end

switch src.Parent.Tag
    
    case {'data', 'peak'}
        updatePlotLabel(src, obj);
        
    case {'table'}
        updateTableColumns(src, obj)
        
end

end

% ---------------------------------------
% Select All / None Menu
% ---------------------------------------
function plotLabelQuickSelectCallback(src, ~, obj)

switch src.Tag
    
    case 'selectAll'
        src.Checked = 'on';
        
    case 'selectNone'
        src.Checked = 'off';
        
    otherwise
        src.Checked = 'off';
        
end

for i = 1:length(src.Parent.Children)
    
    if ~any(strcmpi(src.Parent.Children(i).Tag, {'selectAll', 'selectNone'}))
        src.Parent.Children(i).Checked = src.Checked;
    end
    
end

switch src.Parent.Tag
    
    case {'data', 'peak'}
        updatePlotLabel(src, obj);
        
    case {'table'}
        updateTableColumns(src, obj)
        
end

src.Checked = 'off';

end

% ---------------------------------------
% Set Plot Labels
% ---------------------------------------
function updatePlotLabel(src, obj)

plotLabel = {};

for i = 1:length(src.Parent.Children)
    
    if strcmpi(src.Parent.Children(i).Checked, 'on')
        
        switch src.Parent.Children(i).Tag
            
            case 'row_num'
                plotLabel{1} = src.Parent.Children(i).Tag;
            case 'file_path'
                plotLabel{2} = src.Parent.Children(i).Tag;
            case 'file_name'
                plotLabel{3} = src.Parent.Children(i).Tag;
            case 'instrument'
                plotLabel{4} = src.Parent.Children(i).Tag;
            case 'datetime'
                plotLabel{5} = src.Parent.Children(i).Tag;
            case 'method_name'
                plotLabel{6} = src.Parent.Children(i).Tag;
            case 'sample_name'
                plotLabel{7} = src.Parent.Children(i).Tag;
            case 'operator'
                plotLabel{8} = src.Parent.Children(i).Tag;
            case 'seqindex'
                plotLabel{9} = src.Parent.Children(i).Tag;
            case 'vial'
                plotLabel{10} = src.Parent.Children(i).Tag;
                
            case 'peakName'
                plotLabel{1} = src.Parent.Children(i).Tag;
            case 'peakTime'
                plotLabel{2} = src.Parent.Children(i).Tag;
            case 'peakWidth'
                plotLabel{3} = src.Parent.Children(i).Tag;
            case 'peakHeight'
                plotLabel{4} = src.Parent.Children(i).Tag;
            case 'peakArea'
                plotLabel{5} = src.Parent.Children(i).Tag;
                
        end
        
    end
    
end

plotLabel(cellfun(@isempty, plotLabel)) = [];

switch src.Parent.Tag
    
    case 'data'
        
        obj.settings.labels.data = plotLabel;
        
        if obj.settings.showPlotLabel
            obj.updatePlotLabel();
        end
        
    case 'peak'
        
        obj.settings.labels.peak = plotLabel;
        
        if obj.settings.showPeakLabel
            obj.plotPeakLabels();
        end
        
end

end

% ---------------------------------------
% Set Table Columns
% ---------------------------------------
function updateTableColumns(src, obj)

for i = 1:length(src.Parent.Children)
    
    if strcmpi(src.Parent.Children(i).Checked, 'on')
        
        switch src.Parent.Children(i).Tag
            case 'showPeakArea'
                obj.settings.table.showArea = 1;
            case 'showPeakHeight'
                obj.settings.table.showHeight = 1;
            case 'showPeakTime'
                obj.settings.table.showTime = 1;
            case 'showPeakWidth'
                obj.settings.table.showWidth = 1;
            case 'showPeakModel'
                obj.settings.table.showModel = 1;
        end
        
    else
        
        switch src.Parent.Children(i).Tag
            case 'showPeakArea'
                obj.settings.table.showArea = 0;
            case 'showPeakHeight'
                obj.settings.table.showHeight = 0;
            case 'showPeakTime'
                obj.settings.table.showTime = 0;
            case 'showPeakWidth'
                obj.settings.table.showWidth = 0;
            case 'showPeakModel'
                obj.settings.table.showModel = 0;
        end
        
    end
    
end

obj.updateTableHeader();
obj.updateTableProperties();
obj.updateTablePeakData();

end

% ---------------------------------------
% Set Peak Model/Area
% ---------------------------------------
function peakModelMenuCallback(src, ~, obj)

for i = 1:length(src.Parent.Children)
    src.Parent.Children(i).Checked = 'off';
end

src.Checked = 'on';

obj.settings.peakModel = src.Tag;

end

% ---------------------------------------
% Set Peak Area Target
% ---------------------------------------
function peakAreaMenuCallback(src, ~, obj)

for i = 1:length(src.Parent.Children)
    src.Parent.Children(i).Checked = 'off';
end

src.Checked = 'on';

obj.settings.peakArea = src.Tag;

end

% ---------------------------------------
% Menu
% ---------------------------------------
function menu = newMenu(parent, label)

menu = uimenu('parent', parent, 'label', label);

end