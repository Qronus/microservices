Assignment
================

* Course Title: __Distributed Systems Programming__
* Course Code: **DSP620S**
* Assessment: Third Assignment
* Released on: 18/12/2020
* Due Date: 31/01/2021

# Problem


The [Faculty of Computing and Informatics](http://fci.nust.na/) (FCI) at [NUST](http://www.nust.na) has embarked upon a software development project to manage the __postgraduate programme__ process, including *application*, *proposal*, *thesis* and  *examination* management. The diagram below captures the main stages of the process.
![screen capture](../images/postgraduate-process.png)


We further elicit the requirements as follows. 
The different users of the System are the *students*, *supervisors*, *Head of Department* (HOD), *Faculty Internal Examiner* (FIE) and *Higher Degree Committee* (HDC).
 Any External Supervisor (or External Examiner) is not included in the System, because their regular communication will solely be with the NUST supervisor (or the HoD).
 The *Dean* and HOD will have an overview of all the information concerning students in the whole process.

At the application stage, a student starts the process by completing and submitting an application form, which is stored in the system. 
Thereafter, a supervisor based on his/her profile (skills, specialism, interests, workload) can browse the applications and express his/her interests.
 The HOD then compiles the augmented list (applications and supervisor interests).
 The applicants whose application received interest will be invited for an interview. 
Subsequent deliberations among panel members will decide on the acceptance or not of each application and the outcome communicated to the candidate.

The first milestone for a student who recently enrolled in a postgraduate programme is to successfully present his/her proposal (within the prescribed period). 
Once the draft of the proposal is ready and approved by the supervisor, the student will upload the proposal to the system. 
The HOD can then view the proposal and assign FIEs for its evaluation. A proposal that has been sanctioned by all FIEs is ready for submission to HDC. 
The faculty HDC representative can view the proposal or upload the resolution from HDC after evaluation by the committee.
 When HDC approves a proposal, the HOD will change the student status with the mention *final admission*.
 For proposals that have not been approved by HDC, the submission to HDC sub-process will be repeated until approval.

A student whose proposal has been approved enters the *thesis* stage.
 While the actual research is being conducted, the student will register at the beginning of each semester and submit regular reports attesting to her progress.

When the (research) work is completed and the draft of the thesis ready (with the approval of the supervisor), the student will upload the thesis to the system. 
The HOD will then send the thesis to the *appointed* external examiner(s) and await their assessment.
 When the examiner assessment is received, he/she will upload it into the system. When the thesis handling is completed, the results are compiled and submitted to HDC for its endorsement.
 At the end of the process, a successful student's status will change to *graduate*. 
For cases with minor changes, they must be effected to the satisfaction of an appointed member of the Faculty.
 Finally, for cases that require an extended amount of work, the necessary steps should be taken and the thesis resubmitted.



Your task is to:
1. design this application following a micro-service architectural style (You will provide a motivation for your problem decomposition into services);
2. design and implement an API gateway using graphql as your API query language;
3. deploy and configure Kafka as a middleware for all communication in the system (services and API gateway);
4. deploy the services using containerisation and orchestration (Docker and Kubernetes).
