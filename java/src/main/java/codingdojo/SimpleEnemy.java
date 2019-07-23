package codingdojo;

import java.util.List;

public class SimpleEnemy extends Target {

    private Armor armor;
    private BuffList buffs;

    public SimpleEnemy(Armor armor, List<Buff> buffs) {
        this.armor = armor;
        this.buffs = new BuffList(buffs);
    }

    @Override
    public int soak(int totalDamage) {
        return Math.round(armor.getDamageSoak() * buffModifier());
    }

    private float buffModifier() {
        return buffs.buffModifier();
    }
}
