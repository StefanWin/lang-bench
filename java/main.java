import java.nio.file.Files;
import java.nio.file.Paths;

class main {
  public static void main(String[] args) throws Exception {
    byte[] data = Files.readAllBytes(Paths.get("../img.raw"));
    byte[] data_copy = new byte[data.length];
    long start = System.currentTimeMillis();
    for(int i = 0; i < data.length; i += 3) {
      byte r = data[i];
      byte g = data[i+1];
      byte b = data[i+2];
      data_copy[i] = r;
      data_copy[i+1] = g;
      data_copy[i+2] = b;
    }
    long end = System.currentTimeMillis();
    System.out.printf("took %dms\n", end-start);
    Files.write(Paths.get("./img_java.raw"), data_copy);
  }
}