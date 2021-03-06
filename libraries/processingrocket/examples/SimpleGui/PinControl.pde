/* 
 * This file is part of the ROCKETuC Processing Library project
 *
 * Copyright (C) 2012 Stefan Wendler <sw@kaltpost.de>
 *
 * The ROCKETuC Processing Library is free software; you can redistribute 
 * it and/or modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * ROCKETuC Processing Library is distributed in the hope that it will 
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with the JRocket firmware; if not, write to the Free
 * Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA.  
 */

import rocketuc.processing.*;

/**
 * Base class for all pin controls. Pin controls have a PinPanel 
 * as a parent. 
 */
class PinControl {

  protected PinPanel parent;
  protected boolean  error = false; 

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControl(PinPanel parent) {
    this.parent = parent;
  }

  /**
   * Draw the pins status + controls.
   */
  void draw() {
    fill(0);
    rect(parent.getX() + 220, parent.getY() + 10, 175, parent.getH() - 20);

    if(error) {
      fill(255, 0, 0);   
      text("ERROR", parent.getX() + 230, parent.getY() + 27);
    }
  }
}

/**
 * Specific pin control for pins in mode INPUT-FLOAT.
 */ 
class PinControlIf extends PinControl {

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
   PinControlIf(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlIf");

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.INPUT);
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }

  /**
   * Draw the pins status + controls.
   */
  void draw() {
    super.draw();

    if (error) {
      return;
    }

    ROCKETuC r = parent.getROCKETuC();

    String state = "LOW";

    try {
      if (r.digitalRead(parent.getPin()) == ROCKETuC.HIGH) {
        state = "HIGH";

        fill(0, 255, 0);        
      }
      else {
        fill(128);
      }
      ellipse(parent.getX() + 383, parent.getY() + 23, 15, 15);      
    }
    catch(Exception e) {
      println("ERROR: " + e.getMessage());
    }

    fill(255);    
    text(state, parent.getX() + 230, parent.getY() + 27);
  }
}

/**
 * Specific pin control for pins in mode INPUT-PULL-UP.
 */ 
class PinControlIu extends PinControlIf {

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControlIu(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlIu");

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.PULLUP);
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }
}

/**
 * Specific pin control for pins in mode INPUT-PULL-DOWN.
 */ 
class PinControlId extends PinControlIf {

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControlId(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlId");

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.PULLDOWN);
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }
}

/**
 * Specific pin control for pins in mode DIGITAL-OUTPUT.
 */ 
class PinControlDo extends PinControl {

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControlDo(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlDo");    

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.OUTPUT);
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }

  /**
   * Draw the pins status + controls.
   */
  void draw() {
    super.draw();

    if (error) {
      return;
    }

    ROCKETuC r = parent.getROCKETuC();

    String state = "LOW";

    try {
      int x1 = parent.getX() + 220;
      int x2 = x1 + 175;
      int y1 = parent.getY() + 5;
      int y2 = y1 + parent.getH() - 10;

      if (mouseX >= x1 && mouseX <= x2 && 
        mouseY >= y1 && mouseY <= y2 && mousePressed) {

        r.digitalWrite(parent.getPin(), ROCKETuC.TOGGLE);
      }

      if (r.digitalRead(parent.getPin()) == ROCKETuC.HIGH) {
        state = "HIGH";

        fill(0, 255, 0);
      }
      else {
        fill(128);
      }
      ellipse(parent.getX() + 383, parent.getY() + 23, 15, 15);      
    }
    catch(Exception e) {
      println("ERROR: " + e.getMessage());
    }

    fill(255);    
    text(state + " (click to change)", parent.getX() + 230, parent.getY() + 27);
  }
}

/**
 * Specific pin control for pins in mode ANALOG-READ.
 */ 
class PinControlAr extends PinControl {

  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControlAr(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlAr");

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.ANALOG);
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }

  /**
   * Draw the pins status + controls.
   */
  void draw() {
    super.draw();

    if (error) {
      return;
    }

    ROCKETuC r = parent.getROCKETuC();

    short a = 0;  
    float v = 0;

    try {
      a = r.analogRead(parent.getPin());
      v = (float) ((3.3 / 1024.0) * (float)a);
    }
    catch(Exception e) {
      println("ERROR: " + e.getMessage());
    }

    fill(255, 255, 0);    
    text("~ " + nf(v, 1, 1) + "V (" + a + ")", parent.getX() + 230, parent.getY() + 27);
  }
}

/**
 * Specific pin control for pins in mode PWM.
 */ 
class PinControlPw extends PinControl {

  private int p  = 1000;
  private int dc = 100;
  
  /**
   * Constructor
   * 
   * @param parent the parent pin panel of this control
   */
  PinControlPw(PinPanel parent) {
    super(parent);
    println(parent.getPinName() + " PinControlPw");

    ROCKETuC r = parent.getROCKETuC();

    try {
      r.pinMode(parent.getPin(), ROCKETuC.PWM);
      r.pwmPeriod(parent.getPin(), p);
      
      int edc = 0xFF / 100 * dc;
      r.pwmDuty(parent.getPin(), edc);      
    }
    catch(Exception e) {
      error = true;
      println("ERROR: " + e.getMessage());
    }
  }

