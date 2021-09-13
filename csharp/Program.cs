using System;
using System.IO;
using System.Diagnostics;
namespace csharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var data = File.ReadAllBytes("../img.raw");
            var dataCopy = new byte[data.Length];
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            for(int i = 0; i < data.Length; i += 3)
            {
                var r = data[i];
                var g = data[i+1];
                var b = data[i+2];

                dataCopy[i] = r;
                dataCopy[i+1] = g;
                dataCopy[i+2] = b;
            }
            stopwatch.Stop();
            var ts = stopwatch.ElapsedMilliseconds;
            Console.WriteLine("took " + ts + "ms");

            File.WriteAllBytes("./img_cs.raw", dataCopy);
        }
    }
}
