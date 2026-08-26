use std::collections::HashMap;
use std::path::PathBuf;

use duct::cmd;
use serde::Deserialize;

pub struct Flake
{
    pub path: PathBuf,
    pub output: FlakeOutput
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FlakeOutput
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
    pub fn load(directory: PathBuf) -> anyhow::Result<Self>
    {
        let show_output = cmd!("nix", "flake", "show", &directory, "--json").read()?;

        let flake_output: FlakeOutput = serde_json::from_str(&show_output)?;

        let flake = Flake {
            path: directory,
            output: flake_output
        };

        Ok(flake)
    }
}
