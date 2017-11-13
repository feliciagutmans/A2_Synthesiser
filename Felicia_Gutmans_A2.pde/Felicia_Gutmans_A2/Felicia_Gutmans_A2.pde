/*
*****************************************************************************************
BENVGACH- Introduction to Programming for Architecture and Design
Assignment 2- Creating Multi-Note Step Sequencer
Felicia Gutmans 
Student 13008920
13 November 2017
*****************************************************************************************
This program creates a multi-note step sequencer.
It consists of five notes or frequencies that are positioned on a 5*16 square grid, one
different frequency per row.
The squares in the grid respond to the user's mouse click and prompt different frequencies 
to be played as the sequencer moves forward over the selected squares, creating sound.
Depending on which squares in the grid the user selects, different sounds are played. 
*****************************************************************************************
*/

import processing.sound.*; //Importing Processing's sound feature so sound can be played.

SinOsc sin; //Generates a sin wave to make the sound work.

int spacing= 50; //Establishing the spacing between the grid's separate squares.
int t; //Represents the sequencer's cursor, creating the movement across the grid that generates sound.

float [] freqs; //Array of frequencies.
boolean [][] selected; //Array of squares in grid.

void setup ()
{
  size (800,300); //Determining size of the frame.
  t= 0;
  
 //Naming number of elements in the arrays.
  selected= new boolean [16][16];
  freqs= new float[5]; //Determining number of frequencies/notes possible.
  
  //Adding sounds (frequencies) to the freqs array.
  freqs[0]= 1480;
  freqs[1]= 1320;
  freqs[2]= 1110;
  freqs[3]= 990;
  freqs[4]= 880;
  
  //Nested array to help set up the program.
  for(int i=0; i<selected.length; i++)
  {
    for(int j=0; j<selected.length; j++) 
    {
      selected[i][j]= false; //This determines that by default, the grid/squares should not make sounds.
     }
   }
   sin= new SinOsc(this); //Sine Wave Oscillator to make the sound work.
}  

void draw()
{
  background(0);
  
  //This makes the sound move across the grid and makes the selected squares
  //play sounds.
  if(frameCount%15==1) 
    {
      t=(t+1)%16; // Determines that the sequencer should move along all 16 columns of the grid, one column at a time.
      sin.stop(); //Makes the sound stop once the note has been "played", creating short sounds.
  
  //This establishes the sounds played by the squares, linking them to the 
  //array of sound frequencies listed above.
  for (int j=0; j<selected.length;j++) 
    {
      if(selected[t][j]) //If the cursor coincides with s selected square/frequency.
      { 
      sin.freq(freqs[j]);  //Establishes that each element in the freqs array produces a different sound.
      sin.play(); // Plays the different frequencies selected.
      }
    }
  }
  
  //Making the squares appear coloured when clicked.
  for(int i= 0; i<16; i++)
    {
      for (int j = 0; j<5; j++)
      {
        if(selected[i][j]) fill(150,150,255);
        else fill(255); // Differentiating the unclicked squares from the clicked squares by making them different colours.
        
        if(i==t) fill(255,0,0); //Making the cursor appear red, therefore visible when moving along grid.
      
//Establishing the dimensions of the squares in the grid, including size and proportions.        
      rect(i*spacing, j*spacing, spacing-10, spacing-10);
      }
   }
} 
    
  //Makes the grid respond to the click of the mouse.
  //Once the mouse is clicked, causes the selected squares to change colour.  
  void mousePressed()
{
    int eye = mouseX/spacing; //Referring to the mouse clicking on the X axis.
    int eye1= mouseY/spacing; //Referring to the mouse clicking on the Y axis.
    if(eye>-1 && eye<selected.length && eye1>-1 && eye1<selected.length) selected[eye][eye1]=!selected[eye][eye1];
}  