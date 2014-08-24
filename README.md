Coursera-Getting-and-Cleaning-Data-Course-Project
=================================================


As mentioned in several discussions regarding this Course Project, there has been some room for interpretation in the tasks, and that is why the steps in my script as well as my tidy data output may look different from those of my reviewers and from those which I will review.

In my script, I first add the activity and subject information (as two additional columns) to the training data, and then do the same for the test data.
Then I append the test data to the training data via the rbind function.

Next, I read the variable names from features.txt to use them as labels for the merged data.

With regard to filtering on only the mean and standard deviation variables, I have decided to use any which contain the substrings "mean" or "std".
This reduces the number of columns of the data.frame from 563 to 81.

Then I replace the activity IDs by the names, taken from the file activity_labels.txt.

Finally, I use the functions from the reshape2 and plyr packages, respectively, to melt the data and calculate the averages by activity and subject, and I write the tidy data out to a text file.
Since I calculate the average "only" by activity and subject, not by the variables, my tidy data contains 6 * 30 = 180 rows. 
This represents my understanding of the task.