  /**
   * Draw the pins status + controls.
   */
  void draw() {    
    super.draw();

    if (error) {
      return;
    }   

    fill(255);
    rect(parent.getX() + 277, parent.getY() + 10, 34, 25);
    rect(parent.getX() + 361, parent.getY() + 10, 34, 25);

    fill(0, 128, 0);
    
    // period
    rect(parent.getX() + 280, parent.getY() + 13, 10, 8);
    rect(parent.getX() + 293, parent.getY() + 13, 15, 8);

    // dc
    rect(parent.getX() + 364, parent.getY() + 13, 10, 8);
    rect(parent.getX() + 378, parent.getY() + 13, 15, 8);
    
    fill(128, 0, 0);

    // period    
    rect(parent.getX() + 280, parent.getY() + 24, 10, 8);
    rect(parent.getX() + 293, parent.getY() + 24, 15, 8);

    // dc
    rect(parent.getX() + 364, parent.getY() + 24, 10, 8);
    rect(parent.getX() + 378, parent.getY() + 24, 15, 8);
    
    fill(255);    
    text("P: " + p, parent.getX() + 230, parent.getY() + 27);
    text("DC: " + dc, parent.getX() + 318, parent.getY() + 27);

    try {    
      int pp  = p;
      int pdc = dc;
      
      int p1x1 = parent.getX() + 280;
      int p1x2 = p1x1 + 10;
      int p1y1 = parent.getY() + 13;
      int p1y2 = p1y1 + 8;

      int p2x1 = parent.getX() + 293;
      int p2x2 = p2x1 + 10;
      int p2y1 = parent.getY() + 15;
      int p2y2 = p2y1 + 8;

      int p3x1 = parent.getX() + 280;
      int p3x2 = p3x1 + 10;
      int p3y1 = parent.getY() + 24;
      int p3y2 = p3y1 + 8;

      int p4x1 = parent.getX() + 293;
      int p4x2 = p4x1 + 10;
      int p4y1 = parent.getY() + 24;
      int p4y2 = p4y1 + 8;

      int dc1x1 = parent.getX() + 364;
      int dc1x2 = dc1x1 + 10;
      int dc1y1 = parent.getY() + 13;
      int dc1y2 = dc1y1 + 8;

      int dc2x1 = parent.getX() + 378;
      int dc2x2 = dc2x1 + 10;
      int dc2y1 = parent.getY() + 15;
      int dc2y2 = dc2y1 + 8;

      int dc3x1 = parent.getX() + 364;
      int dc3x2 = dc3x1 + 10;
      int dc3y1 = parent.getY() + 24;
      int dc3y2 = dc3y1 + 8;

      int dc4x1 = parent.getX() + 378;
      int dc4x2 = dc4x1 + 10;
      int dc4y1 = parent.getY() + 24;
      int dc4y2 = dc4y1 + 8;

      if(mouseX >= p1x1 && mouseX <= p1x2 && 
         mouseY >= p1y1 && mouseY <= p1y2 && mousePressed) {
         println("P+");
         p = p + 10;
         if(p > 64000) p = 64000;  
       }
       else if(mouseX >= p2x1 && mouseX <= p2x2 && 
               mouseY >= p2y1 && mouseY <= p2y2 && mousePressed) {

         println("P++");
         p = p + 1000;
         if(p > 64000) p = 64000;         
       }       
       else if(mouseX >= p3x1 && mouseX <= p3x2 && 
         mouseY >= p3y1 && mouseY <= p3y2 && mousePressed) {
         println("P-");
         p = p - 10;
         if(p < 0) p = 0;        
       }
       else if(mouseX >= p4x1 && mouseX <= p4x2 && 
               mouseY >= p4y1 && mouseY <= p4y2 && mousePressed) {

         println("P--");
         p = p - 1000;
         if(p < 0) p = 0;                  
       } 
       else if(mouseX >= dc1x1 && mouseX <= dc1x2 && 
         mouseY >= dc1y1 && mouseY <= dc1y2 && mousePressed) {
         println("DC+");
         dc = dc + 1;
         if(dc > 100) dc = 100;  
       }
       else if(mouseX >= dc2x1 && mouseX <= dc2x2 && 
               mouseY >= dc2y1 && mouseY <= dc2y2 && mousePressed) {

         println("DC++");
         dc = dc + 10;
         if(dc > 100) dc = 100;         
       }       
       else if(mouseX >= dc3x1 && mouseX <= dc3x2 && 
         mouseY >= dc3y1 && mouseY <= dc3y2 && mousePressed) {
         println("DC-");
         dc = dc - 1;
         if(dc < 0) dc = 0;        
       }
       else if(mouseX >= dc4x1 && mouseX <= dc4x2 && 
               mouseY >= dc4y1 && mouseY <= dc4y2 && mousePressed) {

         println("DC--");
         dc = dc - 10;
         if(dc < 0) dc = 0;                  
       }  
 
       if(pp != p) {
         r.pwmPeriod(parent.getPin(), p);            
       } 
       if(pdc != dc) {
         int edc = 0xFF / 100 * dc;
         r.pwmDuty(parent.getPin(), edc);            
       } 
            
    }
    catch(Exception e) {
      println("ERROR: " + e.getMessage());
    }     
  }
}

