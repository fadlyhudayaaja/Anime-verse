import 'package:flutter/material.dart';
import 'package:pertemuan1/widgets/genre_list.dart';

import '../widgets/anime_view.dart';
import '../widgets/app_scaffold.dart';

import 'package:provider/provider.dart';

import '../providers/app_state_provider.dart';

import '../widgets/search_field.dart';


class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState(){
    super.initState();
    _searchController = TextEditingController(
        text: context.read<AppStateProvider>().homeSearchQuery
    );
  }

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final provider = context.watch<AppStateProvider>();
    final filteredAnime = provider.getFilteredAnimeForHome();

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "AnimeVerse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.075,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar — ditambahkan di bawah ini




            // Padding(
            //   padding: EdgeInsets.all(screenWidth * 0.04),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(screenWidth * 0.075),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withValues(alpha: 0.3),
            //           blurRadius: screenWidth * 0.02,
            //           offset: Offset(0, screenHeight * 0.005),
            //         ),
            //       ],
            //     ),
            //     child: TextField(
            //       decoration: InputDecoration(
            //         hintText: "Anime Title",
            //         hintStyle: TextStyle(
            //           color: Colors.grey,
            //           fontSize: screenWidth * 0.04,
            //         ),
            //         prefixIcon: Icon(
            //           Icons.search,
            //           color: Colors.grey,
            //           size: screenWidth * 0.06,
            //         ),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(screenWidth * 0.075),
            //           borderSide: BorderSide.none,
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(screenWidth * 0.075),
            //           borderSide: BorderSide.none,
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(screenWidth * 0.075),
            //           borderSide: const BorderSide(color: Colors.white),
            //         ),
            //         filled: true,
            //         fillColor: const Color(0xFF0b395e),
            //         contentPadding: EdgeInsets.symmetric(
            //           horizontal: screenWidth * 0.05,
            //           vertical: screenHeight * 0.015,
            //         ),
            //       ),
            //       style: TextStyle(
            //         fontSize: screenWidth * 0.04,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            SearchField(
                controller: _searchController,
                hintText: 'Anime Title',
                onChanged: (value){
                  provider.setHomeSearchQuery(value);
                },
                showClear: provider.homeSearchQuery.isNotEmpty,
                onClear: (){
                  _searchController.clear();
                  provider.setHomeSearchQuery('');
                }

            ),



            GenreList(
              selected: provider.selectedGenre,
              onGenreSelected: (genre){
                provider.setSelectedGenre(genre);
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            AnimeView(animeList: filteredAnime),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}