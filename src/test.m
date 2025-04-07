% TEST - Computes pitch contours for testing audio files
%
% Syntax: pTE = test('speaker_file_folder', 'lookup_table')
%
% Inputs:
% 'speaker_file_folder' - Path to folder containing speaker audio files relative to the running MATLAB program
% 'lookup_table' - Name of CSV file containing keys to Speaker Names
%
%
% Outputs:
% pTE - Matrix of pitch contours for testing audio files (size: Number of Testing Files x Number of Bins)
%
% Example:
% % Compute pitch contours for testing audio files
% pTE = test('audio_folder', 'speakerID.csv');
%
% Author: Mak Mckinney, undergraduate student
% University of Tennessee Knoxville, Department of Electrical Engineering and Computer Science
% Contact: mmckin22@vols.utk.edu
% GitHub: https://github.com/crouchbindcommit
% May 2024; Last revision: 14-May-2024

%------------- BEGIN CODE --------------

function pTE = test(speaker_file_folder, lookup_table)
    % Load lookup table
    T = readtable(lookup_table);
    
    % Get number of students
    n = height(T);
    
    % Initialize matrix to store pitch contours for testing audio files
    num_testing_files = 24 * 4; 
    nbins = 100; 
    pTE = zeros(num_testing_files, nbins);

    % Lowpass filter kernel
    h = 1/10*[1 2 4 2 1];

    % Iterate over all students
    for i = 1:n
        % Iterate over testing audio files i ∈ [9, 12]
        for j = 9:12
            % Construct filename
            filename = sprintf('%s-%d.wav', char(T.Initial(i, 1)), j);

            % Read audio file
            [audioIn, fs] = audioread(fullfile(speaker_file_folder, filename));

            % Apply lowpass filter
            audioIn(:,1) = conv(audioIn(:,1), h, 'same');

            % Calculate pitch contour using the built-in pitch function
            f0 = pitch(audioIn, fs);

            % Standardize pitch contour using histogram
            H = histogram(f0, nbins, "Normalization", "probability");
            histo = H.Values;

            % Save pitch contour in the matrix pTE
            row_index = (i - 1) * 4 + (j - 8);
            pTE(row_index, :) = histo;
        end
    end
end



%------------- END OF CODE --------------
