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
                getSoakModifier()
        );
    }

    private float getSoakModifier() {
        return soakModifier() +
        1f;
    }

    private float soakModifier() {
        // TODO make a first class collection and move this method there.
        return (float) buffs
            .stream()
            .mapToDouble(Buff::soakModifier)
            .sum();
    }
}
