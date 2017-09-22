function tests = designTest
tests = functiontests(localfunctions); 
end

function testSettlingTime(testCase) 
%%Test that the system settles to within 0.001 of zero under 2 seconds.

[position, time] = simulateSystem; 

positionAfterSettling = position(time > .002);

%For this example, verify the first value after the settling time.
verifyLessThan(testCase, abs(positionAfterSettling), 2);
end

function testOvershoot(testCase)
 %Test to ensure that overshoot is less than 0.01

[position, time] = simulateSystem;
overshoot = max(position);

verifyLessThan(testCase, overshoot, 0.01);
end
