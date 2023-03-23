import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';

class CachedNetworkImagePage extends StatelessWidget {
  CachedNetworkImagePage({super.key});

  final imageUrl =
      List<String>.generate(80, (i) => "https://picsum.photos/id/$i/300/300");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar("ImagePage"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _myText("CachedNetworkImage"),
          _cachedImageGridView(context),
          _myText("Image.network"),
          _imageGridView(context),
        ],
      ),
    );
  }

  Widget _cachedImageGridView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width / 10 * 8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemCount: imageUrl.length,
        itemBuilder: (context, index) {
          return _cachedImage(index);
        },
      ),
    );
  }

  Widget _imageGridView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width / 10 * 8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemCount: imageUrl.length,
        itemBuilder: (context, index) {
          return _image(index);
        },
      ),
    );
  }

  Widget _cachedImage(int index) {
    return CachedNetworkImage(
      imageUrl: imageUrl[index],
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            strokeWidth: 4.0,
            color: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _image(int index) {
    return Image.network(
      imageUrl[index],
      fit: BoxFit.cover,
    );
  }

  Widget _myText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
