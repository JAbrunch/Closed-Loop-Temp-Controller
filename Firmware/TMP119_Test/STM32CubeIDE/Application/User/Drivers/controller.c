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

	error = setpoint - temperature_c;

	P_term = controller->Kp * error;

	if (P_term < 100.0f)
		controller->integral = controller->integral + error * controller->dt;

	I_term = controller->Ki * controller->integral;

	return P_term + I_term;

}
