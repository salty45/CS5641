/* 
This class simulates the bellows 

 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
*/
public class Bellows {
  
  private float d1 = 3 * FT;
  private float d2 = 1.5 * FT;
  private float w = 5 * FT;
  private float h1 = 5 * FT;
  private float h2 = 2.5 * FT;
  
  private float [] leftHeights = { 0 * FT, 1.5 * FT, 3 * FT, 4.5 * FT };
  private float [] rightHeights = { 0.75 * FT, (1.5 + 0.75) * FT, 3.75 * FT };
  
  private boolean deflate = true;
  private boolean pump = true;
  
  public void pumpMe() {
    pump = !pump;
  }
  
  PImage leather1;
  
  public Bellows(PImage img) {
    leather1 = img;
  }
  
  void show() {
    pushMatrix();
   
    
    // front
    beginShape();
    texture(leather1);
    vertex(0, 0, d1, 0, leather1.height); // bottom left corner
    vertex(0, -h1, d1, 0, 0);
    vertex(w, -h2, d2 + 1 * FT, leather1.width, 0);
    vertex(w, -6 * IN, d2 + 1 * FT, leather1.width, leather1.height);
    endShape(CLOSE);
    
    // back
    beginShape();
    texture(leather1);
    vertex(0, 0, 0, 0, leather1.height); // bottom left corner
    vertex(0, -h1, 0, 0, 0);
    vertex(w, -h2, 1 * FT, leather1.width, 0);
    vertex(w, -6 * IN, 1 * FT, leather1.width, leather1.height);
    endShape(CLOSE);
    
    // top
    beginShape();
    texture(leather1);
    vertex(0, -h1, 0, 0, 0);
    vertex(0, -h1, d1, 0, leather1.height);
    vertex(w, -h2, d2 + FT, leather1.width, leather1.height);
    vertex(w, -h2, FT, leather1.width, 0);
    endShape(CLOSE);
    
    if (pump) {
      pump();
    }
    
    popMatrix();
  }
  
  void pump() {
    if (deflate) {
      h1--;
     // h2--;
     
    } else {
      h1++;
     // h2++;
    }
    
     if (h1 <= 2 * FT || h1 > 5 * FT) {
        deflate = !deflate;
     }
    
    
  }
  
  
}
