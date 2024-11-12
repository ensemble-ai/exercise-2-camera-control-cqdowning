# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Alex Do
* *email:* atdo@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera controller is always centered on the vessel, successfully fulfilling the Stage 1 requirements. The crosshair’s position is locked onto the vessel’s location. The student's controller had a 5 by 5 unit cross in the center of the screen when the 'F' key was clicked.
___
### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
This stage looks great, however, I believe there is a logic error in the student’s implementation. First, the student successfully implemented the world/background to have it constantly moving in the z-x plane, and the player being allowed to move freely within the frame border box. However, the student did not correctly implement the player's constant movement in the z-x plane so that if the player lags behind and touches the left edge of the box, the player should be pushed forward by that box edge. Lastly, the student's controller showed the frame border box when the 'F' key was clicked. 
___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Here, the student executed this stage flawlessly. The camera controller doesn’t immediately center on the player as they move, but rather, it approaches the player’s position at a slower speed. Once the player stops moving, the camera catches up to the player smoothly. The student also successfully implemented the leash, ensuring the distance between the vessel and the camera never exceeds 13.0 units. Additionally, they used lerp effectively to make the movement smoother. Lastly, the student's controller had a 5 by 5 unit cross in the center of the screen when the 'F' key was clicked. Overall, the student accomplished a flawless Stage 3.
___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Similar to Stage 3, the student flawlessly completed Stage 4. They successfully implemented functionality where the center of the camera leads the player in the direction of the player's input. The position of the camera smoothly approaches the player’s position when the player stops moving. In this stage, the distance between the camera and target should increase, ensuring the distance between the vessel and the camera never exceeds 13.0 units. The camera only settles on the player has stopped moving and until the catch-up delay duration (6) is over. Lastly, the student's controller had a 5 by 5 unit cross in the center of the screen when the 'F' key was clicked. Overall, the student successfully and flawlessly completed Stage 4.
___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The student flawlessly implemented a 4-directional speedup push zone. The controller successfully draws the push zone border box when the 'F' key is pressed. When the player is within the innermost box, the camera remains still. However, when the player enters the outer pushbox zone, the controller moves at the speed of the player multiplied by the push ratio of 0.5. When the player pushes against the outermost borders, the camera moves at the player’s current speed in the direction of the touched border. Overall the students implementation for this stage was flawless. 

I also wanted to give the student credit for an excellent job with visual enhancements that rounded the game's appearance. They created a rounded, Earth-like world/background effect. The student also added a day-night cycle where the environment smoothly transitions between light and dark, further enhancing the visual experience. I can tell that the student spent a lot of time and effort on this exercise, and I think it is truly amazing what they accomplished.

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.

#### Style Guide Infractions ####
For the most part, the student did well to ensure they stayed within the style guidelines. However, when reviewing their code, the only infraction I noticed was the student's violation of the 100-character guideline. As shown in these permalinks:

- [Violation within push_box.gd](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/push_box.gd#L77)
- [Violation within lerp_target_focus.gd](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L55) - This one specifically was really long, and on top of that, the student added a comment to the end of this line of code, thus making it longer. The student should have at least put the comment on a new line, and for every violation of the 100-character guideline, the programmer should wrap the line.

There were quite a few infractions of over 100 characters, but other than that, the student did well in following the other style guidelines.

#### Style Guide Exemplars ####
What I noticed the student did well was the spacing when using operators, as seen in these permalinks:

- [Excellent spacing](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/autoscroller.gd#L55)

By following this style convention and adding spaces around the operators, the readability of the code is much improved.

___
#### Put style guide infractures ####
[Followed the GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#)
___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
From what I've seen when reviewing the student's code, I was unable to find any infractions of best practices. The student did really well to ensure that comments, variable names, classes, etc., align with the best practices guidelines. This leads me to believe that the student is an experienced programmer and has developed these good practices as habits.

#### Best Practices Exemplars ####
- [Variable names](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L21C5-L21C25) - The student also did a good job naming their variables. Their names were clear and descripting which, again, is good pracitce to making their code are easilyt readable and mainatblaes.

- The student did really well commentin their code and providing clear explanantion and justification for why and what their code are doing. This made it really wasy to undetand and is a great pracitce for maintating readability and ensuring others can follow their code with ease.
  
- The student also made a lot of commits to their repo, which is a great practice to help with version control, keeping track of progress, and allowing for easy debugging. 
