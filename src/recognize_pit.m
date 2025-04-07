% RECOGNIZE_PIT - calculates the accuracy of recognizing speakers based on pitch contours.
%
% Syntax:  accuracy = recognize_pit(pTE, pTR)
%
% Inputs:
%    pTE - Matrix of pitch contours for testing samples, where each row represents a sample.
%    pTR - Matrix of average pitch contours per speaker used for training, where each row represents a speaker.
%    
% Outputs:
%    accuracy - Accuracy of speaker recognition based on pitch contours.
%
% Example: 
%    % Calculate accuracy of speaker recognition based on pitch contours
%    % for given testing and training pitch contour matrices.
%    acc = recognize_pit(pitch_test, pitch_train);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Mak Mckinney, computer engineering undergraduate
% University of Tennessee Knoxville, Dept. of Electrical Engineering and
% Computer Science
% Email address: mmckin22@vols.utk.edu  
% Website: https://github.com/crouchbindcommit
% May 2024; Last revision: 14-May-2024

%------------- BEGIN CODE --------------

function accuracy = recognize_pit(pTE, pTR)
    % Number of testing samples
    num_testing = size(pTE, 1);

    % Number of training samples
    num_training = size(pTR, 1);

    % Initialize accuracy counter
    correct_count = 0;

    % Iterate over each testing sample
    for i = 1:num_testing
        % Initialize minimum distance and corresponding label
        min_distance = Inf;
        min_label = -1;

        % Calculate Euclidean distance between testing sample and each training sample
        for j = 1:num_training
            distance = norm(pTE(i, :) - pTR(j, :)); % Euclidean distance

            % Update minimum distance and corresponding label
            if distance < min_distance
                min_distance = distance;
                min_label = j;
            end
        end

        % Check if the label matches for correct classification
        if min_label == ceil(i / 4)
            correct_count = correct_count + 1;
        end
    end

    % Calculate accuracy
    accuracy = correct_count / num_testing;
end


%------------- END OF CODE --------------
