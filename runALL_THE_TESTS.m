try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.XMLPlugin');
    import('matlab.unittest.plugins.ToFile');

    
    ws = getenv('WORKSPACE');
    
    src = fullfile(ws, 'source');
    addpath(src);
    
    tests = fullfile(ws, 'tests');
    suite = testsuite(tests);

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the TAP plugin
    resultsDir = fullfile(ws, 'testresults');
    mkdir(resultsDir);
    resultsFile = fullfile(resultsDir, 'testResults.xml');
    runner.addPlugin(XMLPlugin.producingJUnitFormat(resultsFile)));
     
    results = runner.run(suite)
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
quit('force');
