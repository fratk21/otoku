import 'package:flutter/material.dart';
import 'package:otoku/models/pagemodel.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  @override
  Widget build(BuildContext context) {
    return pagemodel(
        AppBar: AppBar(),
        Widget: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/image/anime.png'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Kullanıcı Adı',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Takipçi: 100'),
                      SizedBox(width: 20.0),
                      Text('Takip: 50'),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Takip Et düğmesine basıldığında yapılacak işlem burada gerçekleştirilebilir.
                        },
                        child: Text('Takip Et'),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Mesaj At düğmesine basıldığında yapılacak işlem burada gerçekleştirilebilir.
                        },
                        child: Text('Mesaj At'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
