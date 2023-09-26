import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';

import 'miniz_exceptions.dart';
import 'miniz_const.dart';
import 'miniz_enums.dart';
import 'miniz_ffi.dart';

class Miniz {
  Miniz._();

  static MinizFFI _minizFFI = MinizFFI(version: MinizVersion.v3);

  static MinizVersion get version => _minizFFI.version;
  static void setVersion(MinizVersion version) => _minizFFI = MinizFFI(version: version);

  static List<int> compress(List<int> bytes, {MinizCompressionLvl level = MinizCompressionLvl.defaultLevel}) {
    final outputData = <int>[];

    // create tdefl() compatible flags (we have to compose the low-level flags ourselves, or use tdefl_create_comp_flags_from_zip_params() but that means MINIZ_NO_ZLIB_APIS can't be defined).
    int compFlags = TDEFL_WRITE_ZLIB_HEADER | s_tdefl_num_probes[level.code] | ((level.code <= 3) ? TDEFL_GREEDY_PARSING_FLAG : 0);
    if (level.code <= 0) compFlags |= TDEFL_FORCE_ALL_RAW_BLOCKS;

    // Initialize the low-level compressor.
    final gDeflator = malloc.allocate(_minizFFI.tdeflCompressorSize());

    int status = _minizFFI.tdeflInit(gDeflator, nullptr, nullptr, compFlags);
    if (status != 0) {
      malloc.free(gDeflator);
      throw MiniZCompressException("tdefl_init", status);
    }

    // Initialize buffers
    final sInbuf = malloc<Uint8>(IN_BUF_SIZE);
    final sOutbuf = malloc<Uint8>(OUT_BUF_SIZE);

    // Compression
    int availIn = 0;
    int availOut = COMP_OUT_BUF_SIZE;
    var nextIn = sInbuf;
    var nextOut = sOutbuf;
    bool flush = false;
    int offset = 0;
    do {
      if ((availIn == 0) && !flush) {
        nextIn = sInbuf;
        availIn = min(IN_BUF_SIZE, bytes.sublist(offset).length);

        for (var i = offset; i < (offset + availIn); i++) {
          sInbuf.elementAt(i).value = bytes[i];
        }

        flush = availIn < IN_BUF_SIZE; //Detect end of data
        offset += IN_BUF_SIZE;
      }

      final inBytes = malloc<Size>()..value = availIn;
      final outBytes = malloc<Size>()..value = availOut;

      // Compress as much of the input as possible (or all of it) to the output buffer.
      int status = _minizFFI.tdeflCompress(gDeflator, nextIn, inBytes, nextOut, outBytes, flush ? TDEFL_FINISH : TDEFL_NO_FLUSH);

      nextIn = nextIn.elementAt(inBytes.value);
      availIn -= inBytes.value;

      nextOut = nextOut.elementAt(outBytes.value);
      availOut -= outBytes.value;

      if ((status != TDEFL_STATUS_OKAY) || (availOut <= 0)) {
        // Output buffer is full, or compression is done or failed, so write buffer to output file.
        outputData.addAll([for (int i = 0; i < COMP_OUT_BUF_SIZE - availOut; i++) sOutbuf.elementAt(i).value]);

        nextOut = sOutbuf;
        availOut = COMP_OUT_BUF_SIZE;
      }

      if (status == TDEFL_STATUS_DONE) {
        malloc.free(gDeflator);
        malloc.free(sInbuf);
        malloc.free(sOutbuf);
        malloc.free(inBytes);
        malloc.free(outBytes);
        return outputData;
      } else if (status != TDEFL_STATUS_OKAY) {
        malloc.free(gDeflator);
        malloc.free(sInbuf);
        malloc.free(sOutbuf);
        malloc.free(inBytes);
        malloc.free(outBytes);
        throw MiniZCompressException("tdefl_compress", status);
      }
    } while (true);
  }

  static List<int> uncompress(List<int> bytes) {
    return [];
  }
}
