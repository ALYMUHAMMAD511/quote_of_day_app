import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget
{
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
{
  List<String> quotes =
  [
    'All our dreams can come true; if we have the courage to pursue them. – Walt Disney',
    'However difficult life may seem, there is always something you can do and succeed at. – Stephen Hawking',
    'People begin to become successful the minute they decide to be. – Harvey MacKay',
    'It always seems impossible until it’s done. – Nelson Mandela',
    'It does not matter how slowly you go as long as you do not stop. – Confucius',
    'The more you praise and celebrate your life, the more there is in life to celebrate. – Oprah Winfrey',
    'Success consists of going from failure to failure without loss of enthusiasm. – Winston Churchill',
    'Victory is sweetest when you’ve known defeat. – Malcolm S. Forbes',
    'Satisfaction lies in the effort, not in the attainment, full effort is full victory. – Mahatma Gandhi',
    'Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time. – Thomas A. Edison',
  ];

  List <String> images =
  [
    'https://img.freepik.com/free-photo/vertical-shot-tree-with-dark-cloud_181624-3109.jpg?w=740&t=st=1692651747~exp=1692652347~hmac=422df3740ecbfb028f6f6f944d03b172fa055f8c875f4b7a5e571aba01cac154',
    'https://img.freepik.com/free-photo/tree-with-starry-night-sky_23-2148282334.jpg?w=360&t=st=1692654061~exp=1692654661~hmac=11864a374fb234719576f4722b7d70da6483b02982356871975cda38cb4004eb',
    'https://img.freepik.com/free-photo/breathtaking-shot-sea-dark-purple-sky-filled-with-stars_181624-23013.jpg?w=1060&t=st=1692654113~exp=1692654713~hmac=37b07474b1fe6cd69fe166e920ae88b3155d18d08887d57f1b3840c20903f356',
    'https://img.freepik.com/free-photo/beautiful-picture-cloudy-sunset-cliffs-sea-malta_181624-18354.jpg?t=st=1692651747~exp=1692652347~hmac=fc40f78f6d92213cbeab32258c3f7a4650d1a4dc0593a6812535a9d6cdf81428',
    'https://img.freepik.com/free-photo/low-angle-shot-mesmerizing-starry-sky_181624-27925.jpg?t=st=1692620249~exp=1692620849~hmac=b9b600973538c9d89af558ff55abcc040461e85a4a26869590b6ef912bd904a2',
  ];

  String currentQuote = '';
  String currentImage = '';
  List<String> favoriteQuotes = [];

  @override
  void initState()
  {
    super.initState();
    showRandomQuote();
    loadFavoriteQuotes();
  }

  void showRandomQuote() {
    final random = Random();
    final randomIndex = random.nextInt(quotes.length);
    final randomImage = random.nextInt(images.length);
    setState(() {
      currentQuote = quotes[randomIndex];
      currentImage = images[randomImage];
    });
  }

  void loadFavoriteQuotes() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(()
    {
      favoriteQuotes = sharedPreferences.getStringList('favoriteQuotes') ?? [];
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
          ),
        ),
        backgroundColor: HexColor('333739'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) => quotesFavoriteCard(index),
        physics: const BouncingScrollPhysics(),
      ),
      backgroundColor: HexColor('333739'),
    );
  }

  Widget quotesFavoriteCard(index) => Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Container(
          height:310.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(currentImage),
              fit: BoxFit.cover,
              opacity: 0.94,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                  child: SizedBox(
                    height: 235.0,
                    child: Text(
                      favoriteQuotes[index],
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  IconButton(
                    onPressed: ()
                    {
                      Share.share(currentQuote);
                      },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
