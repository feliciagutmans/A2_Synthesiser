import processing.sound.*;

SinOsc sin;

int spacing= 50;
int t;

float [] freqs; //Array of Frequencies
boolean [][] selected;

void setup ()
{
  size (800,300);
  t= 0;
  
  //Naming number of elements in arrays
  selected= new boolean [16][16];
  freqs= new float[5];
  
  //Adding sounds (frequencies) to the freq array
  freqs[0]= 1480;
  freqs[1]= 1320;
  freqs[2]= 1110;
  freqs[3]= 990;
  freqs[4]= 880;
  
  for(int i=0; i<selected.length; i++)
  {
    for(int j=0; j<selected.length; j++) //was freqs before
    {
      selected[i][j]= false;
     }
   }
   sin= new SinOsc(this);
}  

void draw()
{
  background(0);
  
  //prompting sound
  if(frameCount%15==1) 
    {
      t=(t+1)%16;
      sin.stop();
      
  for (int j=0; j<freqs.length;j++) 
    {
      if(selected[t][j]) 
      { 
      sin.freq(freqs[j]);  //for different frequencies (Need to figure out how to make chords/several notes at once work properly...)
      sin.play();
      }
    }
  }
  
  //making the squares appear coloured when clicked
  for(int i= 0; i<16; i++)
    {
      for (int j = 0; j<5; j++)
      {
        if(selected[i][j]) fill(150,150,255);
        else fill(255);
        
        if(i==t) fill(255,0,0);
        
      rect(i*spacing, j*spacing, spacing-10, spacing-10);
      }
   }
} 
    
  void mousePressed()
{
    int eye = mouseX/spacing;
    int eye1= mouseY/spacing;
    if(eye>-1 && eye<selected.length && eye1>-1 && eye1<selected.length) selected[eye][eye1]=!selected[eye][eye1];
}  