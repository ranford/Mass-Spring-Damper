try
    import('matlab.unittest.TestRunner');
    import('matlab.unittest.plugins.TAPPlugin');
    import('matlab.unittest.plugins.XMLPlugin');
    import('matlab.unittest.plugins.TestReportPlugin');
    import('matlab.unittest.plugins.CodeCoveragePlugin');
    import('matlab.unittest.plugins.ToFile');
    import('matlab.unittest.plugins.codecoverage.CoberturaFormat');
    
    ws = getenv('WORKSPACE');
    
    src = fullfile(ws, 'source');
    addpath(src);
    
    tests = fullfile(ws, 'tests');
    suite = testsuite(tests);

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);
    artifactsFolder = fullfile(ws,'artifacts');
    mkdir(artifactsFolder);
    runner.ArtifactsRootFolder = artifactsFolder;
    


    % Add the TAP plugin
    tapFile = fullfile(ws, 'testResults.tap');
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapFile)));
   % runner.addPlugin(TAPPlugin.producingOriginalFormat(ToFile(tapFile)));
    
   runner.addPlugin(XMLPlugin.producingJUnitFormat('testResults.xml');
   
   % Add the TestReportPlugin
    % pdf
    pdfFile = fullfile(ws, 'TestReport.pdf');
    runner.addPlugin(TestReportPlugin.producingPDF(pdfFile));
    
    % html
    htmlFolder = fullfile(ws, 'testresults');
    runner.addPlugin(TestReportPlugin.producingHTML(htmlFolder,...
        'IncludingCommandWindowText', true,  'IncludingPassingDiagnostics', true));
    
    
    % Add the CodeCoveragePlugin
    srcFolder = fullfile(ws, 'source');
    coverageFile = fullfile(ws, 'coverage.xml');
    runner.addPlugin(CodeCoveragePlugin.forFolder(srcFolder,...
        'Producing', CoberturaFormat(coverageFile)));
    
    
    results = runner.run(suite)
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
exit;
