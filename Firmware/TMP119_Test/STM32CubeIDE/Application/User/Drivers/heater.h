/*
 * heater.h
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#ifndef APPLICATION_USER_DRIVERS_HEATER_H_
#define APPLICATION_USER_DRIVERS_HEATER_H_

#include "stm32f4xx_hal.h"

/**
 * @brief Sets the heater PWM duty cycle.
 *
 * @param htim Pointer to the HAL timer handle used for PWM generation.
 * @param channel Timer PWM channel connected to the heater MOSFET.
 * @param duty Requested duty cycle in percent. Values outside 0-100
 *             percent are constrained before being applied.
 */
void Heater_SetDuty(TIM_HandleTypeDef *htim, uint32_t channel, float duty);

#endif /* APPLICATION_USER_DRIVERS_HEATER_H_ */
