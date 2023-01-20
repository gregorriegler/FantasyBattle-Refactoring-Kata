module Equipment where

import Prelude -- need this for the +
import Item (Item, getBaseDamage, getDamageModifier) as Item
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

getDamageModifier :: Equipment -> Number
getDamageModifier _equipment = 0.0
  + Item.getDamageModifier leftHand
  + Item.getDamageModifier rightHand
  + Item.getDamageModifier head
  + Item.getDamageModifier feet
  + Item.getDamageModifier chest
  where
  equipment = unwrap _equipment
  leftHand = equipment.leftHand
  rightHand = equipment.rightHand
  head = equipment.head
  feet = equipment.feet
  chest = equipment.chest

-- data Allowed = Int | Number

-- eachItem Allowed :: (f :: Item -> a) -> Equipment -> a
-- getDamageModifier _equipment = f leftHand + f rightHand + f head + f feet + f chest
--   where
--   equipment = unwrap _equipment
--   leftHand = equipment.leftHand
--   rightHand = equipment.rightHand
--   head = equipment.head
--   feet = equipment.feet
--   chest = equipment.chest
