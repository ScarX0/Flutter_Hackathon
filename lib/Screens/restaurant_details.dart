import 'package:flutter/material.dart' ;
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class restaurant_details extends StatefulWidget {
final String title ;
  const restaurant_details({Key? key, required this.title}) : super(key: key);

  @override
  State<restaurant_details> createState() => _restaurant_detailsState();
}

class _restaurant_detailsState extends State<restaurant_details> {
  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff582e44),

        title: Center(child: Text('مطعم الرحمة')),
        actions: [
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () {Navigator.pop(context);},
            ),
          )
        ],
      ),

      body: Container(
        height: sizee.height,
        width: sizee.width,
        margin: EdgeInsets.only( top: sizee.height*0.04 , bottom: sizee.height*0.05),
        child: Column(children: [
          Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(
                   padding: EdgeInsets.symmetric( vertical: sizee.height*0.02),
                   height: sizee.height*0.3,
                   width: sizee.width*0.35,
                   child: Column(children: [
                   Container(
                       width: sizee.width*0.35,
                       decoration: BoxDecoration(
                       color: Color(0xffbd7344) ,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.05),
                             spreadRadius: 5,
                             blurRadius: 10,
                             offset: const Offset(0, 3), // changes position of shadow
                           ),
                         ],
                         borderRadius: const BorderRadius.only(
                             topRight: Radius.circular(20),
                             bottomRight: Radius.circular(20)
                         ),
                       ),
                       child: Center(child: Text('تيغنيف , معسكر ' ,style: TextStyle(color:Colors.white),))) ,
                     Container(
                         width: sizee.width*0.35,
                         margin: EdgeInsets.symmetric(vertical: sizee.height*0.012),
                         decoration: BoxDecoration(
                           color: Color(0xffbd7344) ,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.05),
                               spreadRadius: 5,
                               blurRadius: 10,
                               offset: const Offset(0, 3), // changes position of shadow
                             ),
                           ],
                           borderRadius: const BorderRadius.only(
                               topRight: Radius.circular(20),
                               bottomRight: Radius.circular(20)
                           ),
                         ),
                         child: Center(child: Text('متوفر 20 مقعد ' ,style: TextStyle(color:Colors.white),))) ,
                     Container(
                         width: sizee.width*0.15,
                         margin: EdgeInsets.symmetric(vertical: sizee.height*0.02),
                         decoration: BoxDecoration(
                           color: Color(0xff582e44) ,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.05),
                               spreadRadius: 5,
                               blurRadius: 10,
                               offset: const Offset(0, 3), // changes position of shadow
                             ),
                           ],
                           borderRadius: const BorderRadius.all(
                               Radius.circular(20),
                           ),
                         ),
                         child: Center(child:IconButton(
                           icon: Icon(
                             Icons.call,
                             color: Colors.white,
                           ),
                           onPressed: () {
                             launch(
                                 ('tel:+213658850774'));
                           },
                         ),)) ,
                     Container(
                         width: sizee.width*0.15,
                         margin: EdgeInsets.symmetric(vertical: sizee.height*0.0),
                         decoration: BoxDecoration(
                           color: Color(0xff582e44) ,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.05),
                               spreadRadius: 5,
                               blurRadius: 10,
                               offset: const Offset(0, 3), // changes position of shadow
                             ),
                           ],
                           borderRadius: const BorderRadius.all(
                             Radius.circular(20),
                           ),
                         ),
                         child: Center(child:IconButton(
                           icon: Icon(
                             Icons.place,
                             color: Colors.white,
                           ),
                           onPressed: () {
                             launchMap() ;

                           },
                         ),)) ,
                   ],)) ,
                Container(
                  height: sizee.height*0.3,
                  width: sizee.width*0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/restaurant.jpg"),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                    ),
                  ),
                ) ,
              ],
            ),

          ) ,
          Container(
            padding: EdgeInsets.symmetric(vertical: sizee.height*0.03 , horizontal: sizee.width*0.03),
            margin  : EdgeInsets.symmetric(vertical: sizee.height*0.05 , horizontal: sizee.width*0.05),
            decoration: BoxDecoration(
              color: Color(0xffbd7344).withOpacity(0.3) ,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: sizee.height*0.3,
            child: Column(

              children: [
              Center(child: Text('قائمة اليوم' ,style: TextStyle(fontWeight: FontWeight.bold),)),
                Container(
                  width: sizee.width*0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Text('الحساء ')  ,
                    Text('الطبق الاول ')  ,
                      Text('الطبق الثاني ')  ,
                      Text('المقبلة')  ,
                    Text('التحلية ')  ,
                    Text('اخرى  ')  ,

                  ],),
                )

            ],),
          ) ,
          Container(
            margin  : EdgeInsets.symmetric(vertical: sizee.height*0.00 , horizontal: sizee.width*0.05),
            decoration: BoxDecoration(
              color: Color(0xffa8293c).withOpacity(0.3) ,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: sizee.height*0.08,
          child: Center(child: Text('نحتاج 15 متطوع للمشاركة في هذا العمل الخيري ' ,style: TextStyle(fontWeight: FontWeight.bold),),),) ,
        ],),
      ),
    );
  }

  launchMap({String lat = "47.6", String long = "-122.3"}) async{
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }

}
