import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFFAF8F7),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: const Color(0xffF0E7E3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'BOOK APPOINTMENT',
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        // fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    // SizedBox(width: 10),
                    IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_right_alt_sharp),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'About',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Services',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Bridal',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Contact',
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | Makeup Star Studio',
                    style: TextStyle(
                      color: Colors.brown[400],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
