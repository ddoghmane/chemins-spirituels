import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String selectedImam = 'Tous';

  final List<String> imams = [
    'Tous',
    'Al-Ghazali',
    'Ibn Arabi',
    'Ibn Ajiba',
    'Ibn Ata Allah',
  ];

  final List<Map<String, String>> favorites = [
    {
      'arabe': 'سُبْحَانَ اللَّهِ',
      'phonetic': 'Subḥān Allāh',
      'francais': 'Gloire à Allah',
      'imam': 'Al-Ghazali',
    },
    {
      'arabe': 'الْحَمْدُ لِلَّهِ',
      'phonetic': 'Alḥamdu lillāh',
      'francais': 'Louange à Allah',
      'imam': 'Ibn Arabi',
    },
    {
      'arabe': 'لَا إِلَهَ إِلَّا اللَّهُ',
      'phonetic': 'Lā ilāha illa Allāh',
      'francais': 'Nulle divinité sauf Allah',
      'imam': 'Ibn Ata Allah',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFavorites = selectedImam == 'Tous'
        ? favorites
        : favorites
            .where((item) => item['imam'] == selectedImam)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('❤️ Mes Favoris'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '📖 ${favorites.length} favoris enregistrés',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imams.length,
              itemBuilder: (context, index) {
                final imam = imams[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(imam),
                    selected: selectedImam == imam,
                    onSelected: (_) {
                      setState(() {
                        selectedImam = imam;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredFavorites.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Aucun favori pour le moment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Ajoute une invocation depuis la page des invocations',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final invocation = filteredFavorites[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                invocation['arabe']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                invocation['phonetic']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                invocation['francais']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                              const Divider(height: 25),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '👳 ${invocation['imam']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        favorites.remove(invocation);
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Favori retiré',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
