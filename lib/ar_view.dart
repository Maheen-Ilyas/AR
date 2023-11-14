import 'package:ar/utilities/animated_button.dart';
import 'package:ar/utilities/model.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class AR extends StatefulWidget {
  const AR({super.key});

  @override
  State<AR> createState() => _ARState();
}

class _ARState extends State<AR> {
  int storyStep = 0;
  List<bool> buttonVisibilities = [];

  // Position of buttons
  final List<Offset> buttonPositions = const [
    Offset(0.1, 0.1),
    Offset(0.8, 0.2),
    Offset(0.2, 0.8),
    Offset(0.8, 0.5),
    Offset(0.5, 0.8),
  ];

  int selectedModelIndex = 0;
  List<ARModel> models = [
    ARModel(
      name: "Cologne Cathedral",
      modelPath: 'assets/cologne_cathedral.glb',
      story: [
        "In the heart of Germany, the Cologne Cathedral rises proudly along the Rhine River, a Gothic masterpiece whose foundations were laid in the 13th century.",
        "Crafted by dedicated artisans, its soaring spires and intricate stone facade tell a tale of unwavering faith and medieval craftsmanship passed through the ages.",
        "As the sun sets, the cathedral's stained glass windows come alive, casting a colorful spectacle that narrates biblical scenes and saints, inviting visitors into a world where the divine and the earthly converge.",
        "Resilient through wars and revolutions, the cathedral stands as a timeless symbol of hope, its twin spires becoming beacons that guide travelers through the city's history.",
        "Its hallowed halls echo with the footsteps of pilgrims, the whispers of prayers, and the silent witness to the passage of time, embodying the soul of a city that has weathered storms and celebrated triumphs.",
        "The cathedral's iconic presence shapes the cityscape, overseeing marketplaces and cobbled streets, and acting as a guardian spirit that transcends the boundaries of creed and culture.",
        "With each gaze upon its grandeur, tourists connect to tales of medieval masons and visionary architects, feeling a spiritual invitation to become part of its ongoing story.",
        "The bells toll, marking the passage of another day, as the Cologne Cathedral remains a stoic sentinel, eternally bound to the tapestry of the city's narrative.",
        "The Cologne Cathedral stands as a silent sentinel, its medieval stones bearing witness to the city's evolution, from coronations to joyous weddings and somber farewells.",
        "As tourists wander through its sacred halls, guided by the whispers of history, the cathedral's grandeur becomes a living chapter in the ongoing story of human creativity, resilience, and faith, resonating with the timeless spirit of the Rhineland."
      ],
    ),
    ARModel(
      name: "Piazza Del Duomo",
      modelPath: 'assets/piazza_del_duomo_-_pisa_laser_scan.glb',
      story: [
        "In the heart of Milan, Italy, lies the enchanting Piazza del Duomo, a captivating square surrounded by historic wonders.",
        "As the sun dips below the horizon, the soft glow of the Cathedral's marble facade illuminates the square, creating a breathtaking sight.",
        "Cobblestone pathways lead visitors through the bustling square, where the echoes of centuries-old footsteps seem to resonate in the air.",
        "Standing tall and proud, the iconic Milan Cathedral, or Duomo di Milano, dominates the skyline, its intricate spires reaching towards the heavens.",
        "Local musicians fill the air with melodic tunes, adding a symphonic touch to the lively atmosphere that envelops the piazza.",
        "Cafés with quaint outdoor seating offer the perfect vantage point to sip espresso and soak in the architectural marvels that surround the square.",
        "Artistic performers captivate passersby with their mesmerizing displays, adding a touch of creativity to the vibrant street scene.",
        "Pigeons gracefully dance around the square, seemingly choreographed in a timeless performance that mirrors the historical elegance of the surroundings.",
        "Vendors peddle their wares, from colorful souvenirs to delectable Italian treats, creating a sensory experience that lingers in the memories of all who visit.",
        "As day turns to night, the Piazza del Duomo transforms into a magical realm, where the Cathedral's illuminated facade becomes a beacon of cultural and historical significance, casting a spell that enchants visitors from around the world.",
      ],
    ),
    ARModel(
      name: "Sphinx of Hatshepsut",
      modelPath: 'assets/sphinx_of_hatshepsut.glb',
      story: [
        "In the ancient land of Egypt, nestled amidst the golden sands and mysterious pyramids, there stood a colossal monument of enigma and wisdom—the Sphinx.",
        "Carved with the precision of skilled artisans, its leonine body stretched regally against the horizon, guarding the secrets of time.",
        "Legend whispered that the Sphinx possessed the knowledge of ages, its gaze holding the key to unraveling the mysteries of the universe.",
        "Many a brave adventurer ventured into the arid expanse, seeking the answers hidden within the riddles it posed to those who dared approach.",
        "Under the shimmering moonlight, the Sphinx transformed into a mystical guardian, its stone facade resonating with the echoes of ancient prophecies.",
        "It watched over the vast desert, a silent sentinel standing witness to the ebb and flow of civilizations.",
        "Scholars and sages came from far and wide, drawn by the allure of the Sphinx's timeless wisdom, hoping to unlock the secrets that lay dormant in its stony countenance.",
        "As the sun dipped below the horizon, casting hues of orange and pink across the sky, the Sphinx seemed to come alive with a mysterious vitality.",
        "Echoes of forgotten chants and prayers lingered in the air, as pilgrims sought the Sphinx's blessings for a prosperous future. The stone guardian, with its inscrutable smile, became a symbol of both divine guidance and the inscrutability of fate.",
        "Through the passage of centuries, the Sphinx witnessed the rise and fall of empires, its stoic presence a testament to the enduring power of the human spirit. Each passing generation left its mark on the monument, contributing to the rich tapestry of stories woven into the very fabric of the ancient land.",
      ],
    ),
    ARModel(
      name: "Statue of Liberty",
      modelPath: 'assets/statue_of_liberty.glb',
      story: [
        "In the bustling harbor of New York City, the Statue of Liberty stands tall and proud, a symbol of freedom and democracy.",
        "Gifted to the United States by the people of France in 1886, Lady Liberty has watched over the city for over a century.",
        "Her copper exterior, initially gleaming like a shiny penny, has weathered to a distinct green hue over the years, a testament to the passage of time.",
        "As the morning sun kisses the statue's crown, it casts a radiant glow across the waters, welcoming newcomers and reminding all of the nation's principles.",
        "The statue's torch, held high in her right hand, serves as a guiding light for ships navigating the harbor, a beacon of hope for those seeking a better life.",
        "Visitors ascend a spiral staircase inside the statue to reach the crown, where panoramic views of the city skyline and harbor unfold.",
        "Standing at 305 feet, the Statue of Liberty is a colossal figure, evoking a sense of awe and inspiration for those who witness her majesty up close.",
        "The seven rays on her crown represent the seven continents, symbolizing the universal embrace of freedom and enlightenment.",
        "Over the years, the statue has witnessed historic moments, from waves of immigrants arriving on nearby Ellis Island to jubilant celebrations in the city below.",
        "Today, the Statue of Liberty remains a cherished symbol, an enduring icon that embodies the spirit of liberty and the pursuit of a brighter future for all.",
      ],
    ),
    ARModel(
      name: "Opera House",
      modelPath: 'assets/sydney_opera_house_-_google_maps_export.glb',
      story: [
        "Once upon a time in the heart of a bustling city, there stood an architectural marvel known as the Opera House. Its grandeur was unparalleled, with a design that seemed to defy the limits of imagination.",
        "The story of this iconic structure began when a visionary architect dared to dream beyond conventional boundaries. The Opera House, with its iconic sail-like structures, emerged as a symbol of cultural prowess and artistic excellence.",
        "Its construction was a labor of love, involving skilled artisans and craftsmen who poured their passion into every detail. The city buzzed with excitement as the Opera House took shape, becoming a beacon of artistic expression and a testament to human creativity.",
        "As the inaugural performance approached, anticipation filled the air. The Opera House was not merely a building; it was a stage for dreams, a canvas for emotions, and a sanctuary for the performing arts.",
        "The opening night was a spectacle that left the audience in awe, as the acoustics of the hall amplified the enchanting melodies, making it a night to be etched in the memories of all who were fortunate enough to witness it.",
        "Over the years, the Opera House became a cultural hub, hosting world-class performances that transcended time and genre.",
        "Each performance was a chapter in the Opera House's rich narrative, weaving together the stories of countless artists who graced its stage.",
        "However, like any great tale, the Opera House faced challenges. Time took its toll, and the need for restoration became evident.",
        "The city rallied together to preserve this cultural gem, ensuring that future generations could continue to experience the magic within its walls.",
        "The Opera House stood the test of time, a living testament to the enduring power of art and human determination. Its lights continued to illuminate the city skyline, inviting new generations to step into its hallowed halls and create their own stories within the echoing walls of this magnificent structure.",
      ],
    ),
    ARModel(
      name: "Moai",
      modelPath: 'assets/tall_moai.glb',
      story: [
        "Once upon a time on the remote and mystical Easter Island, a group of giant stone statues known as Moai stood silently, guarding the secrets of a bygone era.",
        "These imposing figures, carved from solidified volcanic ash, were the handiwork of the Rapa Nui people, a Polynesian civilization surrounded by the vast expanse of the Pacific Ocean.",
        "Legend had it that the Moai possessed a mysterious energy, a connection to the spiritual realm that inspired awe and reverence among the islanders.",
        "Each statue bore a unique expression, a testament to the craftsmanship and artistry of the Rapa Nui people, who dedicated countless hours to fashioning these monolithic guardians.",
        "Some believed that the Moai held the spirits of their ancestors, watching over the island with a vigilant gaze. Others spoke of a hidden purpose, a cosmic alignment that would one day unveil the true essence of these enigmatic stone sentinels.",
        "Through generations, the Moai witnessed the ebb and flow of time, silently observing the changing fortunes of the Rapa Nui people. They stood as a testament to resilience, an enduring symbol of a civilization that flourished against the backdrop of the vast and unforgiving Pacific.",
        "Yet, mysteries surrounded the creation of the Moai. How did the ancient islanders transport these massive stones across the rugged terrain? What rituals and ceremonies were conducted to bring forth such colossal sculptures?",
        "As modern explorers and archaeologists uncovered the secrets of Easter Island, the Moai continued to captivate the imagination of the world.",
        "Their silent presence echoed through the ages, inviting contemplation and sparking a quest for understanding in the hearts of those who gazed upon their weathered faces.",
        "And so, the Moai stood as a testament to the enduring spirit of human creativity and the mysteries that still lie hidden beneath the surface of our shared history, inviting us to ponder the enigmatic tale of Easter Island and the ancient people who carved these monumental figures into the fabric of time.",
      ],
    ),
    ARModel(
      name: "The Great Pyramid of Giza",
      modelPath: 'assets/the_great_pyramid_of_giza.glb',
      story: [
        "Once upon a time, in the ancient land of Egypt, there stood a marvel that defied the sands of time—the Great Pyramid of Giza. Built as a testament to the ingenuity of the ancient Egyptians, this colossal structure rose from the desert like a beacon of architectural brilliance.",
        "In the shadow of the pyramids, a bustling city thrived, with craftsmen and laborers toiling under the scorching sun to bring Pharaoh Khufu's vision to life.",
        "Legend has it that the pyramid's construction was guided by the divine hand of the gods, as the architects carefully aligned the structure with the stars.",
        "The Pyramid of Giza, with its majestic limestone blocks, held the mysteries of the afterlife within its chambers. Hieroglyphics adorned the inner walls, telling tales of the pharaoh's journey to the realm of the gods and the eternal life that awaited him.",
        "As the sun set over the horizon, casting an enchanting glow on the ancient stones, the pyramid stood as a silent witness to the passage of centuries. Travelers from distant lands marveled at its grandeur, contemplating the secrets hidden within its geometric precision.",
        "Whispers of curses and treasures entwined with the pyramid's mystique, as tales of mummies and hidden chambers fueled the imaginations of explorers.",
        "Throughout the ages, conquerors and scholars alike sought to unravel the enigma of the pyramid, each endeavoring to decipher the purpose behind its construction and the knowledge encoded within its structure.",
        "The Great Pyramid of Giza became a symbol of Egypt's enduring legacy, surviving earthquakes, wars, and the relentless erosion of time. It stood as a beacon of human achievement, a testament to the dreams and ambitions of a civilization that sought to transcend mortality through stone and mortar.",
        "Generations passed, and the Great Pyramid became a pilgrimage site for those seeking to connect with the ancient wisdom of the pharaohs. The winds whispered stories of its construction, and the echoes of history resonated within its walls.",
        "And so, the Pyramid of Giza stood tall against the backdrop of the Egyptian landscape, a silent sentinel that transcended the ages, inviting all who beheld it to ponder the mysteries of life, death, and the eternal dance of the cosmos.",
      ],
    ),
    ARModel(
      name: "Tower of Pisa",
      modelPath: 'assets/torre_pisa.glb',
      story: [
        "Once upon a time in the medieval city of Pisa, Italy, there stood a magnificent tower that would later become known as the Leaning Tower of Pisa.",
        "Its construction began in 1173 and, unbeknownst to the builders, it would become one of the most iconic and leaning structures in the world.",
        "Legend has it that the tower's tilt was apparent even during its early years of construction due to unstable foundation soil.",
        "Despite the architects' efforts to correct the tilt, the tower continued to lean, giving it a distinct and captivating appearance.",
        "Over the centuries, the Tower of Pisa became a symbol of both architectural marvel and human perseverance. Tourists from around the globe flocked to witness this leaning wonder, capturing photos that defied the laws of gravity.",
        "During World War II, the tower's fame grew even more as it served as a landmark for Allied pilots. Fortunately, the tower survived the war, standing as a testament to resilience amidst adversity.",
        "In 1990, engineers intervened to prevent further tilting, as the structure risked collapsing.",
        "They successfully stabilized the tower, ensuring its continued presence for future generations to marvel at.",
        "Today, the Leaning Tower of Pisa remains a UNESCO World Heritage Site and a cherished symbol of Italy.",
        "Its inclined posture continues to draw visitors, sparking curiosity and inspiring admiration for the enduring beauty of imperfection.",
      ],
    ),
    ARModel(
      name: "Petra",
      modelPath: 'assets/ad-dayr_petra_crowdsourced_photogrammetry_scan.glb',
      story: [
        "Once hidden in the rugged deserts of Jordan, Petra emerged from the rose-red cliffs like a forgotten city of dreams. Its secrets were guarded by towering sandstone walls that stood as silent sentinels to an ancient civilization's glory.",
        "The path to Petra wound through narrow Siq, a canyon of breathtaking beauty, with every step building anticipation for the hidden treasure ahead.",
        "As the sun dipped below the horizon, Petra's famed Al-Khazneh, or the Treasury, unveiled itself, bathed in a warm, golden glow. Carved meticulously into the rosy rock, it told tales of a bygone era, echoing with whispers of Nabataean traders and their caravan-laden journeys.",
        "The city, with its intricate rock-cut architecture, seemed frozen in time, an archaeological masterpiece from the pages of history.",
        "Beyond the Treasury, the ancient streets of Petra unraveled like a maze, revealing theaters, temples, and tombs, each with a story etched in the very stones that cradled them.",
        "The Monastery, perched high amidst the cliffs, offered a breathtaking panorama of the surrounding desert, inviting contemplation on the passage of centuries.",
        "The echoes of Petra's past resonated in the Royal Tombs, where the elite found their eternal rest in chambers hewn from the living rock.",
        "As daylight waned, the haunting beauty of Petra intensified, with candlelit pathways leading to the heart of the ancient city, where the spirits of the Nabataeans seemed to stir in the cool desert breeze.",
        "Under the vast desert sky, Petra transformed into a magical realm, with the stars casting a celestial glow on the archaeological wonders below. It was a city that defied time, a testament to human ingenuity and the enduring allure of ancient civilizations.",
        "In the silence of the night, Petra whispered its stories, beckoning travelers to lose themselves in the enchantment of a place where history and mystique converged.",
      ],
    ),
    ARModel(
      name: "Acropolis",
      modelPath: 'assets/parthenon_-_acropolis_athens_greece.glb',
      story: [
        "Once upon a time, high above the bustling city of Athens, there stood a magnificent citadel known as the Acropolis.",
        "This ancient marvel, perched on a rocky outcrop, told tales of a bygone era. The Acropolis, whose name means \"high city\", was a testament to the grandeur of ancient Greek civilization.",
        "Upon entering the sacred grounds, visitors were greeted by the iconic Parthenon, a colossal temple dedicated to the goddess Athena. The temple's majestic columns and intricate sculptures whispered stories of the gods and goddesses who once walked among mortals.",
        "As the sun dipped below the horizon, the golden glow bathed the Acropolis in a magical light, as if the spirits of ancient philosophers and warriors were awakening.",
        "Wandering through the Propylaea, the monumental gateway to the Acropolis, one could almost hear the echoes of the past—footsteps of philosophers like Socrates and Aristotle, engaged in profound discussions that shaped the course of human thought.",
        "The Erechtheion, with its graceful Caryatid Porch, added a touch of elegance to the narrative, narrating the myths of Poseidon and Athena in its architectural details.",
        "A visit to the Acropolis Museum provided a glimpse into the artifacts and treasures that once adorned this sacred site.",
        "The friezes and statues spoke eloquently of the artisans' skill and the society's devotion to art and knowledge. Standing amidst the ruins, one couldn't help but feel a connection to the ancient Greeks, whose stories were etched into every stone.",
        "As night fell, the Acropolis became a beacon of history, a silent storyteller against the backdrop of the modern city lights. The sacred hill, with its archaeological wonders, stood as a living testament to the enduring legacy of a civilization that shaped the foundations of Western culture.",
        "And so, the Acropolis continued to narrate its tales, inviting visitors to step back in time and embrace the rich tapestry of Greece's cultural heritage.",
      ],
    ),
    ARModel(
      name: "Hallwyl Museum",
      modelPath: 'assets/the_hallwyl_museum_1st_floor_combined.glb',
      story: [
        "Nestled in Stockholm, the Hallwyl Museum is a 19th-century castle-turned-residence, a lavish testament to opulence.",
        "Once home to Walther and Wilhelmina von Hallwyl, it echoes tales of extravagant aristocratic living through its preserved grand ballrooms, antique furniture, and priceless artifacts.",
        "Guided tours bring the von Hallwyls' stories to life, recounting anecdotes of illustrious guests and extravagant parties.",
        "Each room in the museum holds a story, showcasing the couple's passion for art and culture. The garden, a serene escape, whispers echoes of past laughter from elegant soirées.",
        "Resilient through historical shifts, the Hallwyl Museum stands as a witness to Stockholm's evolving cultural tapestry.",
        "Guided tours bring the von Hallwyls' stories to life, recounting anecdotes of illustrious guests and extravagant parties.",
        "More than a static display, the museum is a living testament to the couple's passion and vision, with walls resonating with the echoes of the past.",
        "As the sun sets, the Hallwyl Museum transforms into a magical realm where history and art coexist harmoniously.",
        "A jewel in Stockholm's crown, this museum invites visitors to step into the shoes of the von Hallwyls and explore the captivating legacy of a remarkable couple.",
        "In this enchanting haven, the pages of history continue to unfold, captivating the imaginations of all who seek to discover its treasures.",
      ],
    ),
  ];

