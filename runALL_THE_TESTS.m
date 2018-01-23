try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.XMLPlugin');
    import('matlab.unittest.plugins.ToFile');

    d = dir('*.prj');
    matlab.addons.toolbox.packageToolbox(d.name);

    tbx = matlab.addons.toolbox.installToolbox(d.name,true);
    cl =onCleanup(@() matlab.addons.toolbox.installToolbox(tbx));
    
    ws = getenv('WORKSPACE');
    
    src = fullfile(ws, 'source');
    %addpath(src);

    suite = testsuite;

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the TAP plugin
    resultsDir = fullfile(ws, 'testresults');
    mkdir(resultsDir);
    
    resultsFile = fullfile(resultsDir, 'testResults.xml');
    runner.addPlugin(XMLPlugin.producingJUnitFormat(resultsFile));
   
    coverageFile = fullfile(resultsDir, 'cobertura.xml');
    
    addCoberturaCoverageIfPossible(runner, src, coverageFile);
    
    results = runner.run(suite) 
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
quit('force');

