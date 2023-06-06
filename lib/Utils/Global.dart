

import 'package:flutter/material.dart';
import 'package:learn_flutter/Components/NeumorphismContainer.dart';

import '../Components/GradientText.dart';
import 'Constant.dart';

showSnackbar(context, message, { String type = 'error'}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          // height: 70,
          decoration: const BoxDecoration(
            // color: Colors.g,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: NeumorphismContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: type == 'error' ? const Icon(Icons.dangerous, color: Colors.red,)
                    : const Icon(Icons.check, color: Colors.green,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GradientText(
                        //   'Oops Error!',
                        //   style: TextStyle(
                        //       fontSize: 18,
                        //   ),
                        //   gradient: redGradient,
                        // ),
                        GradientText(
                          gradient: type == 'error' ?  redGradient : greenGradient,
                          '$message',
                          style: const TextStyle(
                              fontSize: 14,
                          ),
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //     bottom: 25,
        //     left: 20,
        //     child: ClipRRect(
        //       child: Stack(
        //         children: [
        //           Icon(
        //             Icons.circle,
        //             color: Colors.red.shade200,
        //             size: 17,
        //           )
        //         ],
        //       ),
        //     )),
        // Positioned(
        //     top: -20,
        //     left: 5,
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: [
        //         Container(
        //           height: 30,
        //           width: 30,
        //           decoration: const BoxDecoration(
        //             color: Colors.red,
        //             borderRadius:
        //             BorderRadius.all(Radius.circular(15)),
        //           ),
        //         ),
        //         const Positioned(
        //             top: 5,
        //             child: Icon(
        //               Icons.clear_outlined,
        //               color: Colors.white,
        //               size: 20,
        //             ))
        //       ],
        //     )),
      ],
    ),
  ));
}