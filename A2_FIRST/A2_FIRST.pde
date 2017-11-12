/*
*****************************************************************************************
BENVGACH- Introduction to Programming for Architecture and Design
Assignment 2- Creating Multi-Note Step Sequencer
Felicia Gutmans 
Student 13008920
13 November 2017
*****************************************************************************************
This program creates a Multi-note step sequencer.
It consists of five notes or frequencies that respond to the user's click of the mouse.
Depending on which square in the grid the user selects, a different sound is played. 
*****************************************************************************************
*/

import processing.sound.*; //Importing Processing's sound feature so that sound can be played.

SinOsc sin;

int spacing= 50; //Establishing the size of the grid and the dimensions of the squares that make it up.
int t;

float [] freqs; //Array of frequencies.
boolean [][] selected;

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
  
  for(int i=0; i<selected.length; i++)
  {
    for(int j=0; j<selected.length; j++) 
    {
      selected[i][j]= false; //Tnis determines that by default, the grid/squares should not make sounds.
     }
   }
   sin= new SinOsc(this);
}  

void draw()
{
  background(0);
  
  //This makes the sound move across the grid and makes the selected squares
  //play sounds.
 
  if(frameCount%15==1) 
    {
      t=(t+1)%16;
      sin.stop(); //Makes the sound stop once the note has been "played", creating short sounds.
  
  //This makes established what squares should be playing what sounds- or links the 
  //squares to the array of frequencies established above.
  for (int j=0; j<selected.length;j++) 
    {
      if(selected[t][j]) 
      { 
      sin.freq(freqs[j]);  //makes the different frequencies play, to produce different sounds.
      sin.play();
      }
    }
  }
  
  //Making the squares appear coloured when clicked.
  for(int i= 0; i<16; i++)
    {
      for (int j = 0; j<5; j++)
      {
        if(selected[i][j]) fill(150,150,255);
        else fill(255); // Differentiating the unclicked squares from the clicked squares by making them a differnet colours.
        
        if(i==t) fill(255,0,0);
      
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