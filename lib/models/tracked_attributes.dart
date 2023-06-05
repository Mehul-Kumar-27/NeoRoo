// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'tracked_attributes.g.dart';

@HiveType(typeId: 3)
class TrackedAttributes {
  @HiveField(0)
  final String trackedAttributeNameId;
  @HiveField(1)
  final String trackedAttributeName;
  TrackedAttributes({
    required this.trackedAttributeNameId,
    required this.trackedAttributeName,
  });
}
