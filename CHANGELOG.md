dlib 0.11.1 - 24 May, 2017
--------------------------
* Added `alphaOver` in `dlib.image.color`
* Fixed memory leak in `dlib.image.io.png`
* Deprecation fix: use `dlib.math.transformation` everywhere instead of `dlib.math.affine`. 

dlib 0.11.0 - 3 May, 2017
-------------------------
Changes from beta:
* Merged `idct.d` with `jpeg.d`, use `dlib.math.transformation` in `dlib.image.transform`
* Added `hdrTonemapAverageLuminance` to `dlib.image.hdri`
* Fixed memory leak in HDR decoder

dlib 0.11.0 beta1 - 25 Apr, 2017
--------------------------------
- **dlib.core**
  - `New` and `Delete` in `dlib.core.memory` are now based on allocators from `dlib.memory`. By default `Mallocator` is used. It is possible to switch global allocator.
- **dlib.memory**
  - Added `GCallocator`, an allocator based on on D's built-in garbage collector.
- **dlib.image**
  - Full-featured APNG support in `dlib.image.io.png` with dispose and blend operations. Saving animations to APNG is also supported.
- **dlib.filesystem**
  - Added `traverseDir`, GC-free recursive directory scanner.
- **dlib.math**
  - `distance` and `distancesqr` overloads for 2D vectors.
  - `dlib.math.affine` is now deprecated. `dlib.math.transformation` should be used instead.
- **dlib.async**
  - Fixed segfault in event loop.
- **Misc**
  - Removed deprecated `dlib.xml` package. `dlib.serialization.xml` should be used instead.
  - Added latest DMD (2.074.0) and LDC (1.2.0) to Travis CI config.
  - A new logo and homepage for the project: https://gecko0307.github.io/dlib. 

dlib 0.10.1 - 14 Mar, 2017
--------------------------
* Animated images and basic APNG support (unfinished, without dispose and blend operations, saving to APNG is also missing)
* Fixed some bugs in `dlib.text.slicelexer` and `dlib.serialization.xml`. `dlib.text.lexer.Lexer` is now an alias to `dlib.text.slicelexer.SliceLexer` 
* Added latest DMD (2.073.2) and LDC (1.1.0) to Travis CI config.

dlib 0.10.0 - 23 Jan, 2017
--------------------------
Changes from beta:
- 64-bit fix in `dlib.network.socket` under Windows
- Unittest fix in `dlib.filesystem.local`
- Code cleanup, use consistent line endings and indentations everywhere
- EditorConfig support
- dlib now compiles with DMD 2.073.0 and LDC 1.1.0-beta6.

dlib 0.10.0 beta1 - 13 Jan, 2017
--------------------------------
- **dlib.async** - this new package provides a cross-platform event loop and asynchronous programming capabilities. It can be used to implement asynchronous servers. Under the hood the package is based on different multiplexing APIs: Epoll on Linux, IOCP on Windows, and Kqueue on BSD / OSX
- **dlib.memory** - new tools and interfaces to generalize memory allocation. There is `Allocator` interface, similar to Phobos' `IAllocator`, but simpler. There are also several implementations of this interface: `Mallocator` (malloc based allocator) and `MmapPool` (block based allocator for Posix systems with mmap/munmap support).
- **dlib.serialization** - a new home for XML (and, hopefully, other markup languages in future). `dlib.xml` is deprecated, but left with public imports for compatibility purpose
  - XML parser (`dlib.serialization.xml`) is now fully GC-free
- **dlib.network**
  - `dlib.network.socket`, a cross-platform socket API. Supports Windows and Posix
- **dlib.image**
  - Breaking change: redesign of `dlib.image.hdri` module. Now it supports manual memory allocation and has its own image factories. Also implemented simple tone mapping tool based on gamma compression to convert HDR images to LDR
  - Radiance HDR/RGBE format support (only loading for now)
- **dlib.container**
  - New module - `dlib.container.buffer`, an interface for input/output buffers
  - Fixed some issues in `dlib.container.array`
- **dlib.text**
  - Improved `SliceLexer` (fixed bug with multicharacter delimiters)
  - Added `dlib.text.utils.immutableCopy`
- **dlib.math**
  - `dlib.math.vector.normal` is now `dlib.math.vector.planeNormal`
- **Other improvements**
  - Added latest DMD (2.072.2) to Travis CI config.

