void main() {
  idiomatic_image_copy(); // around 20 ms on my machine
  og_image_copy(); // around 1 ms on my machine
}

void og_image_copy() {
  import std.stdio;
  import std.range;
  import std.algorithm;
  import std.datetime.stopwatch;

  auto stopWatch = StopWatch(AutoStart.no);
  
  // Creating the file handle.
  auto f = File("../img.raw", "r");
  // Getting size of the file.
  auto fileSize = f.size;
  // Create buffer for file and reading it.
  auto buff = f.rawRead(new ubyte[fileSize]);

  // Somehow other benchmarks started the timer after the file is loaded,
  // so do I now.
  stopWatch.start();

  // Create another empty buffer to copy the image to.
  auto cpBuff = new ubyte[fileSize];

  // OG iteration
  for(int i = 0; i < fileSize; i += 3) {   
    cpBuff[i]   =   buff[i];
    cpBuff[i+1] = buff[i+1];
    cpBuff[i+2] = buff[i+2];
  }
  // Stop the count!
  stopWatch.stop();
  
  // Print timer result.
  writefln("The OG image copy took: %d ms.", stopWatch.peek.total!"msecs"); 

  // Write file to disk, so we can confirm everything went fine.
  auto destFile = File("./img_dlang.raw", "w");
  destFile.rawWrite(cpBuff);
}

void idiomatic_image_copy() {
  import std.stdio;
  import std.range;
  import std.algorithm;
  import std.datetime.stopwatch;

  auto stopWatch = StopWatch(AutoStart.no);
  
  // Creating the file handle.
  auto f = File("../img.raw", "r");
  
  // Getting size of the file.
  auto fileSize = f.size;

  // Create buffer for file and reading it.
  auto buff = f.rawRead(new ubyte[fileSize]);

  // Somehow other benchmarks started the timer after the file is loaded,
  // so do I now.
  stopWatch.start();

  // Create another empty buffer to copy the image to.
  // Slower, but more idiomatic.
  ubyte[] cpBuff = [];
  buff.slide(3,3).each!(rgb => cpBuff ~= rgb);
  
  // Stop the count!
  stopWatch.stop();

  writefln("The idiomatic image copy took: %d ms.", stopWatch.peek.total!"msecs");

  // Write file to disk so we can confirm everything went fine.
  auto destFile = File("./img_dlang.raw", "w");
  destFile.rawWrite(cpBuff);
}
