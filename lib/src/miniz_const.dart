// ignore_for_file: constant_identifier_names

// The number of dictionary probes to use at each compression level(0-10). 0=implies fastest/minimal possible probing.
const s_tdefl_num_probes = [0, 1, 6, 32, 16, 32, 128, 256, 512, 768, 1500];

// IN_BUF_SIZE is the size of the file read buffer.
// IN_BUF_SIZE must be >= 1
const int IN_BUF_SIZE = 1024 * 512;

// COMP_OUT_BUF_SIZE is the size of the output buffer used during compression.
// COMP_OUT_BUF_SIZE must be >= 1 and <= OutBugSize
const int COMP_OUT_BUF_SIZE = 1024 * 512;

// OUT_BUF_SIZE is the size of the output buffer used during decompression.
// OUT_BUF_SIZE must be a power of 2 >= TINFL_LZ_DICT_SIZE (because the low-level decompressor not only writes, but reads from the output buffer as it decompresses)
//#define OutBugSize (TINFL_LZ_DICT_SIZE)
const int OUT_BUF_SIZE = 1024 * 512;

const int TDEFL_HUFFMAN_ONLY = 0;
const int TDEFL_DEFAULT_MAX_PROBES = 128;
const int TDEFL_MAX_PROBES_MASK = 0xFFF;
const int TDEFL_WRITE_ZLIB_HEADER = 0x01000;
const int TDEFL_COMPUTE_ADLER32 = 0x02000;
const int TDEFL_GREEDY_PARSING_FLAG = 0x04000;
const int TDEFL_NONDETERMINISTIC_PARSING_FLAG = 0x08000;
const int TDEFL_RLE_MATCHES = 0x10000;
const int TDEFL_FILTER_MATCHES = 0x20000;
const int TDEFL_FORCE_ALL_STATIC_BLOCKS = 0x40000;
const int TDEFL_FORCE_ALL_RAW_BLOCKS = 0x80000;

const int TDEFL_STATUS_BAD_PARAM = -2;
const int TDEFL_STATUS_PUT_BUF_FAILED = -1;
const int TDEFL_STATUS_OKAY = 0;
const int TDEFL_STATUS_DONE = 1;

const int TDEFL_NO_FLUSH = 0;
const int TDEFL_SYNC_FLUSH = 2;
const int TDEFL_FULL_FLUSH = 3;
const int TDEFL_FINISH = 4;

const int TINFL_FLAG_PARSE_ZLIB_HEADER = 1;
const int TINFL_FLAG_HAS_MORE_INPUT = 2;
const int TINFL_FLAG_USING_NON_WRAPPING_OUTPUT_BUF = 4;
const int TINFL_FLAG_COMPUTE_ADLER32 = 8;

const int TINFL_STATUS_FAILED_CANNOT_MAKE_PROGRESS = -4;
const int TINFL_STATUS_BAD_PARAM = -3;
const int TINFL_STATUS_ADLER32_MISMATCH = -2;
const int TINFL_STATUS_FAILED = -1;
const int TINFL_STATUS_DONE = 0;
const int TINFL_STATUS_NEEDS_MORE_INPUT = 1;
const int TINFL_STATUS_HAS_MORE_OUTPUT = 2;
