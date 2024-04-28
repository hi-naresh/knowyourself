
/// This class contains all the App Text in String formats.
class KTexts {
  // -- GLOBAL Texts
  static const String and = "and";
  static const String skip = "Skip";
  static const String done = "Done";
  static const String submit = "Submit";
  static const String appName = "Prodo";
  static const String Continue = "Continue";

  // 4 Aspects
  static const String mental= "Mental";
  static const String physical= "Physical";
  static const String vital="Vital";
  static const String spiritual="Spiritual";

  static const String mentalDescription = "Enhance cognition with reading, puzzles, and critical thinking.";
  static const String physicalDescription = "Promote fitness with yoga, sports, and outdoor activities.";
  static const String vitalDescription = "Optimize energy flow with deep breathing and meditation.";
  static const String spiritualDescription = "Nurture inner peace with meditation and self-reflection.";



  //Dashboard
  static const String feel = "How are you today?";
  static const String dailyMilestones ="Daily milestones";
  static const String myself = "Myself";
  static const String progress = "Progress";
  static const String recommend = "Recommended activities";
  static const String startYourDay = "Start your day with some motivation.";
  static const String daily = "Daily";
  static const String monthly = "Monthly";
  static const String yearly = "Yearly";

  //Insights
  static const String insightsHead = "Overall Insights";
  static const String insightSubtitle = "Check your daily progress and overall insights of you understanding yourself better.";


  static const String reflectSubtitle ="Write down your thoughts, feelings, and experiences. Make a habit of reflecting on your day.";
  static const String moodSubtitle = "View your mood history and we will try to recommend the best activities accordingly.";
  static const String milestoneSubtitle ="Track your progress with your tasks and goals for self-development.";
  static const String questionSubtitle ="Let's solve the life-changing questions together. We will remind and help you to answer them.";
  static const String storySubtitle ="Pen a letter to yourself and begin manifesting your journey. Let your story unfold to the world.";

  // Learn Screen
  static const String learnHead = "Learn about aspects";
  static const String learnHead2 = "Learned so far";
  static const String learnHead3 = "Articles";
  static const String learnAboutAspects = "Life skills and practices with our interactive modules.";
  static const String resourcesDescription = "Explore immersive videos, comprehensive guides, centers, wisdom of the Auro Society.";

  static const String userReviewDescription = "Capture best memories & favorite things. Reflect on joyful moments & share your journey.";

//gratitude screen
  static const String gratitudeHead = "Gratification";
  static const String gratitudeSubtext = "Give yourself credit for your strengths and accomplishments.";

  // -- Authentication Forms
  static const String fullname = "Full Name";
  static const String email = "E-Mail";
  static const String password = "Password";
  static const String confirmPassword = "Confirm Password";
  static const String passwordHint = "Enter your password";
  static const String newPassword = "New Password";
  static const String username = "Username";
  static const String usernameHint = "Enter your username";
  static const String rememberMe = "Remember Me";
  static const String forgetPassword = "Forget Password?";
  static const String signIn = "Sign In";
  static const String signInGoogle = "Google Sign In";
  static const String signUpGoogle = "Google Sign Up";

  static const String createAccount = "Create Account";
  static const String orSignInWith = "or sign in with";
  static const String orSignUpWith = "or sign up with";
  static const String iAgreeTo = "I agree to";
  static const String privacyPolicy = "Privacy Policy";
  static const String termsOfUse = "Terms of use";
  static const String resendEmail = "Resend Email";
  static const String resendEmailIn = "Resend email in";


  // -- Authentication Headings
  static const String loginTitle = "Welcome back,";
  static const String loginSubTitle = "Discover Limitless Choices and Unmatched Convenience.";
  static const String signupTitle = "Let’s create your account";
  static const String forgetPasswordTitle = "Forget password";
  static const String forgetPasswordSubTitle = "Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.";
  static const String changeYourPasswordTitle = "Password Reset Email Sent";
  static const String changeYourPasswordSubTitle = "Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.";
  static const String confirmEmail = "Verify your email address!";
  static const String confirmEmailSubTitle = "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.";
  static const String emailNotReceivedMessage = "Didn’t get the email? Check your junk/spam or resend it.";
  static const String yourAccountCreatedTitle = "Your account successfully created!";
  static const String yourAccountCreatedSubTitle = "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!";

//   final Text onBoardScreen1RichText = Text.rich(
//     TextSpan(
//       children: [
//         TextSpan(
//           text: 'Welcome to ',
//           style : Theme.of(context).textTheme.displayLarge?.copyWith(
//             fontWeight: FontWeight.w800,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         TextSpan(
//           text: 'K',
//           style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//             fontWeight: FontWeight.w800,
//             color: kApp2,
//           ),
//         ),
//         TextSpan(
//           text: 'now ',
//           style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//             fontWeight: FontWeight.w800,
//             color: kApp3,
//           ),
//         ),
//         TextSpan(
//             text: 'Yourself ',
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//               fontWeight: FontWeight.w800,
//               color: kApp4Dark,
//             )
//         ),
//         TextSpan(
//             text: 'Better\n',
//             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//               fontWeight: FontWeight.w800,
//             )
//         ),
//         TextSpan(
//             text:'Embark on a transformative journey with Know Yourself Better, unlocking the tools to illuminate the spark within.',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               overflow: TextOverflow.ellipsis,
//               fontWeight: FontWeight.w400,)
//         ),
//       ],
//     ),
//     textAlign: TextAlign.center,
//   );
//
//   final Text onBoardScreen2RichText = Text.rich(
//     TextSpan(
//       children: [
//         TextSpan(
//           text: 'Feel, Track, Reflect.',
//           style: Theme.of(context).textTheme.displaySmall?.copyWith(
//             fontWeight: FontWeight.w800,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         TextSpan(
//           text:   "\n\nCapture emotions, track feelings, and gain personalized insights. Empower yourself for a deeper understanding, navigating life's highs and lows.",
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.w400,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     ),
//     textAlign: TextAlign.center,
//   );
//
//   final Text onBoardScreen3RichText = Text.rich(
//     TextSpan(
//       children: [
//         TextSpan(
//           text: 'Get Started!',
//           style: Theme.of(context).textTheme.displaySmall?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         TextSpan(
//             text: "\n\nYour path to self-discovery \nawaits, let's start this empowering journey together.",
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               fontWeight: FontWeight.w400,
//             )
//         ),
//       ],
//     ),
//     textAlign: TextAlign.center,
//   );
//

// // -- onboarding texts
  static const String onBoardingTitle = "Welcome to";
  static const String onBoardingTitle1 = "Know Yourself Better";
  static const String onBoardingSubTitle = "Uncover the complex and hidden dimensions of your inner self. Witness the interconnected tapestry of your emotions, thoughts, and planes of consciousnesses.";
  static const String onBoardingTitle2 = "Feel, Track, Reflect.";
  static const String onBoardingSubTitle2 = "It's a space deeply rooted in the transformative vision and teachings of Sri Aurobindo and the Mother. Go inward, into the depths of your inner self and find out the Truth through daily life practices and unique experiences.";
  static const String onBoardingTitle3 = "Get Started!";
  static const String onBoardingSubTitle3 = "Your path to self-discovery awaits, let's start this empowering journey together.";

}

