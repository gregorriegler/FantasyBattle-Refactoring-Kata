package codingdojo;

import org.junit.Ignore;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.junit.Assert.*;

public class PlayerTest {

    // choose this one if you are not familiar with mocks
    @Test
    public void damageCalculations() {
        Item leftHand = new BasicItem(0, 1);
        Item rightHand = new BasicItem(1, 1);
        Item head = new BasicItem(1, 1);
        Item feed = new BasicItem(1, 1);
        Item chest = new BasicItem(1, 1);
        Equipment equipment = new Equipment(leftHand, rightHand, head, feed, chest);
        Stats stats = new Stats(0);
        SimpleEnemy target = createSimpleEnemy();
        Damage damage = new Player(equipment, stats).calculateDamage(target);
        assertEquals(10, damage.getAmount());
    }

    private SimpleEnemy createSimpleEnemy() {
        Armor armor = new SimpleArmor(5);
        List<Buff> buffs = Arrays.asList(new BasicBuff(1f, 1f));
        return new SimpleEnemy(armor, buffs);
    }
}