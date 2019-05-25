{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "purescript-webgl2-playground-test"
, dependencies = [
    "debug"
  , "foreign"
  , "psci-support"
  , "purescript-webgl2-playground"
  , "test-unit"
  ]
, packages =
    (../packages.dhall) //
    { purescript-webgl2-playground =
        { repo = "../app"
        , version = ""
        , dependencies = (../app/spago.dhall).dependencies
        }
    }

}
