import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';

class Collection {
  final int id;
  final String name;
  final String image;
  final String description;

  Collection({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });
}

// List<Collection> collections = [
//   Collection(
//       id: 1,
//       name: "Eiffel Tower",
//       image: IconProvider.eiffelTower.buildImageUrl(),
//       description:
//           "A wrought-iron lattice tower located in Paris, France. It was constructed between 1887 and 1889. The Eiffel Tower is one of the most visited monuments in the world. It was designed by Gustave Eiffel. The tower has three levels for visitors. It offers breathtaking views of Paris. It is an iconic symbol of France."),
//   Collection(
//       id: 2,
//       name: "Big Ben",
//       image: IconProvider.bigBen.buildImageUrl(),
//       description:
//           "The iconic clock tower located in London, England. It was completed in 1859. Big Ben is a nickname for the Great Bell of the clock. The clock is famous for its reliability and accuracy. The tower is part of the Palace of Westminster. It has undergone several restorations. It is one of the most recognizable landmarks in the UK."),
//   Collection(
//       id: 3,
//       name: "Statue of Liberty",
//       image: IconProvider.statueOfLiberty.buildImageUrl(),
//       description:
//           "A colossal neoclassical sculpture on Liberty Island in New York, USA. It was a gift from France to the United States. The statue was designed by Frédéric Auguste Bartholdi. It was dedicated on October 28, 1886. The statue symbolizes freedom and democracy. It attracts millions of visitors annually. The statue holds a torch and a tablet."),
//   Collection(
//       id: 4,
//       name: "Colosseum",
//       image: IconProvider.colosseum.buildImageUrl(),
//       description:
//           "An ancient amphitheatre located in Rome, Italy. It was built during the Roman Empire. The Colosseum could hold up to 50,000 spectators. It was used for gladiatorial contests and public spectacles. It is a symbol of the architectural brilliance of ancient Rome. The structure is partially ruined due to earthquakes. It remains a popular tourist destination."),
//   Collection(
//       id: 5,
//       name: "Leaning Tower of Pisa",
//       image: IconProvider.leaningTowerOfPisa.buildImageUrl(),
//       description:
//           "A freestanding bell tower of the cathedral in Pisa, Italy. It is known for its unintended tilt. Construction began in 1173 and lasted for 199 years. The tilt is due to an unstable foundation. Efforts have been made to stabilize the tower. It is a UNESCO World Heritage Site. Visitors can climb to the top for panoramic views."),
//   Collection(
//       id: 6,
//       name: "Kremlin",
//       image: IconProvider.kremlin.buildImageUrl(),
//       description:
//           "A fortified complex in Moscow, Russia, overlooking the Moskva River. It includes five palaces and four cathedrals. The Kremlin is the official residence of the President of Russia. It is a symbol of Russian history and politics. The complex is surrounded by high walls. It contains the famous Spasskaya Tower. It is a UNESCO World Heritage Site."),
//   Collection(
//       id: 7,
//       name: "Taj Mahal",
//       image: IconProvider.tajMahal.buildImageUrl(),
//       description:
//           "An ivory-white marble mausoleum in Agra, India. It was commissioned by Emperor Shah Jahan. The Taj Mahal was built in memory of his wife Mumtaz Mahal. It is considered one of the Seven Wonders of the World. The construction began in 1632 and took 22 years. It is a symbol of love and beauty. Millions of tourists visit it every year."),
//   Collection(
//       id: 8,
//       name: "Sydney Opera House",
//       image: IconProvider.sydneyOperaHouse.buildImageUrl(),
//       description:
//           "A multi-venue performing arts centre in Sydney, Australia. It was designed by Danish architect Jørn Utzon. The construction was completed in 1973. The Opera House is a UNESCO World Heritage Site. It is one of the most distinctive buildings in the world. It hosts over 1,500 performances annually. It is an iconic symbol of Australia."),
//   Collection(
//       id: 9,
//       name: "Great Pyramid of Giza",
//       image: IconProvider.greatPyramidOfGiza.buildImageUrl(),
//       description:
//           "The oldest and largest of the pyramids in Giza, Egypt. It was built as a tomb for Pharaoh Khufu. The pyramid was constructed over 20 years. It is the only remaining wonder of the ancient world. It is made of limestone and granite. The pyramid attracts millions of visitors each year. It is a testament to ancient Egyptian engineering."),
//   Collection(
//       id: 10,
//       name: "Machu Picchu",
//       image: IconProvider.machuPicchu.buildImageUrl(),
//       description:
//           "An Incan citadel set high in the Andes Mountains in Peru. It was built in the 15th century. Machu Picchu was abandoned during the Spanish conquest. It was rediscovered in 1911 by Hiram Bingham. The site is a UNESCO World Heritage Site. It is known for its sophisticated dry-stone construction. It offers stunning views of the surrounding landscape."),
// ];
