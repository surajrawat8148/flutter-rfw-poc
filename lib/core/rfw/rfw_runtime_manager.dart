import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwRuntimeManager {
  static final RfwRuntimeManager _instance = RfwRuntimeManager._internal();

  factory RfwRuntimeManager() {
    return _instance;
  }

  RfwRuntimeManager._internal() {
    _runtime.update(
      const LibraryName(['core', 'widgets']),
      createCoreWidgets(),
    );
    _runtime.update(
      const LibraryName(['material', 'widgets']),
      createMaterialWidgets(),
    );
  }

  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  Runtime get runtime => _runtime;
  DynamicContent get data => _data;

  void updateLibrary(String libraryName, String libraryCode) {
    try {
      final library = parseLibraryFile(libraryCode);
      _runtime.update(LibraryName(libraryName.split('.')), library);
    } catch (e) {
      debugPrint('Error parsing RFW library: $e');
      rethrow;
    }
  }

  void updateLibraryFromBytes(String libraryName, Uint8List bytes) {
    try {
      // Try treating as binary first
      try {
        final library = decodeLibraryBlob(bytes);
        _runtime.update(LibraryName(libraryName.split('.')), library);
      } catch (_) {
         // Fallback to text parsing
         try {
           final text = utf8.decode(bytes);
           updateLibrary(libraryName, text);
         } catch (e) {
           debugPrint('Error decoding RFW library as UTF-8 text: $e');
           rethrow;
         }
      }
    } catch (e) {
      debugPrint('Error decoding RFW library from bytes: $e');
      rethrow;
    }
  }
}
