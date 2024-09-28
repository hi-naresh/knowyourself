import '../../features/tour/model/tour_model.dart';

List<TourInfo> tourData = [
  // Introduction Category
  TourInfo(
    uniqueId: "1",
    position: 1,
    title: 'What',
    iconImage: 'assets/illustrations/tour/what.svg',
    description:
    "Know Yourself Better is a self-mastery app designed to help you discover and ignite the inner flame within yourself. The app records your problems, feelings, and daily reflections, tracks your vital energy, and suggests activities that can transform your mood. It is about figuring out where you are stuck, be it physically, mentally, vitally, or spiritually, and guides you towards resolving these issues.",
    category: 'Introduction',
  ),
  TourInfo(
    uniqueId: "3",
    position: 3,
    title: 'How',
    iconImage: 'assets/illustrations/tour/how.svg',
    description:
    "Our app uses self-inquiry, self-knowledge, and self-awareness techniques to guide you. It helps you understand the aspects and processes behind life and offers guidance on how to resolve issues and where you are stuck. By tracking your vital energy and suggesting mood-transforming activities, the app empowers you to grow by knowing yourself better and taking reasonable actions tailored to your unique journey.",
    category: 'Introduction',
  ),
  TourInfo(
    uniqueId: "2",
    position: 2,
    title: 'Why',
    iconImage: 'assets/illustrations/tour/why.svg',
    description:
    "The app has a clear vision to help you find the sparkle inside yourself, a flame that, once ignited, keeps you motivated and driven. By understanding and recording your feelings and problems, the app provides you with the tools to navigate life’s challenges and channel your energy into positive transformation. It aims to guide everyone without selfish reasons, paving the way for personal growth and self-discovery.",
    category: 'Introduction',
  ),
  // TourInfo(
  //   uniqueId: "1",
  //   position: 1,
  //   title: 'Intro',
  //  iconImage: 'assets/illustrations/tour/how.svg',
  //   images: [
  //     'https://cdn.pixabay.com/photo/2013/07/18/10/57/mercury-163610_1280.jpg',
  //     'https://solarsystem.nasa.gov/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBcVlHIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--bfcefdbb03ebe1d73fbe2e043abde222b35f1c08/PIA13508.jpg?disposition=attachment',
  //   ],
  //   description:
  //   "Welcome to our self-mastery app! Discover tools and techniques designed to help you grow by understanding yourself better. Start your journey towards personal growth and self-discovery.",
  //   category: 'Introduction',
  // ),



  // Vision Category
  TourInfo(
    uniqueId: "4",
    position: 4,
    title: 'Our Vision',
    iconImage: 'assets/illustrations/tour/how.svg',
    description:
    "We envision a world where everyone is on a path to self-discovery and growth. Our goal is to illuminate this path for you, helping you achieve your best self. we aspire to continue growing our community and expanding our resources to provide even more valuable insights and tools for personal development.",
    category: 'Purpose',
  ),
  TourInfo(
    uniqueId: "5",
    position: 5,
    title: 'Our Mission',
    iconImage: 'assets/illustrations/tour/how.svg',
    description:
    "Our mission is to empower you to grow by understanding yourself. We focus on providing tools and insights that help you make informed, self-directed decisions.",
    category: 'Purpose',
  ),
  TourInfo(
    uniqueId: "8",
    position: 6,
    title: 'Exist Why?',
   iconImage: 'assets/illustrations/tour/how.svg',
    description:
    "We believe in self-growth through self-awareness. Our existence is rooted in the belief that when you know yourself better, you can achieve more meaningful and sustainable growth.",
    category: 'Purpose',
  ),

  // Inspiration
  TourInfo(
    uniqueId: "10",
    position: 10,
    title: 'Inspiration',
   iconImage: 'assets/illustrations/tour/auro.png',
    description: "Our app is inspired by the teachings of Sri Aurobindo and The Mother. Their philosophy of integral yoga, self-inquiry and self-discovery has guided our approach to personal growth and self-awareness. We aim to share their wisdom and insights with you as you embark on your journey towards self-mastery.",
    category: 'Inspiration',
  ),
  //aspiration
  TourInfo(
    uniqueId: "9",
    position: 9,
    title: 'Aspiration',
   iconImage: 'assets/illustrations/tour/auro.png',
    description: "Our app aspires to be a source of inspiration and guidance for those seeking personal growth and self-discovery. By providing tools and resources to help you understand yourself better, we aim to support you on your journey towards self-mastery and self-realization.",
    category: 'Inspiration',
  ),

  // Features Category
  TourInfo(
    uniqueId: "11",
    position: 11,
    title: 'Reflection Journal',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The reflection journal allows you to record your thoughts, feelings, and experiences. By tracking your daily reflections, you can gain insights into your emotional state and thought patterns, helping you identify areas for growth and self-improvement.",
    category: 'Features',
  ),
  TourInfo(
    uniqueId: "20",
    position: 20,
    title: 'Value Analysis',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The value analysis feature helps you identify your core values and beliefs. By reflecting on what matters most to you, you can align your actions and decisions with your personal values, leading to a more fulfilling and purposeful life.",
    category: 'Features',
  ),
  TourInfo(
    uniqueId: "12",
    position: 12,
    title: 'Feel better',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The feel better feature suggests activities and exercises to improve your mood and mental well-being. By engaging in these activities, you can boost your emotional resilience and develop healthy coping strategies for managing stress and anxiety.",
    category: 'Features',
  ),
  //milestone
  TourInfo(
    uniqueId: "13",
    position: 13,
    title: 'Milestone Tracker',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The milestone feature allows you to set personal goals and track your progress towards achieving them. By breaking down your goals into manageable steps, you can stay motivated and focused on your journey towards personal growth and self-improvement.",
    category: 'Features',
  ),
  //Gratitude
  TourInfo(
    uniqueId: "14",
    position: 14,
    title: 'Practise Gratitude',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The gratitude feature encourages you to cultivate a positive mindset by focusing on the things you are grateful for. By practicing gratitude daily, you can shift your perspective and develop a greater sense of happiness and well-being.",
    category: 'Features',
  ),
  //Manifastation
  TourInfo(
    uniqueId: "15",
    position: 15,
    title: 'Manifest',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The manifestation feature helps you visualize your goals and dreams, making them more tangible and achievable. By creating a vision board and setting intentions, you can attract positive energy and opportunities into your life.",
    category: 'Features',
  ),
  //Life Questions
  TourInfo(
    uniqueId: "16",
    position: 16,
    title: 'Questions',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The life questions feature prompts you to reflect on your values, beliefs, and goals. By exploring these deeper questions, you can gain clarity and insight into your purpose and direction in life.",
    category: 'Features',
  ),
  //My Story
  TourInfo(
    uniqueId: "17",
    position: 17,
    title: 'My Story',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The my story feature allows you to create a narrative of your life experiences and personal growth. By reflecting on your journey and achievements, you can gain a greater sense of self-awareness and appreciation for your unique story.",
    category: 'Features',
  ),
  //Learning
  TourInfo(
    uniqueId: "18",
    position: 18,
    title: 'Learning',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The learning feature provides resources and tools to help you expand your knowledge and skills. By engaging in educational activities and self-improvement exercises, you can enhance your personal growth and development.",
    category: 'Features',
  ),
  //Sri aurobindo Resources
  TourInfo(
    uniqueId: "19",
    position: 19,
    title: 'Resources',
   iconImage: 'assets/illustrations/tour/how.svg',
    description: "The platform provides all resources related to Sri Aurobindo at one place. The Sri Aurobindo resources feature offers teachings and insights from the philosophy of Sri Aurobindo and The Mother. By exploring these resources, you can deepen your understanding of integral yoga and self-discovery.  ",
    category: 'Features',
  ),

];
