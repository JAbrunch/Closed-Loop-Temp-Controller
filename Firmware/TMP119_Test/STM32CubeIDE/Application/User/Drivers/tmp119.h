/*
 * tmp119.h
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#ifndef APPLICATION_USER_DRIVERS_TMP119_H_
#define APPLICATION_USER_DRIVERS_TMP119_H_

#include "stm32f4xx_hal.h"

#define TMP119_I2C_ADDR    0x48
#define TMP119_TEMP_REG    0x00
#define TMP119_CONFIG_REG  0x01

HAL_StatusTypeDef TMP119_ReadTemperature(I2C_HandleTypeDef *hi2c, float *temperature_c);

#endif /* APPLICATION_USER_DRIVERS_TMP119_H_ */
