% TRAIN - Computes average pitch contours for each speaker
%
% Syntax: ptr = train('speaker_file_folder', 'lookup_table')
%
% Inputs:
% 'speaker_file_folder' - Path to folder containing speaker audio files relative to the running MATLAB program
% 'lookup_table' - Name of CSV file containing keys to Speaker Names
%
%
% Outputs:
% ptr - Matrix of average pitch contours per speaker (size: Number of Speakers x Number of Bins)
%
% Example:
% % Compute average pitch contours for a set of speakers
% ptr = train('speakerFile', 'lookup_table.csv');
%
% Author: Mak Mckinney, undergraduate student
% University of Tennessee Knoxville, Department of Electrical Engineering and Computer Science
% Contact: mmckin22@vols.utk.edu
% GitHub: https://github.com/crouchbindcommit
% May 2024; Last revision: 14-May-2024
%
%
%------------- BEGIN CODE --------------

function ptr = train(speaker_file_folder, lookup_table)
    % Load lookup table
    T = readtable(lookup_table);
    
    % Get number of students
    n = height(T);
    
    % Initialize matrix to store average pitch contours
    nbins = 100; 
    ntr = 8;
    ptr = zeros(n, nbins);
    
    % Lowpass filter kernel
    h = 1/10*[1 2 4 2 1];
    
    for i = 1:n
        histo = zeros(1, nbins);
        
        for j = 1:ntr
            filename = sprintf('%s/%s-%d.wav', speaker_file_folder, char(T.Initial(i, 1)), j); 

            [audioIn, fs] = audioread(filename); 
            
            % Apply lowpass filter
            audioIn(:,1) = conv(audioIn(:,1), h, 'same');

            % Calculate pitch contour using the built-in pitch function
            f0 = pitch(audioIn, fs);

            % Standardize pitch contour using histogram
            H = histogram(f0, nbins, "Normalization", "probability");
            histo = histo + H.Values;
        end
        
        % Calculate average
        ptr(i,:) = histo/ntr;
    end
end


%------------- END OF CODE --------------
