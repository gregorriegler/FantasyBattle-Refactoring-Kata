package codingdojo;

import java.util.List;

public class BuffList {

    private List<Buff> buffs;

    public BuffList(List<Buff> buffs) {
        this.buffs = buffs;
    }

    public float buffModifier() {
        return ((float) buffs.stream()
            .mapToDouble(Buff::soakModifier)
            .sum()) +
            1f;
    }
}
