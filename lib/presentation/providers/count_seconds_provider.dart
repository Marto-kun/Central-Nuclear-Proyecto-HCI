import 'package:flutter_riverpod/flutter_riverpod.dart';

final countSeconsStreamProvider = StreamProvider.autoDispose<double>((ref) async*{

  double seconds = 30;
  
  yield* Stream.periodic((Duration(seconds: 1)), (count){
    
    if (seconds == 0) return 0.0;
    
    count = 1;
    return seconds = seconds - count;
  }).take(30);

});