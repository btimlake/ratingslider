% function [slider_position_now] = likert_ptbwiki(screenInfo, slider_position_old, move_slider)
% presents sliding scale with a slider that moves along the scale
% according to move_slider input (1 = move right, -1 = move left, 0 = stay)
% Returns slider_position_now, which is to be input as slider_position_old
% the next time sliding_scale is called.
% screenInfo is a structure such that:
% wdw_pointer = screenInfo.curWindow; % pointer to current window
% center = screenInfo.center; %physical center of scale
%
% made 6/29/09, psychtoolbox 3.

%%% for testing purposes only (cannot move slider) 
%%% comment here and at end of script to use likert within a larger script
try
clear all
%initialize the screen
[screenInfo.curWindow, screenInfo.screenRect] = Screen('OpenWindow', 0, [1 1 1],[],32, 2);
screenInfo.center = [screenInfo.screenRect(3) screenInfo.screenRect(4)]/2; % coordinates of screen center (pixels)
% end comment for testing purposes

%process passed in arguments
wdw_pointer = screenInfo.curWindow; % pointer to current window
center = screenInfo.center; %physical center of scale
if nargin < 2
slider_position_old = 0;
move_slider = 0;
end
if nargin < 3
move_slider = 0;
end

%set parameters
scale_range = 1:1:7; %fun requires odd number of intervals
scale_middle = mean([1:length(scale_range)]);
scale_question = {'Please rate how you feel';
''};
scale_hi_label = 'positive';
scale_low_label = 'negative';
% DELETE WHEN PASTED INTO SCRIPTS
fontSize = 50;
    Screen('TextFont', wdw_pointer, 'Courier New');
    Screen('TextSize', wdw_pointer, fontSize);
    Screen('TextStyle', wdw_pointer);
    Screen('TextColor', wdw_pointer, [0, 0, 0]);hi_label_width = RectWidth(Screen('TextBounds',wdw_pointer,scale_hi_label));
low_label_width = RectWidth(Screen('TextBounds',wdw_pointer,scale_low_label));
spacing = 60; %physical spacing of scale intervals in pixel units
penwidth = 5; % thickness of circle cursor that moves along the scale 

%prepare scale question
for line_num = 1:length(scale_question)
line_width = RectWidth(Screen('TextBounds',wdw_pointer,scale_question{line_num}));
Screen('DrawText', wdw_pointer, scale_question{line_num}, center(1) - line_width/2, ...
center(2) - text_size * (2 + length(scale_question)-line_num+1), pencolor);
end

%prepare scale labels
Screen('DrawText', wdw_pointer, scale_hi_label, ...
center(1) + spacing * (length(scale_range) + .5 - scale_middle), ...
center(2) + text_size, pencolor);
Screen('DrawText', wdw_pointer, scale_low_label, ...
center(1) + spacing * (.5 - scale_middle) - low_label_width, ...
center(2) + text_size, pencolor);

%prepare scale intervals
txt_width = RectWidth(Screen('TextBounds',wdw_pointer,num2str(scale_range(1))));
for i = 1:length(scale_range)
Screen('DrawText', wdw_pointer, num2str(scale_range(i)), ...
center(1) + spacing * (i - scale_middle) - txt_width/2, ...
center(2) - text_size/2, pencolor);
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
circleRect = [center - spacing/2, center + spacing/2];

% now position circle slider
circleRect(1:2:end) = circleRect(1:2:end) + slider_position_now * spacing;
Screen('FrameArc', wdw_pointer, pencolor, circleRect, 0, 360, penwidth);

%present drawing
Screen('Flip', wdw_pointer);


%%% for testing purposes
pause(5)
closeExperiment;

catch
disp('caught')
sca;
end;
% end comment for testing purposes