import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:test_elearning/models/courses.dart';
import 'package:video_player/video_player.dart';

class Coursedetail extends StatefulWidget {
  @override
  _CoursedetailState createState() => _CoursedetailState();
}

class _CoursedetailState extends State<Coursedetail> {
  List<Courses> courselist = Courses.course;
  late Courses selectedCourse;
  int? selectedLessonIndex;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    selectedCourse = courselist[0]; // Default to first course
    // Initialize flickManager with the first lesson's video URL
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        selectedCourse.lessons[0].videoUrl,
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose(); // Dispose FlickManager to free resources
    super.dispose();
  }

  void updateVideo(int lessonIndex) {
    // Update video player when a new lesson is selected
    flickManager.dispose(); // Dispose the current video player
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        selectedCourse.lessons[lessonIndex].videoUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCourse.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Lessons List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: selectedCourse.lessons.length,
              itemBuilder: (context, index) {
                var lesson = selectedCourse.lessons[index];
                return ListTile(
                  title: Text(lesson.title),
                  trailing: Icon(
                    lesson.isDone ? Icons.check : Icons.radio_button_unchecked,
                    color: lesson.isDone ? Colors.green : Colors.grey,
                  ),
                  onTap: () {
                    setState(() {
                      selectedLessonIndex = index;
                    });
                    // Mark the lesson as done after tapping
                    setState(() {
                      lesson.isDone = true;
                      updateVideo(index); // Update video when a lesson is selected
                    });
                  },
                );
              },
            ),

            // Video Display
            if (selectedLessonIndex != null)
              Column(
                children: [
                  Text(
                    selectedCourse.lessons[selectedLessonIndex!].title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  // Display the video using FlickVideoPlayer
                  Container(
                    height: 250,
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
