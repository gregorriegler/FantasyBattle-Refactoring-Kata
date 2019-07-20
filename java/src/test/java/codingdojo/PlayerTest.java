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

    // Where	    What	                Base Damage	Damage Modifier
    //right hand	flashy sword of danger	10	        1.0
    @Test
    public void damageCalculations() {
        Inventory inventory = new Inventory(createEquipment());
        Stats stats = new Stats(0);
        SimpleEnemy target = new SimpleEnemy(new SimpleArmor(0), Collections.emptyList());
        Damage damage = new Player(inventory, stats).calculateDamage(target);
        assertEquals(10, damage.getAmount());
    }

    private Equipment createEquipment() {
        return new Equipment(emptyItem(), emptyItem(), emptyItem(), emptyItem(), emptyItem());
    }

    private BasicItem emptyItem() {
        return new BasicItem(0, 0);
    }
}