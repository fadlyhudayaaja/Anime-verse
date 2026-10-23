import 'package:flutter/material.dart';
import 'package:pertemuan1/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/app_scaffold.dart';
import '../widgets/favorite_anime_card.dart';
import '../widgets/search_field.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: context.read<AppStateProvider>().favoriteSearchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Anime",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),


          Consumer<AppStateProvider>(
            builder: (context, provider, child) {
              return SearchField(
                controller: _searchController,
                hintText: "Search Favorites",
                onChanged: (value) {
                  provider.setFavoriteSearchQuery(value);
                },
                showClear: provider.favoriteSearchQuery.isNotEmpty,
                onClear: () {
                  _searchController.clear();
                  provider.setFavoriteSearchQuery('');
                },
              );
            },
          ),

          Expanded(
            child: Consumer<AppStateProvider>(
              builder: (context, favoriteProvider, child) {
                final favorites = favoriteProvider.getFilteredFavorites();

                if (favorites.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 32,
                          color: Colors.white70,
                        ),
                        SizedBox(height: 8),
                        Text(
                          favoriteProvider.favorites.isEmpty
                              ? 'Belum Ada anime favorit'
                              : 'Anime tidak ditemukan',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final anime = favorites[index];
                    return FavoriteAnimeCard(
                      id: anime.id,
                      title: anime.title,
                      genre: anime.genre,
                      rating: anime.rating,
                      imagePath: anime.imagePath,
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(height: 100),


        ],
      ),
    );
  }
}

// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return AppScaffold(
//       appBar: AppBar(
//         title: Text(
//           "Favorite Anime",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w800,
//             fontSize: screenWidth * 0.06,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [

//           SizedBox(height: screenHeight * 0.01),

//           Expanded(
//             child: Consumer<AppStateProvider>(
//               builder: (context, favoriteProvider, child){
//                 final favorites = favoriteProvider.favorites;

//                 if (favorites.isEmpty){
//                   return const Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.favorite_border, size: 32, color: Colors.white70),
//                         SizedBox(height: 8),
//                         Text('Belum ada anime favorit', style: TextStyle(color: Colors.white70, fontSize: 16))
//                       ]
//                     )
//                   );
//                 }
//                 return ListView.builder(
//                   padding: EdgeInsets.symmetric(
//                     vertical: screenHeight * 0.01,
//                   ),
//                   itemCount: favorites.length,
//                   itemBuilder: (context, index) {
//                     final anime = favorites[index];
//                     return FavoriteAnimeCard(
//                       id: anime.id,
//                       title: anime.title,
//                       genre: anime.genre,
//                       rating: anime.rating,
//                       imagePath: anime.imagePath,
//                     );
//                   },
//                 );
//               }
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }