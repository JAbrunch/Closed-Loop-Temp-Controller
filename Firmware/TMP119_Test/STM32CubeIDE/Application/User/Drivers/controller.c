/*
 * controller.c
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#include "controller.h"

void PI_Controller_Init(PI_Controller *controller,
						float Kp,
						float Ki,
						float dt)
{
	controller->Kp = Kp;
	controller->Ki = Ki;
	controller->dt = dt;
	controller->integral = 0.0f;
}

float PI_Controller_Update(PI_Controller *controller,
						   float setpoint,
						   float temperature_c)
{
	float error = 0.0f;
	float P_term = 0.0f;
	float I_term = 0.0f;
	float output = 0.0f;

	error = setpoint - temperature_c;

	P_term = controller->Kp * error;

	/*
	 * Prevent integral windup while the proportional contribution alone
	 * exceeds the heater's maximum available duty cycle.
	 */
	if (P_term < 100.0f)
		controller->integral = controller->integral + error * controller->dt;

	I_term = controller->Ki * controller->integral;

	output = P_term + I_term;

    /* Constrain the controller command to the heater's valid duty range. */
	if (output > 100.0f)
	    output = 100.0f;

	if (output < 0.0f)
	    output = 0.0f;

	return output;
}
