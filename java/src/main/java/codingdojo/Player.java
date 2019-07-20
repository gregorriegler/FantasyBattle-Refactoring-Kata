package codingdojo;


class Player extends Target {
    private Inventory inventory;
    private Stats stats;

    Player(Inventory inventory, Stats stats) {
        this.inventory = inventory;
        this.stats = stats;
    }

    Damage calculateDamage(Target other) {
        int totalDamage = getTotalDamage();

        int soak = getSoak(other, totalDamage);
        return new Damage(Math.max(0, totalDamage - soak));
    }

    private int getTotalDamage() {
        int baseDamage = inventory.getBaseDamage();
        float damageModifier = stats.getStrengthModifier() + inventory.getDamageModifier();
        return Math.round(baseDamage * damageModifier);
    }

    private int getSoak(Target other, int totalDamage) {
        return other.getSoak(totalDamage);
    }

    @Override
    protected int getSoak(int totalDamage) {
        // TODO: Not implemented yet
        //  Add friendly fire
        return totalDamage;
    }

}
