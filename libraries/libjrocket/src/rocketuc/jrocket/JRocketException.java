/* 
 * This file is part of the JRocket Library project
 *
 * Copyright (C) 2012 Stefan Wendler <sw@kaltpost.de>
 *
 * The JRocket Library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * JRocket Library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with the JRocket firmware; if not, write to the Free
 * Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA.  
 */

package rocketuc.jrocket;

/**
 * JRocket exception. 
 */
public class JRocketException extends Exception {

	/**
	 * Constructor which takes a message as input.
	 * 
	 * @param msg	message for this exception
	 */
	public JRocketException(String msg) {
		super(msg);
	}
	
	/**
	 * Constructor which takes nested exception as input.
	 * 
	 * @param e		nested exception
	 */
	public JRocketException(Exception e) {
		super(e);
	}

	/**
	 * Default serial UID
	 */
	private static final long serialVersionUID = 1L;
}
