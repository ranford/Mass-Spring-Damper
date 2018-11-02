import matlab.unittest.*;
import matlab.unittest.plugins.*;
try
   
    ws = getenv('WORKSPACE');
    
    src = fullfile(ws, 'source');
    addpath(src);

    % Create and configure the runner
    runner = TestRunner.withTextOutput('Verbosity',3);

    % Add the TAP plugin
    resultsDir = fullfile(ws, 'testresults');
    mkdir(resultsDir);
    
    resultsFile = fullfile(resultsDir, 'testResults.tap');
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(resultsFile)));
   
    mkdir('reports')
    runner.addPlugin(TestReportPlugin.producingHTML('reports'));
    
    %coverageFile = fullfile(resultsDir, 'cobertura.xml');
    
    %addCoberturaCoverageIfPossible(runner, src, coverageFile);
    
    runner.run(testsuite(pwd,'IncludeSubfolders',true));
catch e
    disp(getReport(e,'extended'));
    exit(1);
end
quit('force');
