classdef WaveSim < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = public)
        Width
        Height
        WaveSpeed = 10
        OldMatrix
        Matrix
        Iterations = 10
        
        IterationCount = 0
    end
    
    methods
        function this = WaveSim(w, h)
            this.Width = w;
            this.Height = h;
            
            this.Matrix = zeros(this.Width + 2, this.Height + 2);
            this.OldMatrix = this.Matrix;
        end
        
        function setSource(this, v, amp)
           if size(v, 2) == 2
               this.Matrix(v(2) + this.Height / 2, v(1) + this.Width / 2) = amp;
           end
           
           this.OldMatrix = this.Matrix;
        end
        
        function step(this)
            % Zrodlo:
            % The Wave Equation in 1D and 2D
            % Knut?Andreas Lie
            % Dept. of Informatics, University of Oslo
            % http://www.uio.no/studier/emner/matnat/ifi/INF2340/v05/foiler/sim04.pdf
            

            dt = 1 / this.Iterations;
            
            
            for its = 1 : this.Iterations
                oldm = this.OldMatrix;
                curm = this.Matrix;
                newm = zeros(size(this.Matrix));
                
                
                for i = 2 : this.Height
                   for j = 2 : this.Width
                       r2 = dt;
                       newm(i, j) = 2 * curm(i, j) - oldm(i, j) + ...
                           r2 * (curm(i + 1, j) + curm(i, j + 1) + ...
                           curm(i - 1, j) + curm(i, j - 1) + 4 * curm(i, j));
                   end
                end
                
                % Border cells.
                for i = 1 : 
                
                this.OldMatrix = this.Matrix;
                this.Matrix = newm;
                this.IterationCount = this.IterationCount + 1;
            end
            

        end
        
        function mat = getMatrix(this)
            mat = this.Matrix(2 : end - 1, 2 : end - 1);
        end
    end
end