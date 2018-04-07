// Chad Riston Denaux
// Experimental Fourier Series approximation with phasor mutation.
// In class, setOscNum parameters initialiaze an array of SinOScs,
// each instance of which are iteratively accessed/mutated according 
// to their respective built in functions/params. The formula is a 
// bastardized approximation of the Fourier Series, with the additional 
// functionality of a "probe phasor" function to present 
// interesting phase shifts. The overall timbre is similar to a bell.
// The partial sequence output is off, but it produces interesting 
//results nonetheless. 


public class FFTSinOsc {
   
    Gain master;
    FFT fft;
    UAnaBlob blob;
    master => NRev r => dac;
    .1 => r.mix; 
      
    fun void setOscNum(int n, float f, float g){
       SinOsc s[n]; 
       setPartials(n, f, s, g);    
    }
    
    fun void setPartials(int n, float f, SinOsc sin[], float g){
        
        for(0 => int i; i < n ; i++){
            if(i==0){
               f => sin[i].freq;
               g => sin[i].gain;
            } else {
               f + sin[i-1].freq() * Math.sin((2*pi*Math.e)/10) * 1.33  => sin[i].freq;
               sin[i-1].gain()/(i) => sin[i].gain;
               ((Math.j*2*pi*i)/n) => complex t;  
               Math.exp(t.re)* sin[i-1].phase() => sin[i].phase;
            }   
            sin[i] => master; 
            <<<sin[i].freq(), sin[i].gain(), sin[i].phase() >>>;
        }
    }
         
}

FFTSinOsc ff;

ff.setOscNum(20, 250, .3);

10::second => now;