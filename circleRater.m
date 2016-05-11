% this function is called by circleLikert... see help for that instead

function circleRater(c,bottomtext,scaletext,colors,window,scanner) % k= which dimension you are measuring, e.g. valence = 1
% draw question
% Screen('TextSize',window,34);
[window, screenRect] = Screen('OpenWindow', 0, [255, 255, 255], [0 0 640 480]); %white background
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
instruct1TextYpos = screenYpixels * 2/40; 
c.qnHeight = 2*screenXpixels/6;
instructCola = [0.5 0.5 0];
bottomtext = 'Please rate how you feel';
c.numEls = 9;
c.slidepos = 1;

DrawFormattedText(window, bottomtext,'center',instruct1TextYpos, instructCola);

rects=[];


%determine position of circles
for x=1:c.numEls
    centerX = c.linestart+c.circleSep*(x-1);
    rects(1,x) = centerX-c.radius;
    rects(2,x) = c.height-c.radius;
    rects(3,x) = centerX+c.radius;
    rects(4,x)= c.height+c.radius;
    
end

% draw circles
Screen('FillOval', window, colors, rects);

% draw slider
c.slideposX = (c.slidepos-1)*c.circleSep + c.linestart;
Screen('FillOval', window, [0 0 0], [c.slideposX-c.slideRadius, c.height-c.slideRadius, c.slideposX+c.slideRadius, c.height+c.slideRadius]);


% draw legend
scalekey=scaletext;  % extra spaces so they spread out evenly
for y=1:3
    DrawFormattedText(window, scalekey{y}, (c.linestart+(c.linelength)*(y-1)/2)-180, c.scaleHeight,c.textColor);
end
%draw instruction
Screen('TextSize',window,28);
if scanner==1
DrawFormattedText(window, 'Move the indicator with ''1'' and ''2'', then press ''3'' to confirm', 'center', c.instrHeight,c.textColor);
else
DrawFormattedText(window, 'Move the indicator with the arrow keys, then press ''g'' to confirm', 'center', c.instrHeight,c.textColor);
end
Screen('Flip',window);
end