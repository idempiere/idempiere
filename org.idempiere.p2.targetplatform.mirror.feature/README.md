# How to Update feature.xml
* Setup iDempiere development workspace for Eclipse. The Eclipse workspace should have no build errors.
* Using the feature project wizard, create a new feature for the target platform. You will remove this project at the end so just give it an arbitrary name.
  * In the plugin selection page, the plugins listed are the ones in your target platform together with your workspace plugin projects. 
  * Select Initialize from the plugin list and Select all plugins.
  * De-select your workspace plugins(org.idempiere.*, org.adempiere.*, org.compiere.*, org.apache.ecs, etc).
  * De-select platform launcher plugins (macos, linux and win32).
  * At feature.xml editor, switch to Included Features tab and add org.eclipse.equinox.executable feature.
  * Replace includes and plugin entries in feature.xml with include and plugin entries from the newly created feature.xml.
  * Remove the newly created feature project.

