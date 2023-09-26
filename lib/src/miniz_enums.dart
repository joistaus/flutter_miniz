enum MinizVersion {
  v2,
  v3,
}

enum MinizCompressionLvl {
  noCompression(0),
  bestSpeed(1),
  defaultLevel(6),
  bestCompression(9),
  uberCompression(10);

  const MinizCompressionLvl(this.code);
  final int code;
}
