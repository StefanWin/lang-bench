# lang-bench
A benchmark to test different programming languages because I'm bored.

## Implemented Languages:
- `golang 1.16`
- `rust-lang v1.55.0`
- `typescript 4.4.3`
- `java jdk16`
- `D DMD v2.097.2`
- `D LDC v1.27.1`
- `SBCL 2.1.7`
- `<your_language_here>`

### Files:
The test file `img.raw` is a `920x404` raw image.  
It's 24 BPP (3 bytes per pixel), has `RGB` ordering and is interleaved (`R G B R G B ...`).  
To read it you should use the `unsigned byte` type (e.g. `uint8_t`, `u8`, `byte` etc.).  
You can open the raw images with [irfanview](https://www.irfanview.com/).
If you are under Linux you can use [rawpixels.net](https://rawpixels.net/).

Currently the test just reads the file to a buffer, creates a new buffer with the same length,  
iterates over the source buffer in steps of 3 and copies the `RGB` values to the new buffer.  

The plan is to implement various image algorithms such as:  
- grayscaling
- inverting colors
- mean upscaling
- bilinear upscaling
- etc.

## Testing
The measured time should only be the time it took apply the algorithm (includes allocation of `dst`).
This is to avoid IO bottlenecks.

## Proposed CLI
The first argument passed to the binary should be the algorithm name specified in the next section.
If run with no arguments or an unknown algorithm, the default should be `copy`.

## Implemented Algorithms
### `copy`
A simple buffer copy done in steps of 3.
### `avg_gray`
Grayscale the image by taking the average of the RGB value.
### `perc_gray`
Grayscale the image by some [magic numbers](https://en.wikipedia.org/wiki/Grayscale#Colorimetric_(perceptual_luminance-preserving)_conversion_to_grayscale) I don't understand.


| `algorithm` | `rust` | `go`   | `D DMD C` | `D LDC C` | `C#`   | `TS`   | `Java` |  `D DMD Id` | `D LDC Id` |
| ----------- | ------ | ------ | --------- | --------- | ------ | ------ | ------ | ----------- | ---------- |
| `copy`      |    x   |   x    |     x     |     x     |   x    |   x    |    x   |     x       |     x      |
| `avg_gray`  |    x   |        |           |           |        |        |        |             |            |
| `perc_gray` |    x   |        |           |           |        |        |        |             |            |

## Results:
Run on a `AMD Ryzen 2600` at stock clocks.
*Currently, the D and SBCL implementations are not tested under the same circumstances as the other implementations. The SBCL implementation timer is different because it also counts the time it takes to write the final image to the disk.*

| `lang`             | `ms`   | `cmd`                                                       |
|--------------------|--------|-------------------------------------------------------------|
| `rust`             | `0ms`  | `cargo build --release && ./bin`                            |
| `go`               | `0ms`  | `go build && ./bin`                                         |
| `D DMD C-Style`    | `0ms`  | `dmd -O -release -inline -boundscheck=off main.d && ./main` |
| `D LDC C-Style`    | `0ms`  | `ldc -O -release -boundscheck=off main.d`                   |
| `c#`               | `3ms`  | `dotnet run`                                                |
| `ts`               | `4ms`  | `ts-node`                                                   |
| `java`             | `6ms`  | `javac && java`                                             |
| `D LDC idiomatic`  | `10ms` | `ldc -O -release -boundscheck=off main.d && ./main`         |
| `D DMD idiomatic`  | `13ms` | `dmd -O -release -inline -boundscheck=off main.d && ./main` |
| `Common Lisp SBCL` | `15ms` | `sbcl --script main.lisp`                                   |

