classdef designTest < matlab.unittest.TestCase

    properties(TestParameter)
        mass = struct('LightTruck', 1500, 'HeavyDuty', 2500);
    end

    methods(Test)
        function testSettlingTime(testCase, mass) 
            %%Test that the system settles to within 0.001 of zero under 2 seconds.

            [position, time] = simulateSystem(springMassDamperDesign(mass)); 
            positionAfterSettling = position(time > .002);

            %For this example, verify the first value after the settling time.
            verifyLessThan(testCase, abs(positionAfterSettling), 2);
        end

        function testOvershoot(testCase, mass)
             %Test to ensure that overshoot is less than 0.01

            [position, ~] = simulateSystem(springMassDamperDesign(mass));
            overshoot = max(position);

            verifyLessThan(testCase, overshoot, 0.01);
        end

        function testInvalidInput(testCase)
            % Test to ensure we fail gracefully with bogus input

            testCase.verifyError(@() simulateSystem('bunk'), ...
               'simulateSystem:InvalidDesign:ShouldBeStruct');
        end
        
        function testNewFeature(testCase)
            testCase.verifyEqual(1, 2);
        end
    end
    
end
