function [switchToHuman, timeOfSwitch] = AdvisoryControl(vA, sAB)
% Make sure the vA is a vector of velocites for Car A. sAB should also be a 
% vector, but of the distances from A and B.
    decelLim = -200; % If you want to adjust to -150, then you also need to adjust the output range in the .fis file to be -150
    currentSpeed = 23.5703; % Gathered from api call in project 1. Feel free to adjust
    averageSpeed = 25.0209;

    aVelocitiesTime = (0:0.01:(length(vA)-1)*0.01)';
    for i=1:1:length(vA)-1
    
        if i ==1
        
            decelerationA = -1 *(vA(2) - vA(1))/(aVelocitiesTime(2) - aVelocitiesTime(1));
        else

            decelerationA = -1 *(vA(i) - vA(i-1))/(aVelocitiesTime(i) - aVelocitiesTime(i-1));
        end

        dis = -1*abs(sAB(i));
        fis = readfis('MaxwellBerry.fis');

        if dis < -100 
            dis = -100;
        end

        % Perform fuzzy inference
        decelerationB = -1*evalfis(fis,[dis, decelerationA, currentSpeed - averageSpeed]);

        decelVal = -0.75 * decelLim;
        
        % Step 5: Check if CAR B should switch to human control
        if decelerationB > decelVal
         
            switchToHuman = true;
            timeOfSwitch = aVelocitiesTime(i);
            disp("Switch to Human : " + switchToHuman + " | Time : " + timeOfSwitch);
            break;
        else

            if (i == length(vA)-1)
                switchToHuman = false;
                disp("Switch to Human : " + switchToHuman + " | Time : N/A");
            end
        end
    end
end
