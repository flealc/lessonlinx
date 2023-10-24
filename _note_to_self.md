Changed models

Change the lesson views to accomodate for the datetime field and duration only
change the actions in the controller to manipulate data appropriately and separate that logic into a concern so the controller
stays lean.  -->

Followed GPT advice to lean up and it works, notice some callbacks were in the lesson model as opposed to the controller. Now fix the time being displayed wrong. in the wrong timezone? No need to change it to the user timezone first sine that's how it comes in the params, you need to save it in utc
