module Utils.Concur

import Concur.React.Run                     (runWidgetInDom)
import Concur.React.DOM                     (button, text)

-- TODO: add Reader to read which element id to use.

userError :: String -> Effect Unit
userError :: msg = do
  errorWidg <- userErrorWidget msg
  runWidgetInDom elemId errorWidg
  where
    elemId = "webgl2_error_div"

userErrorWidget :: String -> Widget HTML Unit
userErrorWidget :: msg = do
  button [onClick] [text "[X]", text msg]
