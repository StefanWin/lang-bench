# img-scaling
A benchmark to test different programming languages because I'm bored.

## Implemented Languages:
- `golang 1.16`
- `rust-lang v1.55.0`
- `typescript 4.4.3`
- `java jdk16`
- `<your_language_here>`

### Files:
The test file `img.raw` is a `920x404` raw image.  
It's 24 BPP (3 bytes per pixel), has `RGB` ordering and is interleaved (`R G B R G B ...`).  
To read it you should use the `unsigned byte` type (e.g. `uint8_t`, `u8`, `byte` etc.).  
You can open the raw images with [irfanview](https://www.irfanview.com/).

Currently the test just reads the file to a buffer, creates a new buffer with the same length,  
iterates over the source buffer in steps of 3 and copies the `RGB` values to the new buffer.  

The plan is to implement various image algorithms such as:  
- grayscaling
- inverting colors
- mean upscaling
- bilinear upscaling
- etc.


## Results:
Run on a `AMD Ryzen 2600` at stock clocks.

| `lang` | `ms`  | `cmd` |
| ------ | ----- | ----- |
| `rust` | `0ms` | `cargo build --release && ./bin` |
| `go`   | `0ms` | `go build && ./bin` |
| `c#`   | `3ms` | `dotnet run` |
| `ts`   | `4ms` | `ts-node` |
| `java` | `6ms` | `javac && java` |
