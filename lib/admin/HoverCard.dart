import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HoverCard extends StatefulWidget {
  final dynamic esm;
  final dynamic sura;
  final dynamic screen;

  const HoverCard(this.esm, this.sura, this.screen);


  @override
  _HoverCardState createState() => _HoverCardState(esm, sura, screen);
}

class _HoverCardState extends State<HoverCard> {
  dynamic esm;
  dynamic sura;
  dynamic screen;
  _HoverCardState(this.esm, this.sura, this.screen);

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(

          color: isHovered ? HexColor("#131734") : Colors.purple,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.blue.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle tap event here
              print('Card clicked!');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    sura,
                    color: Colors.white,
                    size: 130, // Adjust the size as needed
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 200,
                    height: 100,
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      esm,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isHovered ? Colors.white : Colors.white,
                      ),
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