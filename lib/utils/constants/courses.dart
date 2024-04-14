import 'package:knowyourself/utils/constants/enums.dart';

import '../../features/learning/model/course_model.dart';
import 'image_strings.dart';

List<CourseModel> materials = [
// enum CourseType{ video,guide, magazine, centers, eBooks, auroSociety }
CourseModel(
      id: '1',
      title: 'The Incarnate Word',
      description: 'https://incarnateword.in/',
      imageUrl: KImages.sa,
      url: 'https://youtu.be/AsSRufxcx-c?si=0FN7FNVwKL3qyP_f',
      type: CourseType.video),
  CourseModel(
      id: '2',
      title: 'Mother and Sri Aurobindo',
      imageUrl: KImages.sa,
      description:
          'This website is a place of peace, harmony and love, above all conflicts and disagreements. It is a collective effort of many souls united in their aspiration and devotion to the Mother and Sri Aurobindo and the Supramental Force which they have brought down and is now in the process of transforming this earthly life to a life divine.',
      url: 'https://motherandsriaurobindo.in/',
      type: CourseType.guide),

  CourseModel(
      id: '3',
      title: 'Sri Aurobindo Ashram',
      imageUrl: KImages.sa,
      description:
          'Complete Explanation and Guidance about Sri Aurobindo Ashram, Pondicherry, TN.',
      url: 'https://www.sriaurobindoashram.org/',
      type: CourseType.centers),
  CourseModel(
      id: '4',
      title: 'Auro Society',
      imageUrl: KImages.sa,
      description:
          'We welcome you to the official online presence of the Sri Aurobindo Society! First launched in August 1998, the www.sriauorbindosociety.org.in is re-designed and accessible at www.aurosociety.org. In the past over 14 years, the website has made a huge impact in taking the work of Sri Aurobindo and the Mother forward, connecting devotees, seekers, volunteers, donors from world-over.',
      url: 'https://aurosociety.org/',
      type: CourseType.auroSociety),
  CourseModel(
      id: '5',
      title: 'AuroMaa',
      imageUrl: KImages.sa,
      description:
          'AuroMaa (YT Channel, talks and classes of Dr. Alok Pandey)',
      url: 'https://www.youtube.com/@AuroMaa',
      type: CourseType.video),
  CourseModel(
      id: '6',
      title: 'All India Magazine (Monthly)',
      imageUrl: KImages.sa,
      description: 'https://aim.aurosociety.org/',
      url: 'https://aim.aurosociety.org/',
      type: CourseType.magazine),
  CourseModel(
      id: '7',
      title: 'In Search of The Mother',
      imageUrl: KImages.sa,
      description:
          'Work as a means of meditation and Sadhana is indeed what the holy Seer advocated. In Search of The Mother Platform is an IT portal with deep roots to the vision of Sri Aurobindo, The Mother and their spiritual ideals. It is equipped with state-of-the-art IT Infrastructure and caters to the technical needs of all organisations and activities related to Sri Aurobindo and The Mother. It provides technical support to all organisations conducting activities or projects related to Sri Aurobindo, The Mother, Auroville, Savitri etc.',
      url: 'https://insearchofthemother.net/',
      type: CourseType.guide),
  CourseModel(
      id: '8',
      title: 'La Grace, Sri Aurobindo Integral Life Center',
      imageUrl: KImages.sa,
      description:
          'La Grace, Sri Aurobindo Integral Life Center is a non-profit organization dedicated to transformational learning and growth of consciousness.',
      url: 'https://lagracecenter.com/',
      type: CourseType.centers),
  CourseModel(
      id: '9',
      title: 'Auro E-Books',
      imageUrl: KImages.sa,
      description:
          'Auro E-Books publishing and distribution services is a part of our effort to bring the benefits of digital publishing to publishers and authors in the field of spirituality and well-being. With our e-publishing work, we provide authors and publishers a way to reach the large audience of readers online, who interested in self-development and the overall growth of harmony and well-being upon Earth. Auro E-Books offers a conversion service to any e-book format from virtually any format – Word, Word Perfect, Ventura, PDF, Quark, InDesign, XML or HTML, among others. These e-books are compatible with the ADE, Sony Reader, Kindle, iPhone, iPad (iBooks) and most desktop readers, depending on the customer’s requirements.',
      url: 'https://auro-ebooks.com/',
      type: CourseType.eBooks),
  CourseModel(
      id: '10',
      title: 'Agenda Mother',
      imageUrl: KImages.sa,
      description:
          'Recorded by Satprem, a disciple of the Mother, in the course of numerous personal conversations with her, Mother’s Agenda is the complete logbook of her exploration in the cellular consciousness of the human body. It covers 23 years of experiences which parallel some of the most recent theories of modern physics, and are perhaps the key to man’s passage to the next species. This 6, OOO-page work in 13 volumes represents the day-to-day account over 22 years of Mother’s exploration into the body consciousness and her discovery of a “cellular mind”, capable of restructuring the nature of the body and the laws of the species as drastically as, one day, the first stammerings of a “thinking mind” transformed the nature of the ape. It is a timely document of experimental evolution, involving a revolution in consciousness that alters the laws of the species. Whatever the appearances, we are not at the end of a civilisation but at the end of an evolutionary cycle. Are we going to find the passage to the next species, or perish? As scrupulously as a scientist in his laboratory, Mother goes back to the origin of matter’s formation, to the primordial code, and there, ‘by chance’, stumbles upon the mechanism of death – upon the very power that changes death – and upon a ‘new’ Energy which curiously parallels the most recent theories on the subatomic nature of Matter. The key to Matter contains the key to death … as well as the key to the next species.',
      url: 'https://agendamother.wordpress.com/agenda/',
      type: CourseType.auroSociety),
  CourseModel(
      id: '11',
      title: 'Auroville.org',
      imageUrl: KImages.sa,
      description:
          'The Auroville community maintains this website to facilitate public access to information about Auroville\'s aims and ideals and their practical implementation. The goal is to keep this information timely and accurate.',
      url: 'https://auroville.org/',
      type: CourseType.auroSociety),
  CourseModel(
      id: '12',
      title: 'The Auroville Adventure',
      imageUrl: KImages.sa,
      description: 'Explore Auroville. Take part in its Grand Adventure.',
      url: 'https://adventure.auroville.com/',
      type: CourseType.auroSociety),
  CourseModel(
      id: '13',
      title: 'Savitribhavan',
      imageUrl: KImages.sa,
      description:
          'Savitri Bhavan in Auroville is a centre dedicated to fostering a living sense of Human Unity through spiritual education based on the vision and teachings of Sri Aurobindo and the Mother. The central focus is Sri Aurobindo’s mantric epic Savitri: a legend and a symbol, which the Mother has called ‘The supreme revelation of Sri Aurobindo’s vision’.',
      url: 'https://savitribhavan.org/',
      type: CourseType.centers),
  CourseModel(
      id: '14',
      title: 'Savitri.in',
      imageUrl: KImages.sa,
      description:
          'The epic Savitri by Sri Aurobindo is the centre around which Savitri.in intends to live, breathe and grow; and there is no limit as to HOW this is to be done.',
      url: 'https://savitri.in/1/1/1',
      type: CourseType.centers),
  CourseModel(
      id: '15',
      title: 'Encyclopedia Savitri Bhavan',
      imageUrl: KImages.sa,
      description: 'Living Savitri, Online encyclopedia of Sri Aurobindo\'s opus magnum…',
      url: 'https://encyclopedia.savitribhavan.org/',
      type: CourseType.guide),
  CourseModel(
      id: '16',
      title: 'Sri Aurobindo Ashram - Delhi Branch',
      imageUrl: KImages.sa,
      description: 'Official Website',
      url: 'https://www.sriaurobindoashram.net/',
      type: CourseType.centers),
  CourseModel(
      id: '17',
      title: 'Sri Aurobindo Ashram – Delhi Branch – Digital Library',
      imageUrl: KImages.sa,
      description: 'Sharing the Heritage of Sri Aurobindo Ashram Delhi Branch',
      url: 'https://saad.aurohub.org/',
      type: CourseType.guide),
  CourseModel(
      id: '18',
      title: 'The Parts of the Being and the Planes of Consciousness',
      imageUrl: KImages.sa,
      description: 'The Parts of the Being and the Planes of Consciousness',
      url: 'https://motherandsriaurobindo.in/Sri-Aurobindo/books/letters-on-yoga-I/#part-ii-the-parts-of-the-being-and-the-planes-of-consciousness',
      type: CourseType.guide),

];
