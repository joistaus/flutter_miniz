abstract class MiniZException implements Exception {
  final String componentName;
  final int status;

  const MiniZException(this.componentName, this.status);
}

class MiniZCompressException extends MiniZException {
  MiniZCompressException(super.componentName, super.status);

  @override
  String toString() => 'MiniZ compression routine $componentName failed with error code $status.';
}

class MiniZDecompressException extends MiniZException {
  MiniZDecompressException(super.componentName, super.status);

  @override
  String toString() => 'MiniZ decompression routine $componentName failed with error code $status.';
}
