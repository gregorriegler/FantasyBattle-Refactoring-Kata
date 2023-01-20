module Equipment where

import Prelude -- need this for the +
import Item (Item, getBaseDamage) as Item
import Data.Newtype (class Newtype, unwrap)

newtype Equipment = Equipment
  { leftHand :: Item.Item
  , rightHand :: Item.Item
  , head :: Item.Item
  , feet :: Item.Item
  , chest :: Item.Item
  }
derive instance Newtype Equipment _

getBaseDamage :: Equipment -> Int
getBaseDamage _equipment = 0 
  + Item.getBaseDamage leftHand
  + Item.getBaseDamage rightHand
  + Item.getBaseDamage head
  + Item.getBaseDamage feet
  + Item.getBaseDamage chest
  where
  equipment = unwrap _equipment
  leftHand = equipment.leftHand
  rightHand = equipment.rightHand
  head = equipment.head
  feet = equipment.feet
  chest = equipment.chest
