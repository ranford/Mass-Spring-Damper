function tests = designTest
tests = functiontests(localfunctions); 
end

function testSettlingTime(testCase) 
%%Test that the system settles to within 0.001 of zero under 2 seconds.

import matlab.unittest.diagnostics.FigureDiagnostic;

[position, time] = simulateSystem(springMassDamperDesign); 

f = plotResponse(time, position);
testCase.addTeardown(@close, f);

positionAfterSettling = position(time > .002);

%For this example, verify the first value after the settling time.
verifyLessThan(testCase, abs(positionAfterSettling), 2, FigureDiagnostic(f));
end

function testOvershoot(testCase)
 %Test to ensure that overshoot is less than 0.01

import matlab.unittest.diagnostics.FigureDiagnostic;

[position, time] = simulateSystem(springMassDamperDesign);
overshoot = max(position);

f = plotResponse(time, position);
testCase.addTeardown(@close, f);

verifyLessThan(testCase, overshoot, 0.01, FigureDiagnostic(f));
end

function idealTest(testCase)

setup

exercise

verify

teardown

end


function fig = plotResponse(varargin)
fig = figure('Visible','off');
fig.CreateFcn = @(o,e) set(o,'Visible','on');
ax = axes('Parent',fig);
plot(ax, varargin{:},'LineWidth',3);
title('Response')
xlabel('Time')
ylabel('Position')
end