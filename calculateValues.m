function [laneValue] = calculateValues(pAkt,numberOfLanes,t)
% CACLCULATEVALUE
% Function generates a binary map, separates lines and adds up intensity
% after background adjustment. Uses theshold t.
% Look at plots to elucidate whether there might be errors due to
% contamination and other signals. Decide which lanes are trustworthy.
% Only applicable for single lane plots. Multi-lane plots will come in
% future. 
% Function is called in WB_auswertung (working title).
%
% @autor: Christin Krause 
% @version 1.1
% @adress: christin.krause55@gmail.com

    k = 1;  
    boolmap = zeros(size(pAkt));
        bg = mean(mean(pAkt(1:30,1:size(pAkt,1))));

        %% Create binary map
        for i=1:size(pAkt,1)
            for j=1:size(pAkt,2)
                pAkt_temp(i,j) = pAkt(i,j)- bg;
                if (pAkt(i,j)- bg >= t)
                    boolmap(i,j) = 1;
                end
            end
        end

        %% Control view 
        figure
        imshow(boolmap)
        figure
        imshow(pAkt_temp)

        %% Figure out where are my lanes

        % take means of columns, if > 0, there was a lane once
        l = mean(boolmap);
        lanes = l > 0;

        % Differentiate lanes
        actualLane = 1;
        lanePos    = zeros(2,numberOfLanes); % start and end
        for i=2:length(lanes)
           if(lanes(1,i) == 1 & lanes(1,i-1) == 0)
               lanePos(1,actualLane) = i;
           end
           if(lanes(1,i) == 0 & lanes(1,i-1) == 1)
               lanePos(2,actualLane) = i-1;
               actualLane = actualLane +1;
           end
        end

        laneValue = zeros(1,numberOfLanes);
        t = logical(boolmap);
        pAkt_temp_double = double(pAkt_temp);

        for i=1:length(lanePos)
            pOI = t(:,lanePos(1,i):lanePos(2,i));
            vOI = pAkt_temp_double(:,lanePos(1,i):lanePos(2,i));

            value = 0;

            for n = 1:size(pOI,1)
                for m = 1:size(pOI,2)
                    if(pOI(n,m) == 1)
                        value = value + vOI(n,m);
                        pOI;
                        vOI;
                    end
                end
            end       
            laneValue(1,i) = value;    
        end  
end

