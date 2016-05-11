function [slider_position_now] = likert_slider(slider_position_old, move_slider)
% function [slider_position_now] = likert_slider(screenInfo, slider_position_old, move_slider)

% draw rating line
% sepLineYpos = screenYpixels * 39/80; % Screen Y position of separator line
% textXpos = round(screenXpixels * 0.09 - screenXpixels * 2/56); % left position of text and separator line
% lineEndXpos = round(screenXpixels * 0.91 + screenXpixels * 2/56); % right endpoint of separator line

% write instruction

% code mouse response
% or use arrows

% space bar to continue

% wdw_pointer = screenInfo.curWindow; % pointer to current window
% center = screenInfo.center; %physical center of scale
% if nargin < 2
% slider_position_old = 0;
% move_slider = 0;
% end
% if nargin < 3
% move_slider = 0;
% end

% slider_position_old = 0;
% move_slider = 1;

%set parameters
scale_range = 1:1:7; %fun requires odd number of intervals
scale_middle = mean([1:length(scale_range)]);
scale_question = {'Please rate how you feel';
'using the arrow keys.'};
scale_hi_label = 'positive';
scale_middle_label = 'neutral';
scale_low_label = 'negative';
% DELETE WHEN PASTED INTO SCRIPTS
% fontSize = 50;
%     Screen('TextFont', window, 'Courier New');
%     Screen('TextSize', window, fontSize);
%     Screen('TextStyle', window);
%     Screen('TextColor', window, [0, 0, 0]);hi_label_width = RectWidth(Screen('TextBounds',window,scale_hi_label));
low_label_width = RectWidth(Screen('TextBounds',window,scale_low_label));
middle_label_width = RectWidth(Screen('TextBounds',window,scale_middle_label));
spacing = 60; %physical spacing of scale intervals in pixel units
penwidth = 3; % thickness of circle cursor that moves along the scale 
pencolor = botTextColor;

%prepare scale question
for line_num = 1:length(scale_question)
line_width = RectWidth(Screen('TextBounds',window,scale_question{line_num}));
Screen('DrawText', window, scale_question{line_num}, screenCenter(1) - line_width/2, ...
screenCenter(2) - fontSize * (2 + length(scale_question)-line_num+1), pencolor); 
end

%prepare scale labels
Screen('DrawText', window, scale_hi_label, ...
screenCenter(1) + spacing * (length(scale_range) + .5 - scale_middle), ...
screenCenter(2) + fontSize, pencolor);
Screen('DrawText', window, scale_low_label, ...
screenCenter(1) + spacing * (.5 - scale_middle) - low_label_width, ...
screenCenter(2) + fontSize, pencolor);

%prepare scale intervals
txt_width = RectWidth(Screen('TextBounds',window,num2str(scale_range(1))));
for i = 1:length(scale_range)
Screen('DrawText', window, num2str(scale_range(i)), ...
screenCenter(1) + spacing * (i - scale_middle) - txt_width/2, ...
screenCenter(2) - fontSize/2, pencolor);
end

%prepare rating slider
if abs(slider_position_old + move_slider) > (length(scale_range) - scale_middle);
move_slider = 0; %to avoid ratings outside range of scale
end
slider_position_now = (slider_position_old + move_slider);
slider_position_old = slider_position_now;

% position circle slider, but first
% change coordinates from center of circle to the corners of a box that
% would enclose the circle for use with Screen('FrameArc')
circleRect = [screenCenter - spacing/2, screenCenter + spacing/2];

% now position circle slider
circleRect(1:2:end) = circleRect(1:2:end) + slider_position_now * spacing;
Screen('FrameArc', window, pencolor, circleRect, 0, 360, penwidth);

%present drawing
Screen('Flip', window);

end
