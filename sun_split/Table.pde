/**
 Table for smithy.  Getting it to display was difficult enough and detailed enough that it 
 was worth making a separate class.
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

public class Table1 {
 
  private float _width;
  private float _height;
  private float _depth;
  private float leg_width;
  private float leg_depth;
  private float thickness;
  
  // 0, 0, 0 is the back left corner of the table
  private float x;
  private float y;
  private float z;
  
  private PImage wood;
  
  /**
   * Builds a default table that is 5 ft x 3 ft and 30 in tall
   * and leg size of 4 in x 4 in
   * @param wood  the material to be applied to the table
   */
  public Table1(PImage wood) {
    this.wood = wood;  
    this._width = 3 * FT;
    this._height = 30 * IN;
    this._depth = 5 * FT;
    this.x = 0;
    this.y = 0;
    this.z = 0;
    this.leg_width = 4 * IN;
    this.leg_depth = 4 * IN;
    this.thickness = 1.5 * IN;
  }
  
  public Table1(PImage wood, float w, float h, float d) {
    this.wood = wood;  
    this._width = w;
    this._height = h;
    this._depth = d;
    this.x = 0;
    this.y = 0;
    this.z = 0;
    this.leg_width = 4 * IN;
    this.leg_depth = 4 * IN;
    this.thickness = 1.5 * IN;
  }
  
  public Table1(PImage wood, float w, float h, float d, float lw, float ld) {
    this.wood = wood;  
    this._width = w;
    this._height = h;
    this._depth = d;
    this.x = 0;
    this.y = 0;
    this.z = 0;
    this.leg_width = lw;
    this.leg_depth = ld;
    this.thickness = 1.5 * IN;
  }
  
  
  
  /**
   * Draw the table into the scene
   */
  void show() {
    pushMatrix();
    translate(x, y, z);
    // table top
    pushMatrix();
    translate(0, -(_height - thickness), 0);
    rect_prism(_width, thickness, _depth, wood);
    popMatrix();
    
    // legs
    // back left
    pushMatrix();
    translate(1 * IN, 0, 1 * IN);
    rect_prism(leg_width, _height - thickness, leg_depth, wood);
    popMatrix();
    
    // back right
    pushMatrix();
    translate(_width - 1 * IN - leg_width, 0, 1 * IN);
    rect_prism(leg_width, _height - thickness, leg_depth, wood);
    popMatrix();
    
    // front left 
    pushMatrix();
    translate(1 * IN, 0, _depth - 1 * IN - leg_depth);
    rect_prism(leg_width, _height - thickness, leg_depth, wood);
    popMatrix();
    
     // front right 
    pushMatrix();
    translate(_width - (1 + leg_width), 0, _depth - 1 * IN - leg_depth);
    rect_prism(leg_width, _height - thickness, leg_depth, wood);
    popMatrix();
    popMatrix();
    
  }
  
  
  
  public void setLocation(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  
}
