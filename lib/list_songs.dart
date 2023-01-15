import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app_v0/detail_audio_page.dart';
import 'app_colors.dart' as AppColors;

class listSongs extends StatelessWidget {
  final List songs;
  const listSongs({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          //aqui comienza el list view de las caniones
          itemCount: songs == null ? 0 : songs.length,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailAudioPage(songsData: songs, index: i)));
              },
              child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.tabVarViewColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 0),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(children: [
                        Container(
                          width: 90,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.tabVarViewColor2, width: 5),
                              image: DecorationImage(
                                  image: AssetImage(songs[i]["img"]),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: AppColors.starColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  songs[i]["rating"],
                                  style: TextStyle(color: AppColors.menu2Color),
                                )
                              ],
                            ),
                            Text(
                              songs[i]["title"],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              songs[i]["text"],
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Avenir",
                                  color: AppColors.subTitleText),
                            ),
                            Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: AppColors.loveColor),
                              child: Text(
                                "Love",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Avenir",
                                    color: Colors.white),
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        )
                      ]),
                    ),
                  )),
            );
          }),
    );
  }
}
