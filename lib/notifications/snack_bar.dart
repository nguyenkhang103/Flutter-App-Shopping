import 'package:flutter/material.dart';

class ToastSuccess extends StatelessWidget {
  final String title;

  const ToastSuccess({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white,),
          SizedBox(
            width: 12.0,
          ),
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        ],
      ),
    );
  }
}

class ToastFailed extends StatelessWidget {
  final String title;

  const ToastFailed({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline,color: Colors.white,),
          SizedBox(
            width: 12.0,
          ),
          Text(title, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
        ],
      ),
    );
  }
}


