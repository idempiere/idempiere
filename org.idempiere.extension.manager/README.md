# iDempiere Extension Manager

**Summary:** A core infrastructure component introduced to simplify the lifecycle management of iDempiere extensions. It provides a centralized service to discover, validate, install, and update OSGi-based plugins and database extensions directly within the iDempiere environment.

## 🚀 Features

* **Centralized Registry:** Tracks all installed extensions and their current versions.
* **Dependency Resolution:** Automatically validates requirements and dependencies (like REST API or core modules) before installation.
* **Bundle Lifecycle Control:** Provides services to start, stop, and refresh extension bundles dynamically.
* **Metadata Integration:** Parses and processes `metadata.json` and `info.md` files to provide a rich UI experience for administrators.
* **Secure Downloads:** Manages secure retrieval of artifacts from remote repositories and verifies checksums.

## 📦 Database Changes

* **New Metadata Tables:** Introduces tables to store extension definitions, such as `AD_Extension`, and `AD_ExtensionEntity`.
* **System Config:** Adds new System Property `IDEMPIERE_EXTENSION_REPOSITORY` to define default extension repository URLs.

## 🛠 Usage & Configuration

* **Configuration:**
    1. Configure the **Extension Provider URL** using System Property to point to a compatible metadata repository.
    2. Accessed via the **Extension Management** form.
    3. View and manage installed extension at the **Extension Registry** window.
* **Installation:** Extensions can be searched and installed with a single click; the manager handles the download and bundle activation.
* **Updates:** The manager checks for newer versions based on the semantic versioning defined in the extension's `metadata.json`.
