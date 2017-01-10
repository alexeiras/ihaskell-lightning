module IHaskell.Display.Lightning
  (
    -- * Displayable Lightning visualization instance
    Lgn(..)
    -- * Re-exports
  , module Web.Lightning
  , module Web.Lightning.Plots
  ) where

import           IHaskell.Display

import           Control.Monad.IO.Class

import           Network.HTTP.Client
import           Network.HTTP.Client.TLS

import qualified Data.ByteString.Lazy              as BS
import qualified Data.Text                         as T
import           Data.Text.Encoding                (decodeUtf8)
import           IHaskell.Display.Blaze            ()
import qualified Text.Blaze.Html                   as BZ

import           Web.Lightning
import           Web.Lightning.Plots
import           Web.Lightning.Types
import           Web.Lightning.Types.Visualization (getPublicLink)

data Lgn = Lgn { options :: LightningOptions, lightning :: Lightning Visualization }

instance IHaskellDisplay Lgn where
  display lgn = do
    (Right viz) <- runLightningWith (options lgn) (lightning lgn)
    renderVizHtml viz

renderVizHtml :: Visualization -> IO Display
renderVizHtml viz = do
  manager <- liftIO $ newManager tlsManagerSettings
  req <- parseRequest $ T.unpack $ getPublicLink viz
  vizHtml <- httpLbs req manager
  display $ BZ.preEscapedToMarkup $
    decodeUtf8 $ BS.toStrict $ responseBody vizHtml
