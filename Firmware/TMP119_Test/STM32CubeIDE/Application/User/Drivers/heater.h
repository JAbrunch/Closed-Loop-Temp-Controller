/*
 * heater.h
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#ifndef APPLICATION_USER_DRIVERS_HEATER_H_
#define APPLICATION_USER_DRIVERS_HEATER_H_

#include "stm32f4xx_hal.h"

void Heater_SetDuty(TIM_HandleTypeDef *htim, uint32_t channel, float duty);

#endif /* APPLICATION_USER_DRIVERS_HEATER_H_ */
