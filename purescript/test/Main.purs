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

    it "experiment with damage modifier" do
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
        armor = SimpleArmor { soak: 1 }
        buffs = [ BasicBuff { soak: 1.0, damage:1.0 } ]
        enemy = { armor: armor, buffs: buffs }
        noDamage = Damage 1
      player
        # calculateDamage (SimpleEnemyTarget enemy)
        # shouldEqual noDamage

