/*
 * controller.h
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#ifndef APPLICATION_USER_DRIVERS_CONTROLLER_H_
#define APPLICATION_USER_DRIVERS_CONTROLLER_H_

typedef struct
{
    float Kp;
    float Ki;
    float dt;
    float integral;
} PI_Controller;

void PI_Controller_Init(PI_Controller *controller, float Kp, float Ki, float dt);

float PI_Controller_Update(PI_Controller *controller, float setpoint, float temperature_c);

#endif /* APPLICATION_USER_DRIVERS_CONTROLLER_H_ */
