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

* *name:* Ziqiang "Joe" Zhu
* *email:* ziqzhu@ucdavis.edu

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
The implementation perfectly fulfilled requirements of stage 1. Camera is always centered on the player.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The implementation perfectly fulfilled requirements of stage 2. I believe the player should not be able to push the camera box, but the camera box is allowed to push the player. I have the same understanding of the requirements for this stage and thus same end result for implementation.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The implementation perfectly fulfilled requirements of stage 3. The camera box is always catching up to the player. The camera falls behind and have a max leash distance impelmented.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The implementation perfectly fulfilled requirements of stage 4. The camera box is always reacts to the direction of input. Also it will catch up to the player with a delay when the player stoped moving.
___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The implementation perfectly fulfilled requirements of stage 5. The camera is not moving when player is in the inner box. The camera moves with a factor when player is in between inner and outer box. The camera moves as a push box when player is in the outer box.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

Student have consistent format for the code, and detailed comments above almost each line. However, there is this [line](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L55) where the comment is at the end instead of at the top like all the other comments.

The extra space inbetween `push_ratio	* delta` on [line](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/speedup_push_box.gd#L68)

#### Style Guide Exemplars ####
* [Short and clean](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L55)
___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
* should avoid copy pasting [comments](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L35)
* could use a seprate function for [this](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/speedup_push_box.gd#L73), it is too long and too much repeated code.

#### Best Practices Exemplars ####
* good descriptive [name](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/autoscroller.gd#L29)
* good [comment](https://github.com/ensemble-ai/exercise-2-camera-control-cqdowning/blob/322ec6d064ae003b9b93aed034ad6e4a4ca1fb49/Obscura/scripts/camera_controllers/autoscroller.gd#L41)