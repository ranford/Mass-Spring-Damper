function tests = designTest
tests = functiontests(localfunctions); 
end

function setupOnce(testCase)
testCase.applyFixture(matlab.unittest.fixtures.PathFixture(fullfile('..','source')));

function testSettlingTime(testCase) 
%%Test that the system settles to within 0.001 of zero under 2 seconds.

[position, time] = simulateSystem(springMassDamperDesign); 

positionAfterSettling = position(time > .002);

%For this example, verify the first value after the settling time.
verifyLessThan(testCase, abs(positionAfterSettling), 2);
end

function testOvershoot(testCase)
 %Test to ensure that overshoot is less than 0.01

[position, ~] = simulateSystem(springMassDamperDesign);
overshoot = max(position);

verifyLessThan(testCase, overshoot, 0.01);
end

function testInvalidInput(testCase)
% Test to ensure we fail gracefully with bogus input

testCase.verifyError(@() simulateSystem('bunk'), ...
   'simulateSystem:InvalidDesign:ShouldBeStruct');
end

function testFailure(testCase)
testCase.verifyEqual(5,6);
end
