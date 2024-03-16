# stroll_task

A new Flutter project.

Flutter 3.16.0 • channel [user-branch] • unknown source
Framework • revision db7ef5bf9f (4 months ago) • 2023-11-15 11:25:44 -0800
Engine • revision 74d16627b9
Tools • Dart 3.2.0 • DevTools 2.28.2


Steps to run the project:

1. After running flutter pub get, go to Edit Configuration and make the dart entry file points to lib/main_dev.dart


Task 3 scoping

1. The video is loaded when you launch the task 1 screen which will cache the first 2 seconds of the video. I believe this is enough for now.
2. Caching is not done for entire video. Every time you launch the task 3 screen, it will stream from network url.
3. The video is center aligned when you first launch the task 3 screen. Then you can start panning the video.
4. The UI is not exactly matching the app UI. But it be designed any time later.
5. Placement of profile pictures would have been improved. Since I'm not sure about the number of profile you view on this task 3 screen, I kept it at 20.
6. If task 3 screen, can have n users, then the logic of placement should be optimized or tested again.
7. While the app goes to background, the video will be paused so that the memory will never be wasted or leaked.
8. The video sound will be muted, when it goes background.
9. Tested the memory and performance. I didn't see huge set backs over there. But still I can see some few drops. But not laggy.
10. The maximum video size that I have tested is 3840x2160 which is around 56MB.
11. The minimum video size that I have tested is 1280x720 which is a remote video. The url is commented out in the code.
12. When any phone calls received, the video will pause and then resume automatically.
13. I have added additional option to zoom the video in and out. It can be disabled it if required.

Limitations:

1. Have to find better place to dispose the video controller. Since I'm unaware of the entire workflow, I disposed it while cosing task 1 screen.
2. Have to test with higher resolution videos. I tested with 1280 x 720 video.
3. Have to think about placement of profile pictures if video is failed to load.
4. Would be great if we know the aspect ratio or video width and height before navigating to task 3 screen, so that we don't need to depend on video controller.
5. Yet to test with multiple videos playing simultaneously.