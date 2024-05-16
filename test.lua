local var = { "plugin/name", hello = "there" }

-- 1   latin1	8-bit characters (ISO 8859-1, also used for cp1252)
-- 1   iso-8859-n	ISO_8859 variant (n = 2 to 15)
-- 1   koi8-r	Russian
-- 1   koi8-u	Ukrainian
-- 1   macroman    MacRoman (Macintosh encoding)
-- 1   8bit-{name} any 8-bit encoding (Vim specific name)
-- 1   cp437	similar to iso-8859-1
-- 1   cp737	similar to iso-8859-7
-- 1   cp775	Baltic
-- 1   cp850	similar to iso-8859-4
-- 1   cp852	similar to iso-8859-1
-- 1   cp855	similar to iso-8859-2
-- 1   cp857	similar to iso-8859-5
-- 1   cp860	similar to iso-8859-9
-- 1   cp861	similar to iso-8859-1
-- 1   cp862	similar to iso-8859-1
-- 1   cp863	similar to iso-8859-8
-- 1   cp865	similar to iso-8859-1
-- 1   cp866	similar to iso-8859-5
-- 1   cp869	similar to iso-8859-7
-- 1   cp874	Thai
-- 1   cp1250	Czech, Polish, etc.
-- 1   cp1251	Cyrillic
-- 1   cp1253	Greek
-- 1   cp1254	Turkish
-- 1   cp1255	Hebrew
-- 1   cp1256	Arabic
-- 1   cp1257	Baltic
-- 1   cp1258	Vietnamese
-- 1   cp{number}	MS-Windows: any installed single-byte codepage
-- 2   cp932	Japanese (Windows only)
-- 2   euc-jp	Japanese
-- 2   sjis	Japanese
-- 2   cp949	Korean
-- 2   euc-kr	Korean
-- 2   cp936	simplified Chinese (Windows only)
-- 2   euc-cn	simplified Chinese
-- 2   cp950	traditional Chinese (alias for big5)
-- 2   big5	traditional Chinese (alias for cp950)
-- 2   euc-tw	traditional Chinese
-- 2   2byte-{name} any double-byte encoding (Vim-specific name)
-- 2   cp{number}	MS-Windows: any installed double-byte codepage
-- u   utf-8	32 bit UTF-8 encoded Unicode (ISO/IEC 10646-1)
-- u   ucs-2	16 bit UCS-2 encoded Unicode (ISO/IEC 10646-1)
-- u   ucs-2le	like ucs-2, little endian
-- u   utf-16	ucs-2 extended with double-words for more characters
-- u   utf-16le	like utf-16, little endian
-- u   ucs-4	32 bit UCS-4 encoded Unicode (ISO/IEC 10646-1)
-- u   ucs-4le	like ucs-4, little endian

vim.api.nvim_echo({ { "hello" }, { "There" } }, false, {})
