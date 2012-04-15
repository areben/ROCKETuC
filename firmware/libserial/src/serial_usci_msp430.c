/* 
 * This file is part of the ROCKETuC firmware project
 *
 * Copyright (C) 2011 Stefan Wendler <sw@kaltpost.de>
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

#include <msp430.h>
#include <legacymsp430.h>
#include <stdint.h>
#include <stdbool.h>

#include "serial.h"

/**
 * RXD pin
 */
#define UART_RXD   		BIT1		

/**
 * TXD pin
 */
#define UART_TXD   		BIT2	

void serial_init(unsigned int baudrate)
{
	P1SEL    |= UART_RXD + UART_TXD;                       
  	P1SEL2   |= UART_RXD + UART_TXD;                       
  	UCA0CTL1 |= UCSSEL_2;                   // SMCLK

	unsigned char br = (unsigned char)(1000000 / (long)baudrate);

  	UCA0BR0  = br;                          // 1MHz / baudrate 
  	UCA0BR1  = 0;                           // 
  	UCA0MCTL = UCBRS0;                      // Modulation UCBRSx = 1
  	UCA0CTL1 &= ~UCSWRST;                   // Initialize USCI state machine
}

void serial_send(unsigned char data)
{
  	UCA0TXBUF = data;                 		
}

void serial_send_blocking(unsigned char data)
{
	while (!(IFG2&UCA0TXIFG));              // USCI_A0 TX buffer ready?
  	UCA0TXBUF = data;                  
}

unsigned char serial_recv()
{
	return UCA0RXBUF;
}

unsigned char serial_recv_blocking()
{
    while (!(IFG2&UCA0RXIFG));         		// USCI_A0 RX buffer ready?
	return UCA0RXBUF;
}
