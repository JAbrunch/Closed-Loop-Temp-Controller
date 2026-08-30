/*
 * heater.c
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#include "heater.h"

static uint32_t DutyToCCR(float duty){

	  if (duty >= 100.0f){
		  return 1000;
	  } else {
		  return (uint32_t)(duty * 1000.0f) / 100.0f;
	  }

  }

void Heater_SetDuty(TIM_HandleTypeDef *htim,
					uint32_t channel,
					float duty)
{

	uint32_t ccr = 0;

	if (duty > 100.0f)
		duty = 100.0f;
	if (duty < 0.0f)
		duty = 0.0f;

	ccr = DutyToCCR(duty);

	__HAL_TIM_SET_COMPARE(htim, channel, ccr);

}
