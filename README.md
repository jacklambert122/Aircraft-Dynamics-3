# Aircraft Dynamics 3

# Purpose:
Create a linearized model to simplify equations of motion for a Rolling Spider quad-copter. The assumption is that higher order terms will have inherently lower associated error terms. This linearized model will then be compared to the non-linearized model about varying deviations to the quad-copters state and simulated using a numerical ordinary differential equation solver in MATLAB. The linearized model will then be used to calculate the derivative control gain and this gain will be inputted into the quad-copters control loop to see how these gains improve the copter's stability. 
<br /><br />

# Question 1: Linearized Model about a Steady Hover Trim State:

<p align="center">
  <img src="./Images/Aircrafthw3Page1.jpg" />
</p>

<p align="center">
  <img src="./Images/Aircrafthw3Page2.jpg" />
</p>

<p align="center">
  <img src="./Images/Aircrafthw3Page3.jpg" />
</p>
<p align="center">
  <img src="./Images/Aircrafthw3Page4.jpg" />
</p>

<br /><br />

# Questions 2 & 3: Non-Linear Model Vs. Linear Model:

## Part a.) Deviation of +5 $^{\circ}$ Bank:
<img src="./Images/LvsNLcase1.jpg" width="49%" />
<img src="./Images/Bankvs_T.jpg" width="49%"/>
<br /> <br />

## Part b.) Deviation of +5 $^{\circ}$ Pitch:
<img src="./Images/LvsNLcase2.jpg" width="49%"/>
<img src="./Images/Thetavs_T.jpg" width="49%"/>
<br /> <br />

## Part c.) Deviation of +5 $^{\circ}$ Azimuth:
<img class="two-images" src="./Images/LvsNLcase3.jpg" alt=""/>
<img class="two-images" src="./Images/PsivsT.jpg" alt=""/>
<br /> <br />

## Part d.) Deviation of $+ 0.1 \frac{rad}{s}$ Roll Rate:
<img class="two-images" src="./Images/LvsNLcase4.jpg" alt=""/>
<img class="two-images" src="./Images/RollRateVsTComp.jpg" alt=""/>
<img class="one-image-50p" src="./Images/Bankvs_TCase4.jpg" alt=""/>

<br /> <br />

## Part e.) Deviation of $+ 0.1 \frac{rad}{s}$ Pitch Rate:
<img class="two-images" src="./Images/LvsNLcase5.jpg" alt=""/>
<img class="two-images" src="./Images/PRvsTComp.jpg" alt=""/>
<img class="one-image-50p" src="./Images/PitchvsTCase5.jpg" alt=""/>
<br /> <br />

## Part f.) Deviation of $+ 0.1 \frac{rad}{s}$ Yaw Rate:
<img class="two-images" src="./Images/LvsNLcase6.jpg" alt=""/>
<img class="two-images" src="./Images/YawVsTimeComp.jpg" alt=""/>
<img class="one-image-50p" src="./Images/AzimuthvsTcase6.jpg" alt=""/>
<br /> <br />

## Question 2 Analysis:

After analyzing the plots, the results make sense. The quad copter did not change its position with changes in azimuth or yaw rate, which is what is expected as the copter is in steady hovering flight. Since the body is hovering- the body's z-axis is perpendicular to the ground (the inertial x-y plane). This means that changes in the azimuth and yaw rate only change the attitude and not its position since the forces from both gravity and the motors act in the z axis, where the z-axis doesn't not change orientation. Changes in the pitch rate, roll rate, Bank angle, and Pitch angle, however, do change the orientation of the z-axis. This gives the motors forces acting in the z-axis of the body components in the x and y inertial directions. Where the copter was in steady flight before, this change causes a force in balance as the force of the motors now only has components opposing gravity. With a smaller force acting to oppose gravity the copter descends in the positive D-direction with motion in the - N direction for positive changes in pitch and pitch rate and in the positive E-direction for positive changes in roll rate and bank. This shows how even small perturbations change the condition of the copter in steady hover, meaning a hovering state is unstable.
<br /> <br />

