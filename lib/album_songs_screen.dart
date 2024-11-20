import 'package:flutter/material.dart';

class AlbumSongsScreen extends StatelessWidget {
  final String albumTitle;
  final List<Map<String, String>> songs;

  const AlbumSongsScreen(
      {super.key, required this.albumTitle, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumTitle),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(songs[index]['title']!),
              subtitle: Text('Artist: ${songs[index]['artist']}'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Playing ${songs[index]['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
