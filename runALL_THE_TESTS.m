function runMATLABCI(produceJUnit, produceTAP, produceCobertura)
try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.XMLPlugin');
    import('matlab.unittest.plugins.TAPPlugin');
    import('matlab.unittest.plugins.ToFile');
    import('matlab.unittest.plugins.ToFile');
    import('matlab.unittest.plugins.CodeCoveragePlugin');
    import('matlab.unittest.plugins.codecoverage.CoberturaFormat');

    ws = getenv('WORKSPACE');
    
    mkdirIfNeeded(fullfile(ws,'release'));
    d = dir('*.prj');
    outputToolbox = fullfile('release', [d.name '.mltbx']);
    matlab.addons.toolbox.packageToolbox(d.name, outputToolbox);
    tbx = matlab.addons.toolbox.installToolbox(outputToolbox,true);
    cl =onCleanup(@() matlab.addons.toolbox.uninstallToolbox(tbx));
    
    
    suite = testsuite;

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the requested plugins
    resultsDir = fullfile(ws, 'testresults');
    if produceJUnit
        mkdirIfNeeded(resultsDir)
        resultsFile = fullfile(resultsDir, 'testResults.xml');
        runner.addPlugin(XMLPlugin.producingJUnitFormat(resultsFile));
    end
    
    if produceTAP
        mkdirIfNeeded(resultsDir)
        resultsFile = fullfile(resultsDir, 'testResults.tap');
        runner.addPlugin(TAPPlugin.producingVersion13(ToFile(resultsFile)));
    end

    if produceCobertura
        coverageFile = fullfile(resultsDir, 'cobertura.xml');
        runner.addPlugin(CodeCoveragePlugin.forFolder(fullfile(ws,'source'),...
            'Producing', CoberturaFormat(coverageFile)));
    end
    
    results = runner.run(suite) 
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
exit(nnz([results.Failed]));

function mkdirIfNeeded(dir)
if exist(dir,'dir') ~= 7
    mkdir(dir);
end
