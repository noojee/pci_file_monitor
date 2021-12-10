#! /usr/bin/env dcli

// ignore: prefer_relative_imports
import 'package:batman/src/hive/model/file_checksum.dart';

/// dcli script generated by:
/// dcli create checksum.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main(List<String> args) {
  print(DateTime.now());
  FileChecksum.contentChecksum(
      '/home/bsutton/git/batman.bak/batman/test/sample_logs/njcontact.log');
  print(DateTime.now());
}
