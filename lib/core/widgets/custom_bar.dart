import 'package:flutter/material.dart';

class Custombar extends StatelessWidget {
  const Custombar({super.key, required this.title, this.onTap});
 final String title ;
 final void Function()? onTap ;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 8),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text("view all",style: TextStyle(
                  color: Colors.grey
                ),),
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
