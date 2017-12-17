# Digital PT

Digital PT is a personal trainer app that was developed by

* [Isabelle Gaboc](https://github.com/igaboc/)
* [Chisten Garcia](https://github.com/christengarcia/)
* [Chy Meng](https://github.com/chy24/)
* [Alex Palma](https://github.com/developingAlex/)

## Steps to run this program
1. You must have ruby installed on your system.
1. Download a copy of this repo to your computer.
1. In a terminal, `cd` to the directory containing the file named digitalpt.rb
1. Run `ruby digitalpt.rb`
1. Create a new user following the prompts
1. Login with the credentials you just made and workout!

## Problem

People sign up to gyms to assist in reaching their fitness goals, which is usually to bodybuild, lose weight, or to keep in shape. 
However, after they join the gym, people can be overwhelmed with the equipment, struggle with knowing what exercises to do, knowing the frequency of the exercise, and how to track their progress based on their goals. 
Personal trainers can assist with this problem, however they can be costly. 

## Solution

Create a digital Ruby application that runs through the terminal, to safely guide users with no prior knowledge to reach their fitness goals. The application would act as a digital personal trainer that would: 
* Suggest exercises to the users based on capability, location and goals.
* Keep track of progress based on exercise type, duration, number of reps (if applicable), and kgs in weights (if applicable).
* Prompt users (via audio) to push themselves further in their exercises.
* Have the ability to visualize progress (i.e. in graphs).
* Take into account previous performance when suggesting exercises.
* Save its user money on having a physical personal trainer.

## Planning

This was the first group project for the developers just 3 weeks into their coding bootcamp course so the planning was a little crude.
The general idea of the layout of how the program would be made was brainstormed on a white board as well as determining the scope of the solution. 

![](/README-assets/whiteboard-planning.jpg)

Program logic , initial brainstorming:

![](/README-assets/flow-chart.png)

## Development

The program works by having a list of exercise types, what goals those exercises are suitable for, and a logical Personal Trainer (PT) component that determines which exercises to instruct the user to perform. The duration and weight the PT dictates is based initially on metadata held within the exercise object but then later is based on the user's performance.

### Tailoring advice to user performance

In the example of bodybuilding, there is a particular number of reps per exercise that is the most optimum. Assuming that number of reps is 5 reps, the program would take into account the amount of weight the user attempted to lift in their previous set in order to determine what weight they should lift in their next set.

So for example if the PT instructed the user to barbell squat 80kg and the user enters in afterwards that they achieved 17 reps, the PT would increase the weight (because the user has done much more than the target rep count of 5). If however the user inputs that they only could do 2 reps, the PT would then lessen the weight for the subsequent set in order to achieve the target of 5 reps.

### Variables that should be taken into account by the PT component

*Note that the following is all in the context of heavy weights / body building.*

When the PT component is dictating exercises for the user to perform it should take into account the following:

* How many reps has the user performed for the previous set, or if this is the first set with that exercise how did they do the last time they did that exercise (lookup user's past performance history)
* How long has the workout session lasted? The program should halt the session after a maximum duration cap so as to prevent over exhaustion of the user.
* What number set is this on a particular exercise. As a user progresses through the sets for a particular exercise they will progressively tire. This means the optimum number of reps for the final set will inherently be less than that of the first set.
* Exercises that involve multiple muscle groups (compound exercises) should be dispensed before more specialised muscle group targetting exercises for a more comprehensive workout session.

## Future enhancements

There is still much more that could be done with this program, some of the main points are:

* Finish the implementation of the finer details and bug fixes
* Have the ability to accommodate non-gym settings (i.e. exercises at home).
* Dietary suggestions based on the user's fitness goals.
* Partner with local gyms to tailor the suggested exercises to their equipment.
* Find your closest gyms using a map and identify the cheapest gym rates given your criteri (24/7 access, staffed or not, fitness goal etc.).