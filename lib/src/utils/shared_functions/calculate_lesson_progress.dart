


int getLessonProgress(int lessonDuration, int lessonLastPlayedDuration){
  double calculatedProgress = (lessonLastPlayedDuration / lessonDuration) * 100;
  int roundedProgress = calculatedProgress.round();
  return roundedProgress;
}