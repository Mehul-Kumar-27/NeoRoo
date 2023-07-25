import 'package:flutter/material.dart';
class GraphHeader extends StatelessWidget {
  const GraphHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 19.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(110, 42, 127, 1)),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Skin-Skin',
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            width: 11,
          ),
          Row(
            children: [
              Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(196, 196, 196, 1)),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Non Skin-Skin',
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    );
  }
}
