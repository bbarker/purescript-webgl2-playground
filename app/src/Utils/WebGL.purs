module Utils.WebGL

import WebGL.Raw.WebGL2

import Utils.Concur (userError)

loadShader :: forall c . IsWebGLRenderingContext c =>
  c -> String -> GLenum -> (String -> Effect Unit)
  -> Effect (Either String WebGLShader)
loadShader glCxt source shaderType errorFn = do
  -- Create the shader object
  shaderE <- (note "Couldn't create shader") <$> createShader shaderType
  shader <- -- FIXME unimplemented logic
  -- FIXME: I think we need to use monad transformers

  -- Load the shader source
  shaderSource glCxt shader source

  -- Compile the shader
  compileShader glCxt shader

  -- Check the compilation status
  compiledMay <- getShaderParameterGLboolean shader gl_COMPILE_STATUS
  case compiledMay of
    Just true -> pure $ Right shader
    Just false -> do
      sErr <- lastShaderError glCxt shader
      Left "Compiled failed: " <> sErr
    Nothing -> do
      sErr <- lastShaderError glCxt shader
      Left "Unknown Compilation status: " <> sErr
  where
    handleCompileErr String -> Effect (Left String)
    handleCompileErr errPfx = do
      sErr <- lastShaderError glCxt shader
      deleteShader glCxt (Just shader)
      Left errPfx <> sErr



-- TODO: use JS object representation to also print shader itself in msg
lastShaderError :: forall c . IsWebGLRenderingContext c =>
  c -> WebGLShader -> Effect String
lastShaderError glCxt shader = do
  lastErrMay <- getShaderInfoLog glCxt shader
  pure $ case lastErrMay of
    Nothing -> "No last error"
    Just le -> le

