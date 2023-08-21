import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quote_of_the_day_app/modules/favorites/favorites_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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
    showRandomQuote();
    loadFavoriteQuotes();
  }

  void showRandomQuote()
  {
    final random = Random();
    final randomIndex = random.nextInt(quotes.length);
    setState(()
    {
      currentQuote = quotes[randomIndex];
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

  void toggleFavorite() async
  {
    if (favoriteQuotes.contains(currentQuote))
    {
      favoriteQuotes.remove(currentQuote);
    }
    else
    {
      favoriteQuotes.add(currentQuote);
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('favoriteQuotes', favoriteQuotes);

    setState((){});
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quote of the Day',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30.0,
            ),
            onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
        backgroundColor: HexColor('333739'),
      ),
      body: quotesCard(),
      backgroundColor: HexColor('333739'),
    );
  }

  Widget quotesCard()
  {
    bool isFavorite = favoriteQuotes.contains(currentQuote);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Container(
              height:392.0,
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
                      top: 50.0,
                    ),
                    child: Text(
                      currentQuote,
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
                    children: [
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
                      const SizedBox(
                        width: 10.0,
                    ),
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        color: isFavorite ? Colors.red : Colors.white,
                        onPressed: toggleFavorite,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 300.0,
                    ),
                    child: IconButton(
                      onPressed: ()
                      {
                        showRandomQuote();
                        },
                      icon: const Icon(
                        Icons.refres,
                        color: Colors.white,
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