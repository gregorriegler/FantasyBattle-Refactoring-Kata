module Item where

import Prelude

data Item =
  BasicItem
    { name :: String
    , baseDamage :: Int
    , damageModifier :: Number
    }

getBaseDamage :: Item -> Int
getBaseDamage (BasicItem { baseDamage }) = baseDamage

getDamageModifier :: Item -> Number
getDamageModifier (BasicItem { damageModifier }) = damageModifier



getStuff :: (Item -> Int) -> Item -> Int
getStuff fn item = 
  item 
    # fn
