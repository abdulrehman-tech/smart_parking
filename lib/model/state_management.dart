import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentStep = StateProvider((ref)=> 1);
final selectedMall = StateProvider((ref)=> '');
final selectedFloor = StateProvider((ref)=> '');
final selectedSlot = StateProvider((ref)=> '');