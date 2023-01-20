module Player where

import Prelude

import Armor (getDamageSoak) as Armor
import Buff (soakModifier) as Buff
import Damage (Damage(..))
import Data.Array (foldr) as Array
import Data.Int (round, toNumber)
import Inventory (Inventory, getBaseDamage) as Inventory
import SimpleEnemy (SimpleEnemy)
import Stats (Stats)
import Data.Newtype (unwrap)
import Equipment(getDamageModifier) as Equipment

type Player =
  { inventory :: Inventory.Inventory
  , stats :: Stats
  }

data Target
  = PlayerTarget Player
  | SimpleEnemyTarget SimpleEnemy

calculateDamage :: Target -> Player -> Damage
calculateDamage other player = Damage (max 0 (totalDamage - soak))
  where
  baseDamage = player # getBaseDamage
  damageModifier = player # getDamageModifier
  totalDamage = round (toNumber baseDamage * damageModifier)
  soak = player # getSoak other totalDamage

getBaseDamage :: Player -> Int
getBaseDamage player = player.inventory
    # Inventory.getBaseDamage


getDamageModifier :: Player -> Number
getDamageModifier player = strengthModifier
  + Equipment.getDamageModifier equipment
 
  where
  equipment = player.inventory
    # unwrap
    # _.equipment
  strengthModifier = toNumber player.stats.strength * 0.1

getSoak :: Target -> Int -> Player -> Int
getSoak target totalDamage _ = case target of
  PlayerTarget _ -> totalDamage
  SimpleEnemyTarget other -> round $
    (other.armor # Armor.getDamageSoak # toNumber) -- 2
      * (other.buffs <#> Buff.soakModifier # Array.foldr (+) 1.0) -- 2
          -- B1  0.5
          -- B2  0.5
          --        foldr: 1.0 + 0.5 + 0.5 = 2
