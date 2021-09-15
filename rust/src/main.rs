use std::env;
use std::fs;
use std::time::Instant;
use std::vec::Vec;

// plain copying the buffer in steps of 3
fn plain_copy(src_buf: &Vec<u8>) -> Vec<u8> {
    let mut dst_buf: Vec<u8> = vec![0; src_buf.len()];
    let mut i = 0;
    while i < src_buf.len() {
        dst_buf[i] = src_buf[i];
        dst_buf[i + 1] = src_buf[i + 1];
        dst_buf[i + 2] = src_buf[i + 2];
        i += 3;
    }
    return dst_buf;
}

// compute grayscale version using average values
fn avg_gray_scale(src_buf: &Vec<u8>) -> Vec<u8> {
    let mut dst_buf: Vec<u8> = vec![0; src_buf.len()];
    let mut i = 0;
    while i < src_buf.len() {
        let r = src_buf[i];
        let g = src_buf[i + 1];
        let b = src_buf[i + 2];
        let sum = u8::saturating_add(u8::saturating_add(r, g), b);
        let avg = sum / 3;
        dst_buf[i] = avg;
        dst_buf[i + 1] = avg;
        dst_buf[i + 2] = avg;
        i += 3;
    }
    return dst_buf;
}

// compute grayscale using perceptual magic constants
// https://en.wikipedia.org/wiki/Grayscale#Colorimetric_(perceptual_luminance-preserving)_conversion_to_grayscale
fn perc_gray_scale(src_buf: &Vec<u8>) -> Vec<u8> {
    let mut dst_buf: Vec<u8> = vec![0; src_buf.len()];
    let mut i = 0;
    while i < src_buf.len() {
        let r = src_buf[i] as f32 * 0.2126;
        let g = src_buf[i + 1] as f32 * 0.7152;
        let b = src_buf[i + 2] as f32 * 0.0722;
        let val = (r + g + b) as u8;
        dst_buf[i] = val;
        dst_buf[i + 1] = val;
        dst_buf[i + 2] = val;
        i += 3;
    }
    return dst_buf;
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut alg: &String = &String::from("copy"); 
    if args.len() > 1 {
        alg = &args[1];
    }

    let func: fn(&Vec<u8>) -> Vec<u8> = match &alg[..] {
        "copy" => plain_copy,
        "avg_gray" => avg_gray_scale,
        "perc_gray" => perc_gray_scale,
        _ => plain_copy,
    };

    let src_buf = fs::read("../img.raw").expect("file not found");
    let start = Instant::now();
    let dst_buf = func(&src_buf);
    let dur = start.elapsed().as_millis();
    println!("{} took {}ms", alg, dur);
    fs::write(format!("./img_rs_{}.raw", alg), dst_buf).expect("file not writeable");
}