  void showStoryBox(BuildContext context, String story) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Story'),
          content: Text(
            story,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (storyStep < buttonVisibilities.length - 1) {
                  setState(
                    () {
                      buttonVisibilities[storyStep + 1] = true;
                    },
                  );
                }
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    updateButtonVisibility();
  }

  void updateButtonVisibility() {
    buttonVisibilities = List.generate(
      models[selectedModelIndex].story.length,
      (index) => index == 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    ARModel selectedModel = models[selectedModelIndex];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            models[selectedModelIndex].name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  bottom: -10,
                  child: DropdownButton<String>(
                    value: models[selectedModelIndex].name.toString(),
                    items: models.map(
                      (ARModel model) {
                        return DropdownMenuItem<String>(
                          value: model.name.toString(),
                          child: Text(model.name),
                        );
                      },
                    ).toList(),
                    onChanged: (String? modelName) {
                      int index = models.indexWhere(
                        (model) => model.name == modelName,
                      );
                      if (index >= 0 && index < models.length) {
                        setState(() {
                          selectedModelIndex = index;
                          storyStep = 0;
                          updateButtonVisibility();
                        });
                      }
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    dropdownColor: Colors.grey[200],
                    elevation: 5,
                    icon: const Icon(Icons.arrow_drop_down),
                    focusColor: Colors.amberAccent,
                  ),
                ),
                SizedBox(
                  height: 500,
                  width: 500,
                  child: ModelViewer(
                    src: selectedModel.modelPath,
                    ar: true,
                    disableZoom: false,
                  ),
                ),
                for (int i = 0; i < buttonVisibilities.length; i++)
                  Visibility(
                    visible: buttonVisibilities[i],
                    child: Positioned(
                      left: buttonPositions[i].dx *
                          MediaQuery.of(context).size.width,
                      top: buttonPositions[i].dy *
                          MediaQuery.of(context).size.height,
                      child: AnimatedButton(
                        onPressed: () {
                          showStoryBox(
                            context,
                            selectedModel.story[i],
                          );
                          setState(
                            () {
                              buttonVisibilities[i] = false;
                              if (i + 1 < buttonVisibilities.length) {
                                buttonVisibilities[i + 1] = true;
                              }
                              storyStep++;
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