## Question 3 Analysis:
When comparing variations in parameters of the linear model to the non-linear model the similarities are strikingly similar. For all translational cases the trajectories mirrored closely for linear and non-linear models. The variations in the bank, pitch, and azimuth were seen to be nearly identical for all cases. Lastly the angular rates were also nearly identical. The variations seem extreme on the graphs, however this is only due to the scale being in the thousandths of radians per second. Showing there there are small differences, however the linear model is accurate especially for the small deviations that we implemented for our analysis.
<br /> <br />

# Feedback Control:

## Deviation of $+ 0.1 \frac{rad}{s}$ Roll Rate:
<div width="49%" margin-right="5px" display="inline-flex">
<img class="two-images" src="./Images/DistvsRoll.jpg" alt=""/>
<img class="two-images" src="./Images/BankvsT.jpg" alt=""/>

<div width="49%" display="block" margin-left="auto" margin-right="auto" max-width="100%">
<img class="one-image-50p" src="./Images/RollRatevsT.jpg" alt=""/>
<br /> <br />

## Deviation of $+ 0.1 \frac{rad}{s}$ Pitch Rate:
<div width="49%" margin-right="5px" display="inline-flex">
<img class="two-images" src="./Images/distvsPitch.jpg" alt=""/>
<img class="two-images" src="./Images/PitchvsT.jpg" alt=""/>

<div width="49%" display="block" margin-left="auto" margin-right="auto" max-width="100%">
<img class="one-image-50p" src="./Images/PitchRatevT.jpg" alt=""/>
<br /> <br />

## Deviation of $+ 0.1 \frac{rad}{s}$ Yaw Rate:
<div width="49%" margin-right="5px" display="inline-flex">
<img class="two-images" src="./Images/AC_3_3_f.jpg" alt=""/>
<img class="two-images" src="./Images/AzimuthvsT.jpg" alt=""/>

<div width="49%" display="block" margin-left="auto" margin-right="auto" max-width="100%">
<img class="one-image-50p" src="./Images/YawRatevsT.jpg" alt=""/>
<br /> <br />

When a feedback control is implemented on the rotational rates, the trajectory of the cases with deviations in their initial roll and pitch rates reduces drastically. The feedback controls the rate at which the copter rotates, slowing the roll rate to zero in less than 0.2 seconds. This in turn had an effect of correcting the path of the copter so that it changes position much less. For the case where the yaw rate was changed, the copter still did not displace any distance as it stays fixed about its z-axis in body coordinates. The plots of the yaw rate and azimuth as a function of time shows how the control stops its rotation about this body fixed z axis, even though it has no effect on position it still had an effect on the attitude of the copter.
<br /> <br />

## Rotational Motion Comparison:

<div float="left" width="49%" >
<img width="98%" src="./Images/ACHW3Drone1.jpg" alt="" />
<p text-align="center"> With Control Feedback </p>
</div>

<div class=float="left" width="49%" >
<img width="98%" src="./Images/AircraftRotation.jpg" alt="" />
<p text-align="center"> Without Control Feedback </p>
</div>

<div style="clear:left;"></div>

<br /> 
<br />

## Translational Motion Comparison:

<div class=float="left" width="49%" >
<img width="98%" src="./Images/ACHW3Drone2.jpg" alt="" />
<p text-align="center"> With Control Feedback </p>
</div>

<div class=float="left" width="49%" >
<img width="98%" src="./Images/AircraftTranslation.jpg" alt="" />
<p > Without Control Feedback </p>
</div>

<div style="clear:left;"></div>

<br />

As can be seen from the data the rolling spider's flight lasted much longer after the control law was turned off and the derivative control law was turned on. The effect of having the variations in roll rate, pitch rate, and yaw rate controlled by a feedback showed to keep the angular position and angular rates under control for much longer, as the flight time is seen to last near 13 seconds in comparison to the case that did not have the feedback control lasting roughly 8 seconds. It can also be seen that after the complete control law was turned off the derivative control's inputs actually caused the attitude to 'teeter' back and forth for a moment, improving the stability and thus the time of flight. The feedback control did help with longer flight, however, was limited as the it only corrects changes in rates while proportional control is needed to control changes in positions and attitude (directly at least).  