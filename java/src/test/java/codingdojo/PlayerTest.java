package codingdojo;

import org.junit.Ignore;
import org.junit.Test;

import java.util.Arrays;
import java.util.Collections;

import static org.mockito.Mockito.*;
import static org.junit.Assert.*;

public class PlayerTest {

    // choose this one if you are familiar with mocks
    @Ignore("Test is not finished yet")
    @Test
    public void damageCalculationsWithMocks() {
        Inventory inventory = mock(Inventory.class);
        Stats stats = mock(Stats.class);
        SimpleEnemy target = mock(SimpleEnemy.class);

        Damage damage = new Player(inventory, stats).calculateDamage(target);
        assertEquals(10, damage.getAmount());
    }

    // Where	    What	                Base Damage	Damage Modifier Enemy
    // right hand	flashy sword of danger	10	        1.0
    @Test
    public void damageCalculations() {
        // TODO 3 Problem: We do not know the domain language Buff? Soak?
        // TODO 3 Problem: We see so many dependencies, we are not sure how to specify test 1
        Inventory inventory = new Inventory(createEquipment());

        // TODO Problem: Requirement does not state/define strength
        Stats stats = new Stats(10);
        SimpleEnemy target = simpleEnemy();
        Damage damage = new Player(inventory, stats).calculateDamage(target);
        // TODO 1 Problem: need to understand all calculations inside all dependencies to understand "10"
        assertEquals(10, damage.getAmount());
    }

    // SimpleEnemy has one Buff with a soakModifier of 1.0 and damage modifier of 1.0.
    // It wears an Armor with a Damage Soak of 5.
    private SimpleEnemy simpleEnemy() {
        return new SimpleEnemy(new SimpleArmor(5), Arrays.asList(new BasicBuff(1f, 1f)));
    }

    private Equipment createEquipment() {
        // 1. inventory needs equipment
        // 2. equipment needs items
        // TODO 2 Problem: we need to instantiate the whole tree of dependencies.
        return new Equipment(emptyItem(), new BasicItem(10, 1), emptyItem(), emptyItem(), emptyItem());
    }

    private BasicItem emptyItem() {
        return new BasicItem(0, 0);
    }
}