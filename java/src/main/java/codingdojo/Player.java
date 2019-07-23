package codingdojo;


class Player extends Target {
    private Equipment equipment;
    private Stats stats;

    Player(Equipment equipment, Stats stats) {
        this.equipment = equipment;
        this.stats = stats;
    }

    Damage calculateDamage(Target other) {
        int totalDamage = Math.round(baseDamage() * damageModifier());
        int soak = other.soak(totalDamage);
        return new Damage(Math.max(0, totalDamage - soak));
    }

    @Override
    protected int soak(int totalDamage) {
        return totalDamage;
    }

    private float damageModifier() {
        return equipment.damageModifier(stats.damageModifier());
    }

    private int baseDamage() {
        return equipment.baseDamage();
    }

}
