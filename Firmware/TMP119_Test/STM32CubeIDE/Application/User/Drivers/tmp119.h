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

/**
 * @brief Reads the current temperature from the TMP119 sensor.
 *
 * Reads the TMP119 temperature register over I2C and converts the
 * signed raw measurement to degrees Celsius.
 *
 * @param hi2c Pointer to the HAL I2C peripheral handle.
 * @param temperature Pointer to the variable that receives the
 *                    measured temperature in degrees Celsius.
 *
 * @return HAL_OK if the sensor read succeeds, otherwise the HAL
 *         error status returned by the I2C transaction.
 */
HAL_StatusTypeDef TMP119_ReadTemperature(I2C_HandleTypeDef *hi2c, float *temperature_c);

#endif /* APPLICATION_USER_DRIVERS_TMP119_H_ */
