# h26forge-seeds


Generate seeds that can be used for fuzzing h264 decoders.

This relies on https://github.com/h26forge/h26forge

To build and generate seeds:

```sh
$ git clone https://github.com/DavidKorczynski/h26forge-seeds
$ cd h264forge-seeds

$ git clone https://github.com/h26forge/h26forge
$ cd h264forge
$ ./make.sh

$ cp gen-all_videos.sh .
$ ./gen-all-videos.sh

# Seeds are no places in `tmp/`, including zipped corpuses
$ ls tmp/
output1.zip  output2.zip  output3.zip  output4.zip  output5.zip  output6.zip  rand_vids__1  rand_vids__2  rand_vids__3  rand_vids__4  rand_vids__5  rand_vids__6
```
