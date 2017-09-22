try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.TAPPlugin');
    import('matlab.unittest.plugins.ToFile');

    
    ws = getenv('WORKSPACE');
    
    src = fullfile(ws, 'source');
    addpath(src);
    
    tests = fullfile(ws, 'tests');
    suite = testsuite(tests);

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the TAP plugin
    tapFile = fullfile(ws, 'testResults.tap');
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapFile)));
     
    results = runner.run(suite)
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
quit('force');
