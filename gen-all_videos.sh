cur_date=$(date +%s)
mkdir -p tmp
OD1="tmp/rand_vids_$(cur_date)_1"
OD2="tmp/rand_vids_$(cur_date)_2"
OD3="tmp/rand_vids_$(cur_date)_3"
OD4="tmp/rand_vids_$(cur_date)_4"
OD5="tmp/rand_vids_$(cur_date)_5"
OD6="tmp/rand_vids_$(cur_date)_6"
tool_args="--mp4 --mp4-rand-size --safestart"
generation_args_1="--small --ignore-edge-intra-pred --ignore-ipcm --config config/default.json"
generation_args_2="--ignore-edge-intra-pred --ignore-ipcm --config config/chrome.json --small"
generation_args_3="--small --include-undefined-nalus --ignore-edge-intra-pred --ignore-ipcm --config config/narrower.json"
RUST_BACKTRACE=1

echo "Saving log to $output_dir/rand_100.log"

mkdir -p $OD1
mkdir -p $OD2
mkdir -p $OD3
mkdir -p $OD4
mkdir -p $OD5
mkdir -p $OD6
for i in $(seq -f "%04g" 0 139); do
    cmd="./h26forge $tool_args generate $generation_args_1 -o $OD1/video.$cur_date.$i.1.1.264"
    $cmd

    cmd="./h26forge $tool_args generate $generation_args_2 -o $OD2/video.$cur_date.$i.1.2.264"
    $cmd
    cmd="./h26forge $tool_args generate $generation_args_3 -o $OD3/video.$cur_date.$i.1.3.264"
    $cmd

    cmd="./h26forge $tool_args generate $generation_args_1 --seed 3452211 -o $OD4/video.$cur_date.$i.2.1.264"
    $cmd
    cmd="./h26forge $tool_args generate $generation_args_2 --seed 234132 -o $OD5/video.$cur_date.$i.2.2.264"
    $cmd
    cmd="./h26forge $tool_args generate $generation_args_3 --seed 91324 -o $OD6/video.$cur_date.$i.2.3.264"
    $cmd
done

for filename in $OD1/*.264 $OD1/*.mp4 $OD2/*.264 $OD2/*.mp4 $OD3/*.264 $OD3/*.mp4 $OD4/*.264 $OD4/*.mp4 $OD5/*.264 $OD5/*.mp4 $OD6/*.264 $OD6/*.mp4; do
  fsize=$(wc -c <"${filename}")
  if [ $fsize -ge 1000000 ]; then
    echo "Large file: removing it"
    echo $filename
    echo $fsize
    rm $filename
  fi
done

zip -r tmp/output1.zip $OD1
zip -r tmp/output2.zip $OD2
zip -r tmp/output3.zip $OD3
zip -r tmp/output4.zip $OD4
zip -r tmp/output5.zip $OD5
zip -r tmp/output6.zip $OD6

echo "Log saved to $output_dir/rand_100.log"
