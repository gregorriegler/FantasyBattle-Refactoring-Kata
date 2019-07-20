package codingdojo;

import java.util.List;

public class SimpleEnemy extends Target {

    private Armor armor;
    private List<Buff> buffs;

    public SimpleEnemy(Armor armor, List<Buff> buffs) {
        this.armor = armor;
        this.buffs = buffs;
    }

    @Override
    protected int getSoak(int totalDamage) {
        return Math.round(
            this.armor.getDamageSoak() *
            (
                ((float) buffs
                    .stream()
                    .mapToDouble(Buff::soakModifier)
                    .sum()) +
                1f
            )
        );
    }
}
