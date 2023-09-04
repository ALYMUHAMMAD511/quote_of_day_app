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
    'https://img.freepik.com/free-photo/3d-grunge-room-interior-with-spotlight-smoky-atmosphere-background_1048-11333.jpg?w=996&t=st=1693865943~exp=1693866543~hmac=11af7c419f3565d69f4795eac6f4f8f21b07e83ebf980e75c90c0f34a379c52a',
    'https://img.freepik.com/free-photo/old-painted-textured-surface-backdrop_114579-40052.jpg?w=1060&t=st=1693866018~exp=1693866618~hmac=19bd4859a9187d580032229dc958ad8a85e6fdcea5d590f47850632a2a1ec857',
    'https://img.freepik.com/free-photo/tree-with-starry-night-sky_23-2148282334.jpg?w=360&t=st=1692654061~exp=1692654661~hmac=11864a374fb234719576f4722b7d70da6483b02982356871975cda38cb4004eb',
    'https://img.freepik.com/free-photo/beautiful-picture-cloudy-sunset-cliffs-sea-malta_181624-18354.jpg?t=st=1692651747~exp=1692652347~hmac=fc40f78f6d92213cbeab32258c3f7a4650d1a4dc0593a6812535a9d6cdf81428',
    'https://img.freepik.com/free-photo/low-angle-shot-mesmerizing-starry-sky_181624-27925.jpg?t=st=1692620249~exp=1692620849~hmac=b9b600973538c9d89af558ff55abcc040461e85a4a26869590b6ef912bd904a2',
    'https://img.freepik.com/free-photo/vertical-shot-breathtaking-starry-sky-night-perfect-wallpapers-backgrounds_181624-25954.jpg?w=360&t=st=1693866051~exp=1693866651~hmac=8a23214f372788bba753261791b3773732fdda261f5508c8737a4d143ea2a376',
    'https://img.freepik.com/free-photo/breathtaking-shot-starry-night-bolonia-beach-algeciras-cadiz-spain_181624-22684.jpg?w=1060&t=st=1693866074~exp=1693866674~hmac=cfd8976df1b9720d313eb37f7aa215cc5325e4d5193093610dede358984ef2d5',
    'https://img.freepik.com/free-photo/dark-blue-product-background_53876-92801.jpg?w=1060&t=st=1693866126~exp=1693866726~hmac=685aef4a95d8aacb684cfe8be736d78e42b860044c79d8ace96592897da0eb09',
    'https://img.freepik.com/free-photo/3d-render-spotlights-grunge-brick-wall_1048-6284.jpg?w=740&t=st=1693866185~exp=1693866785~hmac=c53a8af84dc86a1fcc7a3f7e08d8b31c1468cf749d6a64f4e762224e65922834',
    'https://img.freepik.com/free-photo/metal-grunge-background-with-scratches-stains_1048-14029.jpg?w=740&t=st=1693866343~exp=1693866943~hmac=0cb8b07019b0a683b22fff92687524f3c9a284106a07a95d9b401338986b1339',
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
              fontSize: 30.0,
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
                    height: 255.0,
                    child: Text(
                      favoriteQuotes[index],
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          shadows: <Shadow>
                          [
                            Shadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 10.0,
                              color: Colors.black,
                            ),
                          ],
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
                      size: 30.0,
                      shadows: <Shadow>
                      [
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 10.0,
                          color: Colors.black,
                        ),
                      ],
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