Many thanks to [Eugene Wissner](https://github.com/belka-ew) for implementing `dlib.async`, `dlib.memory` and `dlib.network`.

dlib 0.9.2 - 11 Jun, 2016
-------------------------
- Fixed building with DMD 2.071.1

dlib 0.9.1 - 9 Jun, 2016
------------------------
- Added `SliceLexer` in `dlib.text`
- Fixed wrong `opApply` in `DynamicArray` and `Trie`

dlib 0.9.0 - 23 May, 2016
-------------------------
Changes from beta:
- Bugfix and unittests for `ArrayStream`
- Fixed loading of 32-bit BMP with bitfield masks.

dlib 0.9.0 beta1 - 14 May, 2016
-------------------------------
- dlib.network
  - A new package for networking. So far it contains only one module, `dlib.network.url` - an URL parser
- dlib.image
  - 2-dimensional iteration for images. Also there are now `ImageRegion` and `ImageWindowRange` that simplify writing kernel filters
  - `dlib.image.transform` module implements affine transformations for images: translation, rotation and scaling. Transformation with arbitrary 3x3 matrix is also possible
  - Improved BMP and TGA support: new color modes and RLE8 for BMP, saving BMP and TGA
  - Improved `boxBlur`
  - `getPixel` and `setPixe` in `Image` class are now public
- dlib.math
  - New `dlib.math.tensor` module implements generic multidimensional array, both with static and dynamic memory allocation
- dlib.container
  - Improved `LinkedList`, added range interface. Added unittests for `LinkedList` and `DynamicArray`
- dlib.text
  - `UTF8Decoder` and `Lexer` now support range interface. Added unittests for both
- Other improvements 
  - Added latest DMD (2.071.0) to Travis CI config, added DUB service files to .gitignore.

dlib 0.8.1 - 13 Feb, 2016
-------------------------
Minor bugfix release: `saveWav` in `dlib.audio.io.wav` now uses `Sound` interface instead of `GenericSound` class.

dlib 0.8.0 - 12 Feb, 2016
-------------------------
Changes from beta:
* Fixed #87

dlib 0.8.0 beta1 - 7 Feb, 2016
------------------------------
* dlib.audio
  * `dlib.audio` is a new package for audio processing. Supports 8 and 16 bits per sample, arbitrary sample rate and number of channels. Includes generic sound interfaces (in-memory and streamed) and their implementations. Read more [here](https://github.com/gecko0307/dlib/wiki/dlib.audio).
  * `dlib.audio.synth` implements some basic sound synthesizers (sine wave and white noise)
  * `dlib.audio.io.wav` - uncompressed RIFF/WAV encoder and decoder
* dlib.image
  * All image filters, arithmetic operations, etc. now support manual memory management
  * New chroma key filter based on Euclidean distance (`dlib.image.filters.chromakey.chromaKeyEuclidean`)
  * New edge detection filter based on morphological gradient (`dlib.image.filters.edgedetect.edgeDetectGradient`)
  * Several important bugfixes (image convolution, lanczos and bicubic resampling, wrong deallocation of empty JPEGImage)
* dlib.core
  * Fixed erroneous deleting uninitialized thread in `dlib.core.thread`
* dlib.filesystem
  * Implemented missing methods in `dlib.filesystem.stdfs.StdFileSystem`: `openForIO`, `openDir`, `createDir`, `remove`. There is a known issue with `remove`: it doesn't delete directories under Windows
* Other improvements 
  * Added [HTML documentation generator](https://github.com/gecko0307/dlib/tree/master/gendoc).

dlib 0.7.1 - 2 Dec, 2015
------------------------
Mostly bugfix release.
* Fixed wrong iteration of `dlib.container.dict.Trie`
* `_allocatedMemory` in `dlib.core.memory` is now marked as `__gshared`, thus working correctly with `dlib.core.thread`
* Fixed wrong behaviour of `nextPowerOfTwo` in `dlib.math.utils`
* Ambiguous `rotation` functions in `dlib.math.affine` and `dlib.math.quaternion` are renamed into `rotation2D` and `rotationQuaternion`, respectively
* Added `flatten` method for matrices.

dlib 0.7.0 - 2 Oct, 2015
------------------------
Changes from beta:
* Fixed 64-bit issues
* dlib now compiles with latest LDC
* Continuous integration using Travis-CI: https://travis-ci.org/gecko0307/dlib

dlib 0.7.0 beta1 - 28 Sep, 2015
-------------------------------
* dlib.core
  * Added GC-free, Phobos-independent thread module - `dlib.core.thread`
* dlib.text
  * A new package for GC-free text processing. Includes UTF-8 decoder (`dlib.text.utf8`) and general-purpose lexical analyzer (`dlib.text.lexer`)
* dlib.xml
  * XML parser is now GC-free and based on `dlib.text.lexer`
* dlib.container
  * Added GC-free LinkedList (`dlib.container.linkedlist`), Stack (`dlib.container.stack`), Queue (`dlib.container.queue`)
* dlib.image
  * Fixed segfault with non-transparent indexed PNG loading
* dlib.math
  * Fixed error with instancing of vectors with size larger than 4
* Other improvements
  * Added Travis-CI support

dlib 0.6.4 - 14 Sep, 2015
-------------------------
* Trie-based GC-free dictionary class (`std.container.dict`)
* Several performance optimizations in `dlib.math`: vector element access and multiplication for 3x3 and 4x4 matrices are now faster
* Fixed some 64-bit issues.

dlib 0.6.3 - 17 Aug, 2015
-------------------------
* Fixed `dlib.filesystem.stdfs` compilation under 64-bit systems
* Fixed PNG exporter bug with encoding non-compressible images
* Added basic drawing functions (`dlib.image.render.shapes`)

dlib 0.6.2 - 20 Jul, 2015
-------------------------
Bugfix release.
* Removed coordinates clamping on pixel write in dlib.image
* Fixed bug with PNG vertical flipping

dlib 0.6.1 - 6 Jul, 2015
------------------------
* Added memory profiler
* Fixed `dlib.math.sse` compilation on 64-bit systems

dlib 0.6.0 - 24 Jun, 2015
-------------------------
* dlib.core
  * Got rid of ManuallyAllocatable interface in manual memory management for classes. Added support for deleting via interface or parent class. Deleting can be abstractized with Freeable interface
* dlib.filesystem
  * Added GC-free implementations for FileSystem and file streams
* dlib.image
  * dlib.image.unmanaged provides generalized GC-free Image class with corresponding factory function
  * JPEG decoder had been greatly improved, added more subsampling modes support, COM and APPn markers detection. Decoder now understands virtually any imaginable baseline JPEGs, including those from digital cameras
* dlib.math
  * New module dlib.math.combinatorics with factorial, hyperfactorial, permutation, combinations, lucas number and other functions
  * dlib.math.sse brings x86 SSE-based optimizations for some commonly used vector and matrix operations, namely, 4-vector arythmetics, dot and cross product, 4x4 matrix multiplication.
* dlib.container
  * DynamicArray now supports indexing (as a syntactic sugar).

dlib 0.5.3 - 5 May, 2015
-----------------------
* Added Protobuf-style varint implementation (dlib.coding.varint)
* Streams are now ManuallyAllocatable
* Triangle struct in dlib.geometry.triangle now has tangent vectors
* Fixed unittest build failure (#59)

dlib 0.5.2 - 25 Feb, 2015
-------------------------
* Automated vector type conversion (#57), modulo operator for vectors (#58)
* Fixed warning in dlib.image.io.bmp (#56)

dlib 0.5.1 - 21 Feb, 2015
-------------------------
Small bugfix release:
* Fixed wrong module name in dlib.geometry.frustum
* Updated license information

dlib 0.5.0 - 20 Feb, 2015
-------------------------
* dlib.core
  * Added manual memory management support. dlib.core.memory provide memory allocators based on standard C malloc/free. They can allocate arrays, classes and structs
  * Added prototype-based OOP system for structs (dlib.core.oop) with support for multiple inheritance and parametric polymorphism
* dlib.image
  * Image loaders are now GC-free
  * dlib.image.io.zlib and dlib.image.io.huffman modules are moved to new package dlib.coding. dlib.image.io.bitio moved to dlib.core.
  * Image allocation is based on a factory interface that abstracts over GC or MMM
  * Improved support for indexed PNGs - added alpha channel support
* dlib.container
  * Added GC-free dynamic array implementation (dlib.container.array)
  * BST and AArray now use manual memory management
* dlib.math
  * Quaternion is now based on and interchangeable with Vector via incapsulation
  * Dual quaternion support (dlib.math.dualquaternion)
  * Fixed incorrect dual number `pow` implementation
* dlib.geometry
  * Breaking change: Frustum plane normals are now pointing outside frustum. Also Frustum-AABB intersection API is changed
  * Fixed bugs in AABB and Plane

dlib 0.4.1 - 30 Dec, 2014
-------------------------
* dlib.image
  * Baseline JPEG decoder (dlib.image.io.jpeg)
* dlib.math
  * New matrix printer with proper alignment (a la Matlab)

dlib 0.4.0 - 27 Oct, 2014
-------------------------
* dlib.filesystem
  * Platform-specific modules are now grouped by corresponding packages (dlib.filesystem.windows, dlib.filesystem.posix)
  * `findFiles` is now a free function and can be used with any `ReadOnlyFileSystem`
* dlib.math
  * Implemented LU decomposition for matrices (dlib.math.decomposition)
  * `dlib.math.linear` is now `dlib.math.linsolve`. Added `solveLU`, a new LU-based direct solver
  * Matrix inversion now uses LU decomposition by default (4x performance boost compared to old analytic method). 4x4 affine matrices use an optimized inversion, which is about 6 times faster
  * `dlib.math.utils` now uses `clamp` from latest Phobos if available
  * Removed deprecated functionality
* dlib.core:
  * Moved container modules (bst, linkedlist, etc) from dlib.core to separate package dlib.container. Removed useless dlib.core.method
* Overall: improved compatibility with DMD 2.067.

dlib 0.3.3 - 31 Jul, 2014
-------------------------
Mainly bugfix release. Changes:
* Fixed compilation with DMD 2.066
* Added dlib.geometry.frustum
* Improved dlib.math.quaternion

dlib 0.3.2 - 11 Jun, 2014
-------------------------
Bugfix release. The main improvement is fixed compilation with some versions of LDC.

dlib 0.3.1 - 13 May, 2014
-------------------------
Bugfix release. Changes:
* Improved dlib.image, added interpolated pixel reading
* Added matrix addition and subtraction, tensorProduct now works with any matrix sizes
* Addressed many bugs in dlib.image and dlib.math.

dlib 0.3.0 - 25 Mar, 2014
-------------------------
* dlib.core
  * Added simple yet robust I/O streams (dlib.core.stream), which are completely Phobos-independent
* dlib.filesystem
  * Abstract FS interface and it's implementations for Windows and POSIX filesystems
* dlib.image
  * Breaking change: all pixel I/O is now floating-point (via `Color4f`). This gives an opportunity to define image classes of arbitrary floating-point pixel formats and enables straightforward HDRI: sample 32-bit implementation provided in dlib.image.hdri
  * Pixel iteration now can be done with `row` and `col` ranges
  * Parallel filtering is now easy with dlib.image.parallel. You can add multithreading to your existing filter code with just a few changes
  * Added support for TGA and BMP formats (only loading for now)
  * All image format I/O is now stream-based
* dlib.math
  * Breaking change: matrices in dlib.math.matrix are now column-major
  * Imporved constness support in dlib.math.vector, as well as added unittest to the module. Using new string constructor, vectors now can be parsed from strings (e.g., `"[0, 1, 2]"`)
* Overall improvements & bugfixes
  * Much saner DUB support, addressed some serious problems with building, added configuration for pre-compiling as a static library

dlib 0.2.4 - 12 Dec, 2013
-------------------------
Bugfix release + added support for DMD 2.064 package modules.

dlib 0.2.3 - 6 Dec, 2013
------------------------
Bugfix release. Fixed issues with compiling on 64-bit systems.

dlib 0.2.1 - 20 Nov, 2013
-------------------------
Bugfix release.

dlib 0.2.0 - 11 Oct, 2013
-------------------------
* Added XML parser (alpha quality);
* Massive refactoring of the matrix implementation. All matrix types (Matrix2x2f, Matrix3x3f, Matrix4x4f) are now specializations of generic Matrix!(T,N) struct in dlib.math.matrix;
* Updated dlib.math.dual. Vectors of dual numbers can now be created;
* Added support for Hermite curves (dlib.geometry.hermite).

dlib 0.1.2 - 18 Jul, 2013
-------------------------
* Renamed ColorRGBA and ColorRGBAf into Color4 and Color4f;
* Added support for image convolution. There are several built-in kernels (Identity, BoxBlur, GaussianBlur, Sharpen, Emboss, EdgeEmboss, EdgeDetect, Laplace);
* Added support for HSV color space;
* Added Chroma Keying and Color Pass filters.

dlib 0.1.1 - 13 Jul, 2013
-------------------------
Bugfix release.

dlib 0.1.0 - 13 Jul, 2013
-------------------------
Initial release.

13 Jul, 2013
-----------
Project moved to GitHub.

2012-2013
---------
Early development on code.google.com.

28 Sep, 2012
------------
Project started.

