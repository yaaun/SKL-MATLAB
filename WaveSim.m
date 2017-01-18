classdef WaveSim < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = public)
        Width
        Height
        WaveSpeed = 10
        WaveLength = 1
        OldMatrix
        Matrix
        Iterations = 10
        Sources
        
        IterationCount = 0
    end
    
    methods
        function this = WaveSim(w, h)
            this.Width = w;
            this.Height = h;
            
            this.Matrix = zeros(this.Width + 2, this.Height + 2);
            this.OldMatrix = this.Matrix;
        end
        
        function setSource(this, v, amp, type)
            s = struct(...
                'Pos', v, 'Amp', amp, 'Type', type ...
            );
           
            this.Sources = [this.Sources s];
        end
        
        % To niestety nie dziala jak powinno.
        function step(this)
            % Zrodlo:
            % The Wave Equation in 1D and 2D
            % Knut?Andreas Lie
            % Dept. of Informatics, University of Oslo
            % http://www.uio.no/studier/emner/matnat/ifi/INF2340/v05/foiler/sim04.pdf
            

            dt = 1 / this.Iterations;
            dx = 1;
            time = this.IterationCount / this.Iterations;
            
            
            for its = 1 : this.Iterations
                oldm = this.OldMatrix;
                curm = this.Matrix;
                newm = zeros(size(this.Matrix));
                

                
                for i = 2 : this.Height
                   for j = 2 : this.Width
                       r2 = dt / dx;
                       r2 = 0.5;
                       newm(i, j) = 2 * curm(i, j) - oldm(i, j) + ...
                           r2 * (curm(i + 1, j) + curm(i, j + 1) + ...
                           curm(i - 1, j) + curm(i, j - 1) + 4 * curm(i, j));
                   end
                end
                
                % Set values at source locations.
                if time < 100
                    for src = this.Sources
                       x = src.Pos(1) + this.Width / 2;
                       y = src.Pos(2) + this.Height / 2;
                       czestosc = 2 * pi * this.WaveSpeed / this.WaveLength;

                       %val = src.Amp * sin(czestosc * this.IterationCount / this.Iterations);
                       val = src.Amp * exp(-time + 5).^2;
                       newm(y, x) = val;


                    end
                end
                
                this.OldMatrix = curm;
                this.Matrix = newm;
                this.IterationCount = this.IterationCount + 1;
            end
            

        end
%         function step(this)
%             c0 = 30;         % speed of light or any wave
% 
%             sz = this.Width + 2;
% 
%             dx = 0.01;        % spatial increment
% 
%             dt = dx/c0;  % time increment
% 
%             cons=0.5; % constant term of electric and magnetic field equations
% 
% 
%             % u=zeros(1,size);
%             u_n = zeros(sz);
%             u_p = this.OldMatrix;
%             u = this.Matrix;
% 
%             t0 = 15;   % t0 of Gaussian source 
%             tp = 5;   % tp of Gaussian source
%             for i = 2 : sz - 1
%                 for j= 2: sz - 1      
%                     u_n(i,j) = 2 * u_n(i,j) - u_p(i,j) + (cons^2) * (u(i + 1,j) + u(i - 1,j) - 4 * u(i,j) + u(i,j + 1) + u(i,j - 1));
%                 end
%             end
%             
%             this.OldMatrix = u;   % after this iteration present state becomes previous state
%             this.Matrix = u_n;   % next step becomes present state
%             
%             k = this.IterationCount / this.Iterations;
%             
%             for src = this.Sources
%                 x = src.Pos(1) + this.Width / 2;
%                 y = src.Pos(2) + this.Height / 2;
%                 v = src.Amp * exp(-((k - t0) / tp)^2);
%                 
%                 this.Matrix(y, x) = v;
%             end
%         end
        
        
        function mat = getMatrix(this)
            mat = this.Matrix(2 : end - 1, 2 : end - 1);
        end
    end
end
