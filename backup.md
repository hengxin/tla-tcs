PrepareAck(t, s) ==
    /\ s = Coord[t]
\*    /\ \A shard \in TSharding(t): \E m \in msg:
\*        /\ m.type = "PREPARE_ACK"
\*        /\ m.s = shard
\*        /\ m.t = t
