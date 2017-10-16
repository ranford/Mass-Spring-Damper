function addCoberturaCoverageIfPossible(runner, src, coverageFile)

if ~verLessThan('matlab','9.3')
    import('matlab.unittest.plugins.CodeCoveragePlugin');
    import('matlab.unittest.plugins.codecoverage.CoberturaFormat');
    
    runner.addPlugin(CodeCoveragePlugin.forFolder(src,...
        'Producing', CoberturaFormat(coverageFile)));
end

end