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

  String currentQuote = '';
  List<String> favoriteQuotes = [];

  @override
  void initState()
  {
    super.initState();
    loadFavoriteQuotes();
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
          height:330.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
              colors:
              [
                Colors.redAccent,
                Colors.blueAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 35.0,
                ),
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
