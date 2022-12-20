
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Stack buildTop() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: buildCoverImage(),
        ),
        Positioned(
          left: 10,
          top: 60,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              )),
        ),
        Positioned(
          right: 50,
          top: 60,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.heart,
                color: Colors.white,
              )),
        ),
        Positioned(
          right: 10,
          top: 60,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.cartShopping,
                color: Colors.white,
              )),
        ),
        Positioned(
          top: 180,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          const Text(
            'Ítalo Patrício',
            style: TextStyle(fontSize: 25.0),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Alguma descrição xablautonada dos xablautons, desksv mussum ipsum, vidris abertis. Cacildies litris.',
            style: TextStyle(fontSize: 14.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 4,
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: ListTile(
                  title: Text('Item $index'),
                  subtitle: const Text('description about option'),
                  trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Container buildProfileImage() {
    return Container(
      height: 150.0,
      width: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: const DecorationImage(
          image: NetworkImage(
              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(1.0, 1.0))
        ],
        border: Border.all(
          width: 4,
          color: Colors.amberAccent,
        ),
      ),
    );
  }

  Image buildCoverImage() {
    return Image.network(
      'https://media.istockphoto.com/id/942152116/pt/foto/thar-desert-jaisalmer-rajasthan-india-at-sunset-with-moody-sky.jpg?b=1&s=170667a&w=0&k=20&c=c_sfGC9Mxmw2h6-YwZADfHL-zAbfZ-pBYIflhwU56Ro=',
    );
  }
}
