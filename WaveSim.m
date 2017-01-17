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
        
        function step(this)
            % Zrodlo:
            % The Wave Equation in 1D and 2D
            % Knut?Andreas Lie
            % Dept. of Informatics, University of Oslo
            % http://www.uio.no/studier/emner/matnat/ifi/INF2340/v05/foiler/sim04.pdf
            

            dt = 1 / this.Iterations;
            dx = 1;
            
            
            for its = 1 : this.Iterations
                oldm = this.OldMatrix;
                curm = this.Matrix;
                newm = zeros(size(this.Matrix));
                

                
                for i = 2 : this.Height
                   for j = 2 : this.Width
                       r2 = dt / dx;
                       newm(i, j) = 2 * curm(i, j) - oldm(i, j) + ...
                           r2 * (curm(i + 1, j) + curm(i, j + 1) + ...
                           curm(i - 1, j) + curm(i, j - 1) + 4 * curm(i, j));
                   end
                end
                
                % Set values at source locations.
                for src = this.Sources
                   x = src.Pos(1) + this.Width / 2;
                   y = src.Pos(2) + this.Height / 2;
                   czestosc = 2 * pi * this.WaveSpeed / this.WaveLength;
                   
                   val = src.Amp * sin(czestosc * this.IterationCount / this.Iterations);
                   
                   newm(y, x) = val;
                end
                
                this.OldMatrix = curm;
                this.Matrix = newm;
                this.IterationCount = this.IterationCount + 1;
            end
            

        end
        
        function mat = getMatrix(this)
            mat = this.Matrix(2 : end - 1, 2 : end - 1);
        end
    end
end
