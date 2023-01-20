module Test.Main where

import Prelude

import Damage (Damage(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Item (Item(..))
import Player (Target(..), calculateDamage)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Reporter.TeamCity (teamcityReporter)
import Test.Spec.Runner (runSpec)
import Inventory (Inventory(..))
import Equipment (Equipment(..))
import Armor (Armor(..))
import Buff (Buff(..))
import SimpleEnemy (SimpleEnemy)

main :: Effect Unit
main = launchAff_ $ runSpec [ consoleReporter, teamcityReporter ] do
  describe "player" do
    it "does no damage to itself" do
      let
        noItem = BasicItem { name: "useless", baseDamage: 0, damageModifier: 0.0 }
        equipment = Equipment
          { leftHand: noItem
          , rightHand: noItem
          , head: noItem
          , chest: noItem
          , feet: noItem
          }
        inventory = Inventory { equipment }
        stats = { strength: 1 }
        player = { inventory, stats }
        noDamage = Damage 0
      player
        # calculateDamage (PlayerTarget player)
        # shouldEqual noDamage

-- Is strength added to damage? Yes!
-- Is armor soaking strength damage? We believe yes.
-- Why was it 6
    it "damages an enemy" do
      let
        noItem = BasicItem { name: "useless", baseDamage: 0, damageModifier: 0.0 }
        sword = BasicItem { name: "sword", baseDamage: 10, damageModifier: 1.0 }
        equipment = Equipment
          { leftHand: sword
          , rightHand: noItem
          , head: noItem
          , chest: noItem
          , feet: noItem
          }
        inventory = Inventory { equipment }
        stats = { strength: 1 }
        player = { inventory, stats }
        enemy = createEnemy 2 -- armor soak
      player
        # calculateDamage (SimpleEnemyTarget enemy)
        # shouldEqual (Damage 7)

createEnemy :: Int -> SimpleEnemy
createEnemy armorSoak = { armor: armor, buffs: buffs }
  where
  armor = SimpleArmor { soak: armorSoak }
  buffs = [ BasicBuff { soak: 0.5, damage:1.0 }, BasicBuff { soak: 0.5, damage:1.0 } ] -- buff: soaks are added to 1, and multiplied by armor soak
