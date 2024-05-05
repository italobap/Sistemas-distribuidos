
for i in {0..3}
do
    python  raft.py "$i" &
done
 echo "Nodes Initialized"
wait
