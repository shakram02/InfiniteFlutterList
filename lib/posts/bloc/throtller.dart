import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

//
// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return debounce<E>().call(events.throttle(duration), mapper);
//   };
// }

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).asyncExpand(mapper);
  };
}
