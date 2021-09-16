import std;
import std.datetime.stopwatch;

void main() {
  auto stopWatch = StopWatch(AutoStart.no);
  stopWatch.start();
  avgGreyscale();
  stopWatch.stop();
  writefln("Avg. Greyscaling took: %d ms.", stopWatch.peek.total!"msecs");
  stopWatch.reset();
  stopWatch.start();
  percGreyscale();
  stopWatch.stop();
  writefln("Perc. Greyscaling took: %d ms.", stopWatch.peek.total!"msecs");
  percGreyscale();
}

void avgGreyscale() {
  // Creating the file handle.
  auto f = File("../img.raw", "r");
  // Getting size of the file.
  auto fileSize = f.size;
  // Create buffer for file and reading it.
  auto buff = f.rawRead(new ubyte[fileSize]);
  auto target = new ubyte[fileSize];

  // The algorithm.
  int i = 0;
  foreach (rgb; buff.slide(3,3)) {
    int avg = (rgb[0].to!int + rgb[1].to!int + rgb[2].to!int) / 3;
    target[i]     = avg.to!ubyte;
    target[i + 1] = avg.to!ubyte;
    target[i + 2] = avg.to!ubyte;
    i += 3;
  }

  // Writing to file.
  auto destFile = File("./img_dlang.raw", "w");
  destFile.rawWrite(target);
}

void percGreyscale() {
  // Creating the file handle.
  auto f = File("../img.raw", "r");
  // Getting size of the file.
  auto fileSize = f.size;
  // Create buffer for file and reading it.
  auto buff = f.rawRead(new ubyte[fileSize]);
  auto target = new ubyte[fileSize];

  // The algorithm.
  int i = 0;
  foreach (rgb; buff.slide(3,3)) {
    float r = rgb[0].to!float * 0.2126;
    float g = rgb[1].to!float * 0.7152;
    float b = rgb[2].to!float * 0.0722;
    ubyte value = (r + g + b).to!ubyte;
    target[i]     = value;
    target[i + 1] = value;
    target[i + 2] = value;
    i += 3;
  }

  // Writing to file.
  auto destFile = File("./img_dlang.raw", "w");
  destFile.rawWrite(target);
}
