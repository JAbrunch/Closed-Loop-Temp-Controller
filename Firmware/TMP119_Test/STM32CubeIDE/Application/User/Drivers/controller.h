/*
 * controller.h
 *
 *  Created on: Aug 30, 2026
 *      Author: final
 */

#ifndef APPLICATION_USER_DRIVERS_CONTROLLER_H_
#define APPLICATION_USER_DRIVERS_CONTROLLER_H_


/**
 * @brief State and configuration for a discrete-time PI controller.
 *
 * Kp and Ki define the proportional and integral gains, dt defines the
 * controller update period in seconds, and integral stores the accumulated
 * error between updates.
 */
typedef struct
{
    float Kp;
    float Ki;
    float dt;
    float integral;
} PI_Controller;


/**
 * @brief Initializes a PI controller instance.
 *
 * @param controller Pointer to the controller instance.
 * @param Kp Proportional gain.
 * @param Ki Integral gain.
 * @param dt Controller update period in seconds.
 */
void PI_Controller_Init(PI_Controller *controller, float Kp, float Ki, float dt);


/**
 * @brief Executes one PI control update.
 *
 * Calculates the temperature error, updates the integral state, and
 * returns a heater duty-cycle command.
 *
 * @param controller Pointer to the controller instance.
 * @param setpoint Desired temperature in degrees Celsius.
 * @param temperature_c Measured temperature in degrees Celsius.
 *
 * @return Heater duty-cycle command constrained to 0-100 percent.
 */
float PI_Controller_Update(PI_Controller *controller, float setpoint, float temperature_c);

#endif /* APPLICATION_USER_DRIVERS_CONTROLLER_H_ */
