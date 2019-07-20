package codingdojo;


class Player extends Target {
    private Inventory inventory;
    private Stats stats;

    Player(Inventory inventory, Stats stats) {
        this.inventory = inventory;
        this.stats = stats;
    }

    Damage calculateDamage(Target target) {
        int totalDamage = getTotalDamage();
        int soak = target.getSoak(totalDamage);
        return new Damage(Math.max(0, totalDamage - soak));
    }

    private int getTotalDamage() {
        int baseDamage = inventory.getBaseDamage();
        float damageModifier = stats.getStrengthModifier() + inventory.getDamageModifier();
        return Math.round(baseDamage * damageModifier);
    }

    @Override
    protected int getSoak(int totalDamage) {
        // TODO: Not implemented yet
        //  Add friendly fire
        return totalDamage;
    }

}
