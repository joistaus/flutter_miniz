import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:path/path.dart' as path;

import 'miniz_enums.dart';

class MinizFFI {
  final MinizVersion version;

  late final tdeflCompressorSize = _minizLib.lookupFunction<Size Function(), int Function()>('tdefl_compressor_size');

  late final tinflDecompressorSize = _minizLib.lookupFunction<Size Function(), int Function()>('tinfl_decompressor_size');

  late final tdeflInit = _minizLib.lookupFunction<
      Uint32 Function(
        Pointer,
        Pointer,
        Pointer<Void>,
        Int32,
      ),
      int Function(
        Pointer,
        Pointer,
        Pointer<Void>,
        int,
      )>('tdefl_init');

  late final tdeflCompress = _minizLib.lookupFunction<
      Uint32 Function(
        Pointer,
        Pointer,
        Pointer<Size>,
        Pointer,
        Pointer<Size>,
        Uint32,
      ),
      int Function(
        Pointer,
        Pointer,
        Pointer<Size>,
        Pointer,
        Pointer<Size>,
        int,
      )>('tdefl_compress');

  late final tinflDecompress = _minizLib.lookupFunction<
      Uint32 Function(
        Pointer,
        Pointer<Uint8>,
        Pointer<Size>,
        Pointer<Uint8>,
        Pointer<Uint8>,
        Pointer<Size>,
        Uint32,
      ),
      int Function(
        Pointer,
        Pointer<Uint8>,
        Pointer<Size>,
        Pointer<Uint8>,
        Pointer<Uint8>,
        Pointer<Size>,
        int,
      )>('tinfl_decompress');

  late final DynamicLibrary _minizLib = DynamicLibrary.open(_minizPath);

  MinizFFI({required this.version});

  String get _libName {
    switch (version) {
      case MinizVersion.v3:
        return 'miniz_v3';
      case MinizVersion.v2:
        return 'miniz_v2';
    }
  }

  String get _minizPath {
    if (Platform.isMacOS || Platform.isIOS) {
      if (Platform.environment.containsKey('FLUTTER_TEST')) {
        return ('build/macos/Build/Products/Debug'
            '/$_libName/$_libName.framework/$_libName');
      }
      return ('$_libName.framework/$_libName');
    }
    if (Platform.isAndroid || Platform.isLinux) {
      if (Platform.environment.containsKey('FLUTTER_TEST')) {
        return ('build/linux/x64/debug/bundle/lib/lib$_libName.so');
      }
      return ('lib$_libName.so');
    }
    if (Platform.isWindows) {
      if (Platform.environment.containsKey('FLUTTER_TEST')) {
        return (path.canonicalize(path.join(r'build\windows\runner\Debug', '$_libName.dll')));
      }
      return ('$_libName.dll');
    }
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}
