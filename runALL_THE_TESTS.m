import matlab.unittest.TestRunner;
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.TestReportPlugin;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.ToFile;
import matlab.unittest.plugins.codecoverage.CoberturaFormat


try
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
    
    % Add the TestReportPlugin
    % pdf
    pdfFile = fullfile(ws, 'TestReport.pdf');
    runner.addPlugin(TestReportPlugin.producingPDF(pdfFile));
    
    % html
    htmlFolder = fullfile(ws, 'testresults');
    runner.addPlugin(TestReportPlugin.producingHTML(htmlFolder,'IncludingCommandWindowText', true));
    
    
    % Add the CodeCoveragePlugin
    srcFolder = fullfile(ws, 'source');
    coverageFile = fullfile(ws, 'coverage.xml')
    runner.addPlugin(CodeCoveragePlugin.forFolder(srcFolder,'Producing', CoberturaFormat(coverageFile)));
    
    
    results = runner.run(suite)
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
exit;
