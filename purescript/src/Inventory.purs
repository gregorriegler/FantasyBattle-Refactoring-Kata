module Inventory where

import Prelude -- #

import Equipment (Equipment, getBaseDamage) as Equipment

import Data.Newtype (class Newtype, unwrap)

newtype Inventory = Inventory { equipment :: Equipment.Equipment }
derive instance Newtype Inventory _

getBaseDamage :: Inventory -> Int
getBaseDamage _inventory = _inventory
    # unwrap
    # _.equipment
    # Equipment.getBaseDamage
