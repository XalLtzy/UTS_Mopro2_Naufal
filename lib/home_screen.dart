import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'album_songs_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;

  const HomeScreen({super.key, required this.username, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = [];
  List<Map<String, String>> favoriteSongs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);

    // Inisialisasi halaman
    _pages.add(_buildHomePage());
    _pages.add(_buildFavoritesPage());
    _pages.add(_buildProfilePage());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.username),
            accountEmail: Text(widget.email),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/naufal.jpg'),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _onBottomNavTapped(0),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            onTap: () => _onBottomNavTapped(1),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () => _onBottomNavTapped(2),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        _buildTrendingView(),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Album',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: _buildGridView(),
        ),
      ],
    );
  }

  Widget _buildFavoritesPage() {
    if (favoriteSongs.isEmpty) {
      return const Center(child: Text("No favorites added yet"));
    }

    return ListView.builder(
      itemCount: favoriteSongs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text(favoriteSongs[index]['title']!),
          subtitle: Text(favoriteSongs[index]['artist']!),
        );
      },
    );
  }

  Widget _buildGridView() {
    final List<Map<String, dynamic>> albums = [
      {
        'title': 'Divide',
        'artist': 'Ed Sheeran',
        'image': 'assets/ed_sheeran.jpg',
        'songs': [
          {'title': 'Shape of You', 'artist': 'Ed Sheeran'},
          {'title': 'Castle on the Hill', 'artist': 'Ed Sheeran'},
          {'title': 'Galway Girl', 'artist': 'Ed Sheeran'},
          {'title': 'Perfect', 'artist': 'Ed Sheeran'},
          {'title': 'Happier', 'artist': 'Ed Sheeran'},
        ]
      },
      {
        'title': '25',
        'artist': 'Adele',
        'image': 'assets/adele.jpg',
        'songs': [
          {'title': 'Hello', 'artist': 'Adele'},
          {'title': 'When We Were Young', 'artist': 'Adele'},
          {'title': 'Send My Love (To Your New Lover)', 'artist': 'Adele'},
          {'title': 'Water Under The Bridge', 'artist': 'Adele'},
          {'title': 'I Miss You', 'artist': 'Adele'},
        ]
      },
      {
        'title': 'After Hours',
        'artist': 'The Weeknd',
        'image': 'assets/weeknd.jpg',
        'songs': [
          {'title': 'Blinding Lights', 'artist': 'The Weeknd'},
          {'title': 'Save Your Tears', 'artist': 'The Weeknd'},
          {'title': 'In Your Eyes', 'artist': 'The Weeknd'},
          {'title': 'Heartless', 'artist': 'The Weeknd'},
          {'title': 'After Hours', 'artist': 'The Weeknd'},
          {'title': 'Too Late', 'artist': 'The Weeknd'},
        ]
      },
      {
        'title': '24K Magic',
        'artist': 'Bruno Mars',
        'image': 'assets/bruno_mars.jpg',
        'songs': [
          {'title': 'Uptown Funk', 'artist': 'Mark Ronson ft. Bruno Mars'},
          {'title': '24K Magic', 'artist': 'Bruno Mars'},
          {'title': 'That’s What I Like', 'artist': 'Bruno Mars'},
          {'title': 'Finesse', 'artist': 'Bruno Mars ft. Cardi B'},
          {'title': 'Versace on the Floor', 'artist': 'Bruno Mars'},
        ]
      },
      {
        'title': 'Terlintas',
        'artist': 'Bernadya',
        'image': 'assets/bernadya.jpg',
        'songs': [
          {'title': 'Terlintas', 'artist': 'Bernadya'},
          {'title': 'Sinyal - Sinyal', 'artist': 'Bernadya'},
          {'title': 'Satu Bulan', 'artist': 'Bernadya'},
          {'title': 'Masa Sepi', 'artist': 'Bernadya'},
          {'title': 'Apa Mungkin', 'artist': 'Bernadya'},
        ]
      },
      {
        'title': 'Nonfiksi',
        'artist': 'Juicy Luicy',
        'image': 'assets/juicy_luicy.jpg',
        'songs': [
          {'title': 'Asing', 'artist': 'Juicy Luicy'},
          {'title': 'Cuma Sama Kamu', 'artist': 'Juicy Luicy'},
          {'title': 'HAHAHA', 'artist': 'Juicy Luicy'},
          {'title': 'Sayangnya', 'artist': 'Juicy Luicy'},
          {'title': 'Lampu Kuning', 'artist': 'Juicy Luicy'},
        ]
      },
      {
        'title': 'Folklore',
        'artist': 'Taylor Swift',
        'image': 'assets/taylor_swift.jpg',
        'songs': [
          {'title': 'Cardigan', 'artist': 'Taylor Swift'},
          {'title': 'Exile', 'artist': 'Taylor Swift ft. Bon Iver'},
          {'title': 'Betty', 'artist': 'Taylor Swift'},
          {'title': 'Invisible String', 'artist': 'Taylor Swift'},
          {'title': 'August', 'artist': 'Taylor Swift'},
        ]
      },
      {
        'title': 'Changes',
        'artist': 'Justin Bieber',
        'image': 'assets/justin_bieber.jpg',
        'songs': [
          {'title': 'Yummy', 'artist': 'Justin Bieber'},
          {'title': 'Intentions', 'artist': 'Justin Bieber ft. Quavo'},
          {
            'title': 'Peaches',
            'artist': 'Justin Bieber ft. Daniel Caesar, Giveon'
          },
          {'title': 'Holy', 'artist': 'Justin Bieber ft. Chance the Rapper'},
          {'title': 'Lonely', 'artist': 'Justin Bieber & benny blanco'},
        ]
      }
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: albums.length,
        shrinkWrap: false,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumSongsScreen(
                      albumTitle: albums[index]['title']!,
                      songs: List<Map<String, String>>.from(
                          albums[index]['songs']),
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      albums[index]['image'],
                      fit: BoxFit.cover,
                      height: 120,
                      width: 140,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    albums[index]['title'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    albums[index]['artist'],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingView() {
    final List<Map<String, String>> trendingSongs = [
      {'title': 'APT.', 'artist': 'ROSÉ ft. Bruno Mars'},
      {'title': 'Satu Bulan', 'artist': 'Bernadya'},
      {'title': 'Die With A Smile', 'artist': 'Lady Gaga ft. Bruno Mars'},
      {'title': 'Untungnya, Hidup Harus Tetap Berjalan', 'artist': 'Bernadya'},
      {'title': 'Gala Bunga Matahari', 'artist': 'Sal Priadi'},
      {'title': 'Uptown Funk', 'artist': 'Mark Ronson ft. Bruno Mars'},
      {'title': 'Hello', 'artist': 'Adele'},
      {'title': 'Sialan', 'artist': 'Adrian Khalif ft. Juicy Luicy'},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Songs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingSongs.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                radius: 15,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Playing "${trendingSongs[index]['title']}" by ${trendingSongs[index]['artist']}'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            trendingSongs[index]['title']!,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            trendingSongs[index]['artist']!,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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

  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/naufal.jpg'),
          ),
          const SizedBox(height: 20),
          Text('Username: ${widget.username}',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text('Email: ${widget.email}', style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
