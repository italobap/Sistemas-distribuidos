
for i in {0..3}
do
    echo "python raft.py $i "
    python  raft.py "$i" &
done
wait
