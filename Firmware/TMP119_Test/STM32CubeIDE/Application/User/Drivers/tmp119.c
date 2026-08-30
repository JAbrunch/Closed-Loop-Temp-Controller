/*
 * tmp119.c
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#include "tmp119.h"

HAL_StatusTypeDef TMP119_ReadTemperature(I2C_HandleTypeDef *hi2c,
										float *temperature_c)
{

	HAL_StatusTypeDef status;
	uint8_t temp_data[2] = {0};
	int16_t raw_temp = 0;

	status = HAL_I2C_Mem_Read(
		      hi2c,
		      TMP119_I2C_ADDR << 1,
		      TMP119_TEMP_REG,
		      I2C_MEMADD_SIZE_8BIT,
		      temp_data,
		      2,
		      100
		  );

	if (status == HAL_OK) {

		raw_temp = (int16_t)(((uint16_t)temp_data[0] << 8) | temp_data[1]);
		*temperature_c = raw_temp * 0.0078125f;

	}

	return status;

}

