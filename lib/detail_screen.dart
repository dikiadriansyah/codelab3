import 'package:codelab1/model/tourism_place.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');
// Anda dapat menggunakan variabel untuk menyimpan TextStyle dan meringkas kode.

class DetailScreen extends StatelessWidget{
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}): super(key: key);

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        if(constraints.maxWidth > 800){
          return DetailWebPage(place: place);
        }else{
          return DetailMobilePage(place: place);
        }
      },
    );
  }

}

class FavoriteButton extends StatefulWidget{
  const FavoriteButton({Key? key}): super(key: key);


  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();

}
class _FavoriteButtonState extends State<FavoriteButton>{
  bool isFavorite = false;

  @override
  Widget build(BuildContext context){
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: (){
        setState((){
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

class DetailMobilePage extends StatelessWidget{
  final TourismPlace place;

  const DetailMobilePage({Key? key, required this.place}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: SingleChildScrollView(
        /*
          Widget ini membutuhkan satu child yang nantinya bisa di-scroll pada layar.
          Pindahkan widget Column ke dalam SingleChildScrollView supaya nantinya bisa di-scroll.
           */

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Stack(
              children: <Widget>[
                Image.asset(place.imageAsset),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),

            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Staatliches',
                    //  parameter fontFamily pada widget TextStyle untuk menerapkan style pada Text

                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      const SizedBox(height: 8.0),
                      Text(
                        place.openDays,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.access_time_rounded),
                      const SizedBox(height: 8.0),
                      Text(
                        place.openTime,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(height: 8.0),
                      Text(
                        place.ticketPrice,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Oxygen'
                ),
              ),
            ),

            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // untuk mengubahnya menjadi horizontal kita cukup menambahkan parameter scrollDirection bernilai Axis.horizontal.

                children: place.imageUrls.map((url){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      // mengambil gambar melalui url
                      child: Image.network(url),
                    ),
                  );

                  // tambahkan Padding pada masing-masing Image supaya antar gambar tidak terlalu rapat.
                }).toList(),
              ),
              //   ListView diletakkan di dalam Column, di mana keduanya sama-sama memiliki atribut height yang memakan space di sepanjang layar. Sebagai solusi kita perlu memberikan ukuran tinggi yang statis terhadap ListView. Namun ListView tidak memiliki parameter height, lantas bagaimana nih? Caranya, gunakan widget lain yang memiliki parameter height. Anda dapat membungkus widget ListView ke dalam Container atau pun SizedBox. Ukuran tinggi ini nantinya juga digunakan sebagai tinggi Image yang tampil.
            ),
          ],
        ),
      ),
    );
  }
}
class DetailWebPage extends StatefulWidget{
  final TourismPlace place;

  const DetailWebPage({Key? key, required this.place}): super(key: key);

 @override
  _DetailWebPageState createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage>{
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: kIsWeb ? null : AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
          child: Center(
            child: SizedBox(
              width: screenWidth <= 1200 ? 800 : 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Wisata Bandung',style: TextStyle(fontFamily: 'Staatliches', fontSize: 32)),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.asset(widget.place.imageAsset),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(height: 16),
                            Scrollbar(
                              controller: _scrollController,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ListView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: widget.place.imageUrls.map((url){
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(url),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(widget.place.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30.0, fontFamily: 'Staatliches')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.calendar_today),
                                        const SizedBox(width: 8.0),
                                        Text(widget.place.openDays, style: informationTextStyle)
                                      ],
                                    ),
                                    const FavoriteButton(),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: 8.0),
                                    Text(widget.place.openTime, style: informationTextStyle),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.monetization_on),
                                    const SizedBox(width: 8.0),
                                    Text(widget.place.ticketPrice, style: informationTextStyle)
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    widget.place.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Oxygen'
                                    ),
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]
              ),
            ),
          ),
        )
    );
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

}

