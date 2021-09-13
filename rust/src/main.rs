use std::fs;
use std::time::Instant;

fn main() {
    let src_buf = fs::read("../img.raw").expect("file not found");

    let mut dst_buf: Vec<u8> = vec![0; src_buf.len()];

    let mut i = 0;
    let start = Instant::now();
    while i < src_buf.len() {
        let r = src_buf[i];
        let g = src_buf[i + 1];
        let b = src_buf[i + 2];

        dst_buf[i] = r;
        dst_buf[i + 1] = g;
        dst_buf[i + 2] = b;
        i += 3;
    }
    println!("took {}ms", start.elapsed().as_millis());
    fs::write("./img_rs.raw", dst_buf).expect("file not writeable");
}
