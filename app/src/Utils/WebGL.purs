module Utils.WebGL

import WebGL.Raw.WebGL2

import Utils.Concur (userError)

{-
  This license applies to to the following functions in this file:
  - loadShader

/*
 * Copyright 2012, Gregg Tavares.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following disclaimer
 * in the documentation and/or other materials provided with the
 * distribution.
 *     * Neither the name of Gregg Tavares. nor the names of his
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

-}

loadShader :: forall c . IsWebGLRenderingContext c =>
  c -> String -> GLenum -> (String -> Effect Unit)
  -> Effect (Either String WebGLShader)
loadShader glCxt source shaderType errorFn = do
  -- Create the shader object
  shaderMay <- createShader shaderType
  shader <- case shaderMay of -- FIXME unimplemented logic

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

