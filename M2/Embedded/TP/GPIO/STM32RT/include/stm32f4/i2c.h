/**
 *	I2C support
 *	Copyright (C) 2024  Université de Toulouse <hugues.casse@irit.fr>
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 */

#ifndef STM32F4_I2C_H
#define STM32F4_I2C_H

#include "io.h"

#define I2C1_BASE	0x40005400
#define I2C2_BASE	0x40005800
#define I2C3_BASE	0x40005C00

// registers
#define I2C_CR1(b)		_IOREG(b, 0x00)
#define I2C_CR2(b)		_IOREG(b, 0x04)
#define I2C_OAR1(b)		_IOREG(b, 0x08)
#define I2C_OAR2(b)		_IOREG(b, 0x0C)
#define I2C_DR(b)		_IOREG(b, 0x10)
#define I2C_SR1(b)		_IOREG(b, 0x14)
#define I2C_SR2(b)		_IOREG(b, 0x18)
#define I2C_CCR(b)		_IOREG(b, 0x1C)
#define I2C_TRISE(b)	_IOREG(b, 0x20)
#define I2C_FLTR(b)		_IOREG(b, 0x24)

#define I2C1_CR1	I2C_CR1(I2C1_BASE)
#define I2C1_CR2	I2C_CR2(I2C1_BASE)
#define I2C1_OAR1	I2C_OAR1(I2C1_BASE)
#define I2C1_OAR2	I2C_OAR2(I2C1_BASE)
#define I2C1_DR		I2C_DR(I2C1_BASE)
#define I2C1_SR1	I2C_SR1(I2C1_BASE)
#define I2C1_SR2	I2C_SR2(I2C1_BASE)
#define I2C1_CCR	I2C_CCR(I2C1_BASE)
#define I2C1_TRISE	I2C_TRISE(I2C1_BASE)
#define I2C1_FLTR	I2C_FLTR(I2C1_BASE)

#define I2C2_CR1	I2C_CR1(I2C2_BASE)
#define I2C2_CR2	I2C_CR2(I2C2_BASE)
#define I2C2_OAR1	I2C_OAR1(I2C2_BASE)
#define I2C2_OAR2	I2C_OAR2(I2C2_BASE)
#define I2C2_DR		I2C_DR(I2C2_BASE)
#define I2C2_SR1	I2C_SR1(I2C2_BASE)
#define I2C2_SR2	I2C_SR2(I2C2_BASE)
#define I2C2_CCR	I2C_CCR(I2C2_BASE)
#define I2C2_TRISE	I2C_TRISE(I2C2_BASE)
#define I2C2_FLTR	I2C_FLTR(I2C2_BASE)

#define I2C3_CR1	I2C_CR1(I2C3_BASE)
#define I2C3_CR2	I2C_CR2(I2C3_BASE)
#define I2C3_OAR1	I2C_OAR1(I2C3_BASE)
#define I2C3_OAR2	I2C_OAR2(I2C3_BASE)
#define I2C3_DR		I2C_DR(I2C3_BASE)
#define I2C3_SR1	I2C_SR1(I2C3_BASE)
#define I2C3_SR2	I2C_SR2(I2C3_BASE)
#define I2C3_CCR	I2C_CCR(I2C3_BASE)
#define I2C3_TRISE	I2C_TRISE(I2C3_BASE)
#define I2C3_FLTR	I2C_FLTR(I2C3_BASE)

// CR1
#define I2C_PE		(1 << 0)
#define I2C_START	(1 << 8)
#define I2C_STOP	(1 << 9)
#define I2C_ACK		(1 << 10)
#define I2C_SWRST	(1 << 15)

// SR1
#define I2C_SB		(1 << 0)
#define I2C_ADDR	(1 << 1)
#define I2C_BTF		(1 << 2)
#define I2C_aDD10	(1 << 3)
#define I2C_STOPF	(1 << 4)
#define I2C_RxNE	(1 << 6)
#define I2C_TxE		(1 << 7)
#define I2C_BERR	(1 << 8)
#define I2C_ARLO	(1 << 9)
#define I2C_AF		(1 << 10)
#define I2C_OVR		(1 << 11)
#define I2C_PECERR	(1 << 12)
#define I2C_TIMEOUT	(1 << 14)
#define I2C_SMBALERT	(1 << 15)

// SR2
#define I2C_MSL		(1 << 0)
#define I2C_BUSY	(1 << 1)
#define I2C_TRA		(1 << 2)
#define I2C_GENCALL	(1 << 4)
#define I2C_SMBDEFAULT	(1 << 5)
#define I2C_SMBHOST	(1 << 6)
#define I2C_DIALF	(1 << 7)
#define I2C_PEC(n)	((n) << 8)

// CCR
#define I2C_FREQ(n)	((n) << 0)
#define I2C_DUTY	(1 << 14)
#define I2C_FS		(1 << 15)

#endif	// STM32F4_I2C_H
