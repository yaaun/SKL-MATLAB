classdef WaveApp < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        Sim
        Sources = []
    end
    
    properties (Access = public)
        UpdateFunc = @(thisobj) 0;
        FramePause = 0.2
        Axis
        RunButtonHandle
    end
    
    methods
        function this = WaveApp()
           
        end
        
        function configure(this, conf)
            this.Axis = conf.AxisHandle;
            this.RunButtonHandle = conf.RunButtonHandle;
            
            this.Sim = WaveSim(conf.Width, conf.Height);
            disp(this.Sim);
            this.Sim.WaveSpeed = conf.WaveSpeed;
            this.Sim.WaveLength = conf.WaveLength;
            this.Sim.Iterations = conf.Iterations;
            
            for src = this.Sources
                this.Sim.setSource(src.Position, src.Amplitude, src.Type);
            end
            
        end
        
        
        function start(this)
            xmin = -this.Sim.Width / 2;
            xmax = this.Sim.Width / 2;
            ymin = -this.Sim.Height / 2;
            ymax = this.Sim.Height / 2;
            
            aX = linspace(xmin, xmax, this.Sim.Width);
            aY = linspace(ymin, ymax, this.Sim.Height)';
            
            while this.RunButtonHandle.Value == 1
                this.Sim.step();
                
                surf(this.Axis, aX, aY, this.Sim.getMatrix(), 'EdgeColor', 'none');
                view(this.Axis, 2);
                this.Axis.CLim = [-1 , 1];
                this.Axis.FontSize = 8;

                colormap(this.Axis, 'jet');
                colorbar(this.Axis, 'east');
                pause(this.FramePause);
            end
        end
        
        function reset(this)
            delete(this.Sim);
            this.Sources = [];
            cla(this.Axis);
        end
        
        function mat = WaveMatrix(this)
            mat = this.Sim.Matrix;
        end

        function valid = setFieldWidth(this, x)
            this.Sim.Width = floor(x);
            valid = true;
        end
        
        function valid = setFieldHeight(this, x)
            this.Sim.Height = floor(x);
            valid = true;
        end
        
        function valid = setIterationsPerFrame(this, x)
            this.Iterations = floor(x);
            valid = true;
        end
        
        function valid = setWaveSpeed(this, x)
            this.Sim.WaveSpeed = x;
            valid = true;
        end
        
        function addSource(this, src, amp)
            % src is a struct with fields:
            % Position
            % Amplitude
            % Type
            s = struct();
            
            if ismatrix(src)
                s.Position = src;
                s.Amplitude = amp;
                s.Type = 'sin';
            end
            
            this.Sources = [this.Sources s];
        end
    end
    
end

