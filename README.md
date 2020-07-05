Hi! This is my Calendar App. 

App screen recording link:
https://drive.google.com/file/d/1d4miBR0MtDMlwqO7slhKdU9HSc1euZzb/view?usp=sharing

Summary:
This is the app I began working on at the beginning of the year. This allows the user to add some personalisation to their experience, in the form of an avatar and a name.  View the calendar. Log events coming up on the calendar, choosing timing, a title and whether or not this is an important event (as shown by the use of an exclamation mark vs a green tick). Persistent storage is achieved through the use of Core Data, this was my first real exploration of the SDK, which worked out fantastic. The events, if the user chooses to, will sync with the Apple Calendar app. 

Achievements:
This is a good work in progress, it has the beginnings of a clean aesthetic and a friendly user interface.  I have created a calendar from scratch and a logical data structure for it using reusable code, and not relied on any third party SDKs. So I am proud of this app and think it is a good achievement for something made in my spare time. 

Improvements:
Unit testing still needs to be added, as there is a lot of logic working with dates this is important and is my next thing to work on. Commenting/documentation needs to be added. I think that the DateManager class would benefit greatly from being refactored to use generics, as a lot of the code is similar, there are some differences but these could be ironed out. I also have not added in a settings page, where I can allow for UI optimisations such as colouring; as realistically that is the main appeal of this over the Apple calendar. Finally I will add in some form of push notifcations to remind users about the calendar events, though currently this will happen anyway through the Apple Calendar if the user decides on this.
