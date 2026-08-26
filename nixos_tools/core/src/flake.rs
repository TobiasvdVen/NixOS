use std::collections::HashMap;
use std::path::Path;

use duct::cmd;
use serde::Deserialize;

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Flake
{
    pub nixos_configurations: HashMap<String, NixosConfiguration>
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct NixosConfiguration
{
    pub r#type: String
}

impl Flake
{
    pub fn load(directory: impl AsRef<Path>) -> anyhow::Result<Self>
    {
        let output = cmd!("nix", "flake", "show", directory.as_ref(), "--json").read()?;

        let flake: Flake = serde_json::from_str(&output)?;

        Ok(flake)
    }
}
