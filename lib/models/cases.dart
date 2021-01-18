import 'package:flutter/foundation.dart';

enum Status {
  open,
  closed,
}

enum Stage {
  assign_case,
  waiting_introduction,
  collecting_evidence,
  preparing_packet,
  attorney_review,
  review_signatures,
  filed,
  pending,
  on_hold,
  pending_payment,
  upcoming_hearing,
  upcoming_trial
}

class Cases {
  const Cases({
    @required this.state,
    @required this.id,
    @required this.stage,
    @required this.name,
    @required this.number,
    @required this.added,
  })  : assert(state != null),
        assert(id != null),
        assert(stage != null),
        assert(name != null),
        assert(number != null),
        assert(added != null);

  final Status state;
  final int id;
  final Stage stage;
  final String name;
  final String number;
  final String added;

  String get assetName => '$id-0.jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() => '$name (id == $id)';
}
