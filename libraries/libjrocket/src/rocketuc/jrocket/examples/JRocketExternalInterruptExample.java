/* 
 * This file is part of the ROCKETuC firmware project
 *
 * Copyright (C) 2012 Stefan Wendler <sw@kaltpost.de>
 *
 * The ROCKETuC firmware is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * ROCKETuC firmware is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with the ROCKETuC firmware; if not, write to the Free
 * Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA.  
 */

package rocketuc.jrocket.examples;

import rocketuc.jrocket.JRocket;
import rocketuc.jrocket.JRocketSerial;
import rocketuc.jrocket.comm.Packet;

public class JRocketExternalInterruptExample extends JRocketSerial{

	public JRocketExternalInterruptExample(String port) throws Exception {
		super(port);
	}

	@Override
	public void handleEvent(Packet pkt) {
		System.out.println("-> Button pressed event on pin: " + Integer.toHexString(pkt.getData()[0]));
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		try {		
			JRocket jr = new JRocketExternalInterruptExample("/dev/ttyUSB0");

 			System.out.print("Set P1.3 to INPUT FLOAT: ");
			jr.pinMode(JRocket.PIN_1_3, JRocket.INPUT);
			System.out.println("OK");

 			System.out.print("Set P2.3 to INPUT PULLDOWN: ");
			jr.pinMode(JRocket.PIN_2_3, JRocket.PULLDOWN);
			System.out.println("OK");
			
			System.out.print("Set P2.4 to INPUT PULLUP: ");
			jr.pinMode(JRocket.PIN_2_4, JRocket.PULLUP);
			System.out.println("OK");
			
 			System.out.print("Enable EXTI on HIGH-LOW transition for P1.3: ");
			jr.externalInterrupt(JRocket.PIN_1_3, JRocket.EDGE_HIGHLOW);
			System.out.println("OK");

 			System.out.print("Enable EXTI on LOW-HIGH transition for P2.3: ");
			jr.externalInterrupt(JRocket.PIN_2_3, JRocket.EDGE_LOWHIGH);
			System.out.println("OK");

 			System.out.print("Enable EXTI on HIGH-LOW transition for P2.4: ");
			jr.externalInterrupt(JRocket.PIN_2_4, JRocket.EDGE_HIGHLOW);
			System.out.println("OK");
			
			System.out.println("PRESS BUTTON on Launchpad to get INTERRUPT");
			System.out.println("PRESS ANY KEY to QUIT PROGRAMM");
			System.in.read();
			
			System.out.print("RESET: ");
			jr.reset();
			System.out.println("OK");
			
			jr.finalize();
			
			System.out.println("DONE");
			
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}			
	}
}
